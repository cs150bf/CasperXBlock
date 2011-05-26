function fft_twiddle_init_xblock(varargin)
%% inports
a = xInport('a');
b = xInport('b');
sync = xInport('sync');

%% outports
a_re_out = xOutport('a_re');
a_im_out = xOutport('a_im');
bw_re_out = xOutport('bw_re');
bw_im_out = xOutport('bw_im');
sync_out = xOutport('sync_out');

%% Get varargin parameters
defaults = {'Coeffs', [0 1], ...
    'StepPeriod', 0, ...
    'input_bit_width', 18, ...
    'coeff_bit_width', 18,...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'conv_latency', 1, ...
    'bram_latency', 2, ...
    'input_latency', 0, ...
    'mux_latency',  5, ...
    'negate_latency', 3, ...
    'arch', 'Virtex5', ...
    'coeffs_bram', 'off', ...
    'use_hdl', 'off', ...
    'use_embedded', 'off', ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Wrap', ...
    'use_dsp48_mults', 0, ...
};

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
Coeffs = get_var('Coeffs', 'defaults', defaults, varargin{:});
ActualCoeffs = get_var('ActualCoeffs', 'defaults', defaults, varargin{:});
StepPeriod = get_var('StepPeriod', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});

add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
input_latency = get_var('input_latency', 'defaults', defaults, varargin{:});
mux_latency = get_var('mux_latency', 'defaults', defaults, varargin{:});
negate_latency = get_var('negate_latency', 'defaults', defaults, varargin{:});

arch = get_var('arch', 'defaults', defaults, varargin{:});
coeffs_bram = get_var('coeffs_bram', 'defaults', defaults, varargin{:});
use_hdl = get_var('use_hdl', 'defaults', defaults, varargin{:});
use_embedded = get_var('use_embedded', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
use_dsp48_mults = get_var('use_dsp48_mults', 'defaults', defaults, varargin{:});
biplex = get_var('biplex', 'defaults', defaults, varargin{:});

use_embedded = strcmp('on', use_embedded);
twiddle_type = get_twiddle_type(Coeffs, biplex, opt_target, use_embedded,StepPeriod,FFTSize);



%% Module Drawing
% convert 'a' input to real/imag
a_re = xSignal;
a_im = xSignal;
c_to_ri_a = xBlock(struct('source', str2func('c_to_ri_init_xblock'), 'name', 'c_to_ri_a'), ...
    {input_bit_width, input_bit_width-1}, {a}, {a_re, a_im});

% convert 'b' input to real/imag
b_re = xSignal;
b_im = xSignal;
c_to_ri_b = xBlock(struct('source', str2func('c_to_ri_init_xblock'), 'name', 'c_to_ri_b'), ...
    {input_bit_width, input_bit_width-1}, {b}, {b_re, b_im});

% delay inputs by input_latency length
a_re_del = xSignal;
a_im_del = xSignal;
b_re_del = xSignal;
b_im_del = xSignal;
sync_del = xSignal;
pipe_a_re = xBlock( struct('source', str2func('pipeline_init_xblock'), 'name', 'pipe_a_re'), ...
    {input_latency}, {a_re}, {a_re_del});
pipe_a_im = xBlock( struct('source', str2func('pipeline_init_xblock'), 'name', 'pipe_a_im'), ...
    {input_latency}, {a_im}, {a_im_del});
pipe_b_re = xBlock( struct('source', str2func('pipeline_init_xblock'), 'name', 'pipe_b_re'), ...
    {input_latency}, {b_re}, {b_re_del});
pipe_b_im = xBlock( struct('source', str2func('pipeline_init_xblock'), 'name', 'pipe_b_im'), ...
    {input_latency}, {b_im}, {b_im_del});
pipe_sync = xBlock( struct('source', str2func('pipeline_init_xblock'), 'name', 'pipe_sync'), ...
    {input_latency}, {sync}, {sync_del});

switch twiddle_type
    case 'twiddle_pass_through'
        % bind ports to outports for pass through
        a_re_out.assign(a_re_del);
        a_im_out.assign(a_im_del);
        bw_re_out.assign(b_re_del);
        bw_im_out.assign(b_im_del);
        sync_out.assign(sync_del);
        
    case 'twiddle_stage_2'
	    twiddle_stage_2_draw(a_re_del, a_im_del, b_re_del, b_im_del, sync_del, ...
	    	a_re_out, a_im_out, bw_re_out, bw_im_out, sync_out, ...
	    	FFTSize, input_bit_width, mux_latency, bram_latency, conv_latency, use_dsp48_mults);
	    	
    case 'twiddle_general_dsp48e'
        twiddle_general_dsp48e_draw(a_re_del, a_im_del, b_re_del, b_im_del, sync_del, ...
            a_re_out, a_im_out, bw_re_out, bw_im_out, sync_out, ...
            Coeffs, StepPeriod, coeff_bit_width, input_bit_width, bram_latency,...
            conv_latency, quantization, overflow, arch, coeffs_bram, FFTSize);
            
    case 'twiddle_coeff_0'
        total_latency = add_latency + mult_latency + bram_latency + conv_latency;
        a_re_delay2 = xBlock(struct('source', 'Delay', 'name', 'a_re_del'), ...
                            struct('latency', total_latency), {a_re_del}, {a_re_out} );
        a_im_delay2 = xBlock(struct('source', 'Delay', 'name', 'a_im_del'), ...
                            struct('latency', total_latency), {a_im_del}, {a_im_out} );
        b_re_delay2 = xBlock(struct('source', 'Delay', 'name', 'b_re_del'), ...
                            struct('latency', total_latency), {b_re_del}, {bw_re_out} );
        b_im_delay2 = xBlock(struct('source', 'Delay', 'name', 'b_im_del'), ...
                            struct('latency', total_latency), {b_im_del}, {bw_im_out} );
        sync_delay2 = xBlock(struct('source', 'Delay', 'name', 'sync_del'), ...
                            struct('latency', total_latency), {sync_del}, {sync_out} );
                            
    case 'twiddle_coeff_1'
        twiddle_stage_2_init_xblock(a_re, a_im, b_re, b_im, sync, ...
            a_re_out, a_im_out, bw_re_out, bw_im_out, sync_out, ...
            FFTSize, input_bit_width, negate_latency);
            
    case 'twiddle_general_4mult' 
		twiddle_general_4mult_init_xblock_draw(a_re, a_im, b_re, b_im, sync, ...
			a_re_out, a_im_out, bw_re_out, bw_im_out, sync_out, ...
			ActualCoeffs, StepPeriod, coeffs_bram, coeff_bit_width, input_bit_width, ...
			add_latency, mult_latency, bram_latency, conv_latency, arch, use_hdl, ... 
			use_embedded, quantization, overflow);
			
    case 'twiddle_general_3mult' 
		twiddle_general_3mult_init_xblock_draw(a_re, a_im, b_re, b_im, sync, ...
	    	a_re_out, a_im_out, bw_re_out, bw_im_out, sync_out, ...
	    	ActualCoeffs, StepPeriod, coeffs_bram, coeff_bit_width, input_bit_width, ...
	    	add_latency, mult_latency, bram_latency, conv_latency, arch, use_hdl, ...
	    	use_embedded, quantization, overflow);
	    	
    otherwise
        disp('Error! This twiddle type is not supported');
end
end
