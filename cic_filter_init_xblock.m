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
function cic_filter_init_xblock(varargin)
defaults = { ...
    'n_inputs', 2, ...
    'input_bit_width', 18, ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'arch', 'Virtex5', ...
    'opt_target', 'logic', ...
    'recursive', 'on', ...
    'n_stages', 3, ...
    'hardcode_dec_rate', 'on', ...
    'dec_rate', 2, ...
    'diff_delay', 1, ...
};


n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
recursive = get_var('recursive', 'defaults', defaults, varargin{:});
n_stages = get_var('n_stages', 'defaults', defaults, varargin{:});
hardcode_dec_rate = get_var('n_stages', 'defaults', defaults, varargin{:});
dec_rate = get_var('dec_rate', 'defaults', defaults, varargin{:});
diff_delay = get_var('diff_delay', 'defaults', defaults, varargin{:});

cic_in = cell(1,n_inputs);
for i = 1:n_inputs,
    cic_in{i} = xInport(['cic_in',num2str(i)]);
end
sync = xInport('sync');
dec_rate_Inport = xInport('dec_rate');
en = xInport('en');

cic_out = cell(1, n_inputs);
for i = 1:n_inputs,
    cic_out{i} = xOutport(['cic_out',num2str(i)]);
end
cic_rdy = xOutport('cic_rdy');                          

% traditional recursive structure
if strcmp(recursive, 'on') 
    % integrators
    integrator = cell(1,n_stages);
    integrator_in = cell(1,n_stages);
    integrator_in{1} = cic_in;
    for i = 2:n_stages + 1,
        integrator_in{i}=cell(1,n_inputs);
        for j= 1:n_inputs
            integrator_in{i}{j} = xSignal(['integrator_port',num2str(i),'_',num2str(j)]);
        end
    end
    for i = 1:n_stages,
        integrator{i} = xBlock(struct('source',str2func(parallel_integrator_init_xblock),'name',['integrator',num2str(i)]), ...
                                {n_inputs,ceil(n_stages*log2(dec_rate*diff_delay) + input_bitwidth)}, ...
                                integrator_in{i}, ...
                                integrator_in{i+1});                            
    end
elseif strcmp(polyphase,'off')
    
else
    
end



end