%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %      
%   Copyright (C) 2011    Hong Chen                                           %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function parallel_polynomial_stage_init_xblock(m,n_inputs,polyphase,add_latency)

coeffs = cell(1,m+1);
for i = 1:m+1
    coeffs{i} = nchoosek(m,i-1);
end
coeff_const_blk = cell(1,m+1);  % need optimization
coeff_const = cell(1,m+1);
for i = 1:m+1
    coeff_const{i} = xSignal(['coeff_const',num2str(i)]);
    coeff_const_blk{i} = xBlock(struct('source', 'Constant', 'name', ['coeff_const',num2str(i)]), ...
                                     struct('arith_type', 'Unsigned', ...
                                            'const', coeffs{i}, ...
                                            'n_bits', m, ...
                                            'bin_pt', 0), ...
                                     {}, ...
                                     {coeff_const{i}});
end    
if n_inputs==1 % only one input
    inport = xInport('inport');
    outport = xOutport('outport');
    
    delays = cell(1,m);
    delay_in = cell(1,m+1);
    delay_in{1} = inport;
    for i = 1:m
        delay_in{i+1} = xSignal(['delay_in',num2str(i+1)]);
        delays{i} = xBlock(struct('source', 'Delay', 'name', ['Delay',num2str(i)]), ...
                              struct('latency', 1), ...
                              {delay_in{i}}, ...
                              {delay_in{i+1}});
    end
    
    mult_blks = cell(1,m+1);
    mult_out = cell(1,m+1);
    for i = 1:m+1
        mult_out{i} = xSignal(['mult_out',num2str(i)]);
        mult_blks{i} = xBlock(struct('source', 'Mult', 'name', ['mult',num2str(i)]), ...
                                        struct('latency',2), ...
                                        {delay_in{i}, coeff_const{i}}, ...
                                        {mult_out{i}});        
    end
    xlsub3_addertree = xBlock(struct('source', str2func('adder_tree_init_xblock'),'name', 'adder_tree'), ...
                             {m+1, add_latency, 'Round  (unbiased: +/- Inf)', 'Saturate', 'Behavioral'}, ...
                             [{},mult_out], ...
                             {{},outport});


elseif n_inputs>=4
    % assuming n_inputs>=4
    inports = cell(1,n_inputs);
    for i = 1:n_inputs,
        inports{i} = xInport(['inport',num2str(i)]);
    end
    sync = xInport('sync');


    outports = cell(1,n_inputs);
    for i=1:2:n_inputs,
        outports{i} = xOutport(['outport',num2str(i)]);
    end
    sync_out = xOutport('sync_out');

    % this whole thing could be more organized
    % by making a matrix
    if strcmp(polyphase,'off')
        % take care of the delay cases
        % need optimization (coefficient symmetric)
        dx_m = cell(1,m);
        xlsub3_delay = cell(1,m);
        dmult_m = cell(1,m);
        xlsub3_dmult = cell(1,m);
        for i=1:m
            dx_m{i} = xSignal(['delay_x_m_minus_',num2str(i-1)]);
            xlsub3_delay{i} = xBlock(struct('source', 'Delay', 'name', ['Delay',num2str(n_inputs-i+1)]), ...
                              struct('latency', 1), ...
                              {inports{n_inputs-i+1}}, ...
                              {dx_m{i}});
            dmult_m{i} = cell(1,m);
            xlsub3_dmult{i} = cell(1,m);
            for j = i:2:m
                dmult_m{i}{j} = xSignal(['multiplied_m_minus_',num2str(i-1),'_',num2str(j)]);
                xlsub3_dmult{i}{j} = xBlock(struct('source', 'Mult', 'name', ['dmult_m_minus_',num2str(i-1),'_',num2str(j)]), ...
                                        struct('latency',2), ...
                                        {dx_m{i}, coeff_const{j+1}}, ...
                                        {dmult_m{i}{j}});
            end
        end

        % take care of the non-delayed cases
        % need optimization (coefficient symmetric)
        % and there're redundants here
        x_i_n = cell(1,n_inputs);
        mult_i_n = cell(1,n_inputs);
        xlsub3_mult = cell(1,n_inputs);
        for i = 1:n_inputs-m
            x_i_n{i} = inports{i};
            mult_i_n{i} = cell(1,m);
            xlsub3_mult{i} = cell(1,m);
            oddeven = mod(i,2)+1;
            for j = oddeven:2:m
                mult_i_n{i}{j} = xSignal(['multplied_x_i_n',num2str(i),'_',num2str(j)]);
                xlsub3_mult{i}{j} = xBlock(struct('source', 'Mult', 'name', ['mult',num2str(i),'_',num2str(j)]), ...
                                        struct('latency',2), ...
                                        {x_i_n{i}, coeff_const{j+1}}, ...
                                        {mult_i_n{i}{j}});
            end
        end
        % compensating the delayed cases
        oddeven =  mod((n_inputs - m), 2);
        for i = n_inputs-m+1:n_inputs
            x_i_n{i} = inports{i};
            mult_i_n{i} = cell(1,(n_inputs-i));
            xlsub3_mult{i} = cell(1,(n_inputs-i));
            for j = oddeven:2:(n_inputs-i)
                mult_i_n{i}{j} = xSignal(['multplied_x_i_n',num2str(i),'_',num2str(j)]);
                xlsub3_mult{i}{j} = xBlock(struct('source', 'Mult', 'name', ['mult',num2str(i),'_',num2str(j)]), ...
                                        struct('latency',2), ...
                                        {x_i_n{i}, coeff_const{j+1}}, ...
                                        {mult_i_n{i}{j}});
            end
            if oddeven ==1
                oddeven = 2;
            else
                oddeven = 1;
            end
        end
        
        
        %for first column
        first_column = cell(1,n_inputs);
        first_column_mult = cell(1,n_inputs);
        for i = 1:n_inputs
            first_column{i} = xSignal(['first_column',num2str(i)]);
            first_column_mult{i} = xBlock(struct('source', 'Mult', 'name', ['first_column_mult',num2str(i)]), ...
                                        struct('latency',2), ...
                                        {inports{i}, coeff_const{1}}, ...
                                        {first_column{i}});
        end

        % reorginize by making a matrix
        mat = cell(n_inputs,1+m);
        % the delay cases
        for i = 1:2:m
            for j = i+1:m+1
                mat{i,j} = dmult_m{j-i}{j-1};
            end
            mat{i,1} = first_column{i};
            % non-delay cases squeezing
            for j = 2:i
                mat{i,j} = mult_i_n{i-j+1}{j-1};
            end
        end
        if mod(m,2) == 1
            new_start1 = m+2;
        end
        % for non-delay cases
        for i=new_start1:2:n_inputs-m
            mat{i,1} = first_column{i};
            for j=2:m+1
                mat{i,j} = mult_i_n{i-j+1}{j-1};
            end
        end
        if mod(n_inputs-m,2) == 1
            new_start2 = n_inputs - m +2;
        end
        % compensating the delay cases
        for i = new_start2 :2: n_inputs
            mat{i,1} = first_column{i};
            if i>m
                new_end = m+1;
            else
                new_end = i-(n_inputs-m+1)+2;
            end
            for j= 2: new_end
                mat{i,j} = mult_i_n{i-j+1}{j-1};
            end
        end

        % add up and output
        xlsub3_addertree = cell(1,n_inputs);
        for i = 1:2:n_inputs
            if i == 1
                xlsub3_addertree{i} = xBlock(struct('source', str2func('adder_tree_init_xblock'),'name', ['adder_tree',num2str(i)]), ...
                         {m+1, add_latency, 'Round  (unbiased: +/- Inf)', 'Saturate', 'Behavioral'}, ...
                         {sync,mat{i,:}}, ...
                         {sync_out,outports{i}});
            else
                xlsub3_addertree{i} = xBlock(struct('source', str2func('adder_tree_init_xblock'),'name', ['adder_tree',num2str(i)]), ...
                         {m+1, add_latency, 'Round  (unbiased: +/- Inf)', 'Saturate', 'Behavioral'}, ...
                         {sync,mat{i,:}}, ...
                         {{},outports{i}});
            end
        end
    else
    end
end
end