function twiddle_pass_through(FFTSize, input_bit_width, add_latency, mult_latency, bram_latency, conv_latency, opt_target)
% This is a generated function based on subsystem:
%     twiddles_collections/twiddle_pass_through
% Though there are limitations about the generated script, 
% the main purpose of this utility is to make learning
% Sysgen Script easier.
% 
% To test it, run the following commands from MATLAB console:
% cfg.source = str2func('twiddle_pass_through');
% cfg.toplevel = 'twiddles_collections/twiddle_pass_through';
% args = {my_FFTSize, my_input_bit_width, my_add_latency, my_mult_latency, my_bram_latency, my_conv_latency, my_opt_target};
% xBlock(cfg, args);
% 
% You can edit twiddle_pass_through.m to debug your script.
% 
% You can also replace the MaskInitialization code with the 
% following commands so the subsystem will be generated 
% according to the values of mask parameters.
% cfg.source = str2func('twiddle_pass_through');
% cfg.toplevel = gcb;
% args = {FFTSize, input_bit_width, add_latency, mult_latency, bram_latency, conv_latency, opt_target};
% xBlock(cfg, args);
% 
% To configure the xBlock call in debug mode, in which mode,
% autolayout will be performed every time a block is added,
% run the following commands:
% cfg.source = str2func('twiddle_pass_through');
% cfg.toplevel = gcb;
% cfg.debug = 1;
% args = {FFTSize, input_bit_width, add_latency, mult_latency, bram_latency, conv_latency, opt_target};
% xBlock(cfg, args);
% 
% To make the xBlock smart so it won't re-generate the
% subsystem if neither the arguments nor the scripts are
% changes, use as the following:
% cfg.source = str2func('twiddle_pass_through');
% cfg.toplevel = gcb;
% cfg.depend = {'twiddle_pass_through'};
% args = {FFTSize, input_bit_width, add_latency, mult_latency, bram_latency, conv_latency, opt_target};
% xBlock(cfg, args);
% 
% See also xBlock, xInport, xOutport, xSignal, xlsub2script.


%% inports
xlsub2_a = xInport('a');
xlsub2_b = xInport('b');
xlsub2_sync = xInport('sync');

%% outports
xlsub2_a_re = xOutport('a_re');
xlsub2_a_im = xOutport('a_im');
xlsub2_bw_re = xOutport('bw_re');
xlsub2_bw_im = xOutport('bw_im');
xlsub2_sync_out = xOutport('sync_out');

%% diagram

% block: twiddles_collections/twiddle_pass_through/c_to_ri
xlsub2_c_to_ri = xBlock(struct('source', 'casper_library_misc/c_to_ri', 'name', 'c_to_ri'), ...
                        struct('n_bits', input_bit_width, ...
                               'bin_pt', input_bit_width-1), ...
                        {xlsub2_a}, ...
                        {xlsub2_a_re, xlsub2_a_im});

% block: twiddles_collections/twiddle_pass_through/c_to_ri1
xlsub2_c_to_ri1 = xBlock(struct('source', 'casper_library_misc/c_to_ri', 'name', 'c_to_ri1'), ...
                         struct('n_bits', input_bit_width, ...
                                'bin_pt', input_bit_width-1), ...
                         {xlsub2_b}, ...
                         {xlsub2_bw_re, xlsub2_bw_im});

% extra outport assignment
xlsub2_sync_out.assign(xlsub2_sync);


end

