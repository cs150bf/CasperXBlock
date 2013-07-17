%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %      
%   Copyright (C) 2011 Suraj Gowda, Hong Chen, Terry Filiba, Aaron Parsons    %
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
function fft_biplex_real_4x_init_xblock(blk, varargin)

defaults = { ...
    'FFTSize', 2, ...
    'input_bit_width', 18, ...
    'coeff_bit_width', 18, ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'arch', 'Virtex5', ...
    'opt_target', 'logic', ...
    'coeffs_bit_limit', 8, ...
    'delays_bit_limit', 8, ...
    'specify_mult', 'off', ...
    'mult_spec', [2 2], ...
    'hardcode_shifts', 'off', ...
    'shift_schedule', [1 1], ...
    'dsp48_adders', 'off', ...
    'bit_growth_chart', [0 0], ...
};

% Retrieve values from mask fields.
FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
coeffs_bit_limit = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
delays_bit_limit = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
specify_mult = get_var('specify_mult', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
hardcode_shifts = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
shift_schedule = get_var('shift_schedule', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('dsp48_adders', 'defaults', defaults, varargin{:});
bit_growth_chart = get_var('bit_growth_chart', 'defaults', defaults, varargin{:});


%% inports
sync = xInport('sync');
shift = xInport('shift');
pol1 = xInport('pol1');
pol2 = xInport('pol2');
pol3 = xInport('pol3');
pol4 = xInport('pol4');

%% outports
sync_out = xOutport('sync_out');
pol1_out = xOutport('pol1_out');
pol2_out = xOutport('pol2_out');
pol3_out = xOutport('pol3_out');
pol4_out = xOutport('pol4_out');
of = xOutport('of');

%% diagram
% Validate input fields.


if (strcmp(specify_mult, 'on') && (length(mult_spec) ~= FFTSize)),
    error('fft_biplex_real_4x_init.m: Multiplier use specification for stages does not match FFT size');
    clog('fft_biplex_real_4x_init.m: Multiplier use specification for stages does not match FFT size','error');
    return;
end

% Derive useful values.

if (2^(FFTSize-1) * 2*input_bit_width >= 2^delays_bit_limit) && (2^(FFTSize-1) >= bram_latency),
    bram_delays = 'on';
else
    bram_delays = 'off';
end

%%%%%%%%%%%%%%%%%%
% Start drawing! %
%%%%%%%%%%%%%%%%%%

pol1_cplx = xSignal;
pol2_cplx = xSignal;

xBlock( struct('source', str2func('ri_to_c_init_xblock'), 'name', 'ri_to_c_pol1'), ...
		{}, {pol1, pol2}, {pol1_cplx});

xBlock( struct('source', str2func('ri_to_c_init_xblock'), 'name', 'ri_to_c_pol2'), ...
		{}, {pol3, pol4}, {pol2_cplx});		
		
biplex_core_sync_out = xSignal;		
biplex_core_out1 = xSignal;
biplex_core_out2 = xSignal;
xBlock( struct('name', 'biplex_core', 'source', str2func('fft_biplex_core_init_xblock')), ...
    {[blk,'/biplex_core'], ...
    'FFTSize', (FFTSize), ...
    'input_bit_width', (input_bit_width), ...
    'coeff_bit_width', (coeff_bit_width), ...
    'add_latency', (add_latency), ...
    'mult_latency', (mult_latency), ...
    'bram_latency', (bram_latency), ...
    'conv_latency', (conv_latency), ...
    'quantization', (quantization), ...
    'overflow', (overflow), ...
    'arch', (arch), ...
    'opt_target', (opt_target), ...
    'coeffs_bit_limit', (coeffs_bit_limit), ...
    'delays_bit_limit', (delays_bit_limit), ...
    'specify_mult', (specify_mult), ...
    'mult_spec', (mult_spec), ...
    'hardcode_shifts', (hardcode_shifts), ...
    'shift_schedule', (shift_schedule), ...
    'dsp48_adders', (dsp48_adders), ...
    'bit_growth_chart', (bit_growth_chart)}, ...
    {sync, shift, pol1_cplx, pol2_cplx}, {biplex_core_sync_out, biplex_core_out1, biplex_core_out2, of});

% Add bi_real_unscr_4x block.

xBlock( struct('name', 'bi_real_unscr_4x', 'source', str2func('fft_bi_real_unscr_4x_init_xblock')), ...
	{[blk,'/bi_real_unscr_4x'], ...
    'FFTSize', FFTSize, ...
    'n_bits', input_bit_width, ...
    'dsp48_adders', dsp48_adders, }, ...
    {biplex_core_sync_out, biplex_core_out1, biplex_core_out2}, ...
    {sync_out, pol1_out, pol2_out, pol3_out, pol4_out});



if ~isempty(blk) && ~strcmp(blk(1),'/')
    % Delete all unconnected blocks.
    clean_blocks(blk);

    %%%%%%%%%%%%%%%%%%%
    % Finish drawing! %
    %%%%%%%%%%%%%%%%%%%

    % Set attribute format string (block annotation).
    fmtstr = sprintf('%s\n%d stages\n[%d,%d]\n%s\n%s', ...
        arch, FFTSize, input_bit_width, coeff_bit_width, quantization, overflow);
    set_param(blk, 'AttributesFormatString', fmtstr);
end


end




