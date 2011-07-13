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
function parallel_adder_init_xblock(n_inputs,R,add_latency)

sync_in = xInport('sync_in');
inports = cell(1,n_inputs);

sync_out = xOutport('sync_out');
outports = cell(1,n_inputs);
adder_tree_blks = cell(1,n_inputs);
adder_tree_inports = cell(n_inputs,R);
for i =1:n_inputs
    inports{i} = xInport(['in',num2str(i)]);
    outports{i} = xOutport(['out',num2str(i)]);
end

if n_inputs*2 > R
    if R > n_inputs
        delay_blks = cell(1,n_inputs);
        delay_outs = cell(1,n_inputs);
        for i = 1:n_inputs
            delay_outs{i} = xSignal(['d',num2str(i)]);
            delay_blks{i} = xBlock(struct('source','Delay','name', ['delay',num2str(i)]), ...
                              struct('latency', 1), ...   
                              {inports{i}}, ...
                              {delay_outs{i}});
        end
    else
        delay_blks = cell(1,R-1);
        delay_outs = cell(1,n_inputs);
        for i =1:R-1
            delay_outs{n_inputs-i+1} = xSignal(['d',num2str(n_inputs-i+1)]);
            delay_blks{i} = xBlock(struct('source','Delay','name', ['delay',num2str(n_inputs-i+1)]), ...
                              struct('latency', 1), ...   
                              {inports{n_inputs-i+1}}, ...
                              {delay_outs{n_inputs-i+1}});
        end
    end
else
    disp('not supported yet');
end

adder_tree_sync_in = cell(1,R+1);
adder_tree_sync_in{1} = sync_in;
for i =1:n_inputs
    adder_tree_inports{i,1} = inports{i};
    for j = 2:R
        if i-j+1> 0
            adder_tree_inports{i,j} = inports{i-j+1};
        else
            adder_tree_inports{i,j} = delay_outs{n_inputs+(i-j+1)};
        end
    end
    
    adder_tree_sync_in{i+1} = xSignal(['adder_tree_sync_in',num2str(i+1)]);
    adder_tree_sync_in{i+1} =xSignal(['adder_tree_sync_in',num2str(i)]);
    adder_tree_blks{i} = xBlock(struct('source', str2func('adder_tree_init_xblock'),'name', ['adder_tree',num2str(i)]), ...
                     {R, add_latency, 'Round  (unbiased: +/- Inf)', 'Saturate', 'Behavioral'}, ...
                     {adder_tree_sync_in{i},adder_tree_inports{i,:}}, ...
                     {adder_tree_sync_in{i+1},outports{i}});
end

sync_out.bind(adder_tree_sync_in{n_inputs+1});

end