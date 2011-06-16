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
function parallel_polynomial_stage_init_xblock_new(m,n_inputs,polyphase,add_latency,oddeven)

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


elseif n_inputs > m
    % assuming n_inputs > m
    inports = cell(1,n_inputs);
    for i = 1:n_inputs,
        inports{i} = xInport(['inport',num2str(i)]);
    end
    sync = xInport('sync');


    outports = cell(1,n_inputs);
    for i=1+mod(oddeven+1,2):2:n_inputs,
        outports{i} = xOutport(['outport',num2str(i)]);
    end
    sync_out = xOutport('sync_out');


    if strcmp(polyphase,'off')
        % take care of the delay cases
        % need optimization (coefficient symmetric)
        delayed_x_minus_p1 = cell(1,m);
        xlsub3_delay = cell(1,m);
        dmult_minus_p1 = cell(1,m);
        xlsub3_dmult = cell(1,m);
        for i=1:m-mod(oddeven+1,2)
            delayed_x_minus_p1{i} = xSignal(['delay_x_m_minus_',num2str(i-1)]);
            xlsub3_delay{i} = xBlock(struct('source', 'Delay', 'name', ['Delay',num2str(n_inputs-i+1)]), ...
                              struct('latency', 1), ...
                              {inports{n_inputs-i+1}}, ...
                              {delayed_x_minus_p1{i}});
            dmult_minus_p1{i} = cell(1,m);
            xlsub3_dmult{i} = cell(1,m);
            for j = i+(2-oddeven):2:m+1
                dmult_minus_p1{i}{j} = xSignal(['multiplied_m_minus_',num2str(i-1),'_',num2str(j)]);
                xlsub3_dmult{i}{j} = xBlock(struct('source', 'Mult', 'name', ['dmult_m_minus',num2str(i-1),'_',num2str(j)]), ...
                                        struct('latency',2), ...
                                        {delayed_x_minus_p1{i}, coeff_const{j}}, ...
                                        {dmult_minus_p1{i}{j}});
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
            mult_i_n{i} = cell(1,m+1);
            xlsub3_mult{i} = cell(1,m+1);
            sub_oddeven = mod(i+oddeven+1,2);
            if sub_oddeven == 0 
                sub_oddeven = 2;
            end
            for j = sub_oddeven:2:m+1
                mult_i_n{i}{j} = xSignal(['multplied_x_i_n',num2str(i),'_',num2str(j)]);
                xlsub3_mult{i}{j} = xBlock(struct('source', 'Mult', 'name', ['mult',num2str(i),'_',num2str(j)]), ...
                                        struct('latency',2), ...
                                        {x_i_n{i}, coeff_const{j}}, ...
                                        {mult_i_n{i}{j}});
            end
        end
        % compensating the delayed cases
        for i = n_inputs-m+1:n_inputs
            x_i_n{i} = inports{i};
            mult_i_n{i} = cell(1,(n_inputs-i)+1);
            xlsub3_mult{i} = cell(1,(n_inputs-i)+1);
            sub_oddeven = mod(i+oddeven+1,2);
            if sub_oddeven == 0 
                sub_oddeven = 2;
            end            
            for j = sub_oddeven:2:(n_inputs-i)+1
                mult_i_n{i}{j} = xSignal(['multplied_x_i_n',num2str(i),'_',num2str(j)]);
                xlsub3_mult{i}{j} = xBlock(struct('source', 'Mult', 'name', ['mult',num2str(i),'_',num2str(j)]), ...
                                        struct('latency',2), ...
                                        {x_i_n{i}, coeff_const{j}}, ...
                                        {mult_i_n{i}{j}});
            end
        end
        
        


        % reorginize by making a matrix
        mat = cell(n_inputs,1+m);
        % the delay cases
        % top triangle
        first_row = 1;
        if oddeven == 0
            first_row = 2;
        end
        for i = first_row:2:m
            for j = i+1:m+1
                mat{i,j} = dmult_minus_p1{j-i}{j};
            end
            % non-delay cases compensating the top triangle
            for j = 1:i
                mat{i,j} = mult_i_n{i-j+1}{j};
            end
        end
        % compensating the delay cases
        % bottom triangle
        new_start = m+1;
        if mod(m,2) == oddeven
            new_start = m+2;
        end
        for i = new_start :2: n_inputs
            for j= 1:m+1
                mat{i,j} = mult_i_n{i-j+1}{j};
            end
        end




        % add up and output
        xlsub3_addertree = cell(1,n_inputs);
        check_sync_out = 0;
        for i = 1+mod(oddeven+1,2):2:n_inputs
            if check_sync_out ==0
                xlsub3_addertree{i} = xBlock(struct('source', str2func('adder_tree_init_xblock'),'name', ['adder_tree',num2str(i)]), ...
                         {m+1, add_latency, 'Round  (unbiased: +/- Inf)', 'Saturate', 'Behavioral'}, ...
                         {sync,mat{i,:}}, ...
                         {sync_out,outports{i}});
                check_sync_out = 1;
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