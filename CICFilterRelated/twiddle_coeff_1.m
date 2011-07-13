function twiddle_coeff_1(FFTSize, input_bit_width, add_latency, mult_latency, bram_latency, conv_latency, opt_target)
% This is a generated function based on subsystem:
%     twiddles_collections/twiddle_coeff_1
% Though there are limitations about the generated script, 
% the main purpose of this utility is to make learning
% Sysgen Script easier.
% 
% To test it, run the following commands from MATLAB console:
% cfg.source = str2func('twiddle_coeff_1');
% cfg.toplevel = 'twiddles_collections/twiddle_coeff_1';
% args = {my_FFTSize, my_input_bit_width, my_add_latency, my_mult_latency, my_bram_latency, my_conv_latency, my_opt_target};
% xBlock(cfg, args);
% 
% You can edit twiddle_coeff_1.m to debug your script.
% 
% You can also replace the MaskInitialization code with the 
% following commands so the subsystem will be generated 
% according to the values of mask parameters.
% cfg.source = str2func('twiddle_coeff_1');
% cfg.toplevel = gcb;
% args = {FFTSize, input_bit_width, add_latency, mult_latency, bram_latency, conv_latency, opt_target};
% xBlock(cfg, args);
% 
% To configure the xBlock call in debug mode, in which mode,
% autolayout will be performed every time a block is added,
% run the following commands:
% cfg.source = str2func('twiddle_coeff_1');
% cfg.toplevel = gcb;
% cfg.debug = 1;
% args = {FFTSize, input_bit_width, add_latency, mult_latency, bram_latency, conv_latency, opt_target};
% xBlock(cfg, args);
% 
% To make the xBlock smart so it won't re-generate the
% subsystem if neither the arguments nor the scripts are
% changes, use as the following:
% cfg.source = str2func('twiddle_coeff_1');
% cfg.toplevel = gcb;
% cfg.depend = {'twiddle_coeff_1'};
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

% block: twiddles_collections/twiddle_coeff_1/c_to_ri
xlsub2_c_to_ri_out1 = xSignal;
xlsub2_c_to_ri_out2 = xSignal;
xlsub2_c_to_ri = xBlock(struct('source', 'casper_library_misc/c_to_ri', 'name', 'c_to_ri'), ...
                        struct('n_bits', input_bit_width, ...
                               'bin_pt', input_bit_width-1), ...
                        {xlsub2_a}, ...
                        {xlsub2_c_to_ri_out1, xlsub2_c_to_ri_out2});

% block: twiddles_collections/twiddle_coeff_1/c_to_ri1
xlsub2_c_to_ri1_out1 = xSignal;
xlsub2_c_to_ri1_out2 = xSignal;
xlsub2_c_to_ri1 = xBlock(struct('source', 'casper_library_misc/c_to_ri', 'name', 'c_to_ri1'), ...
                         struct('n_bits', input_bit_width, ...
                                'bin_pt', input_bit_width-1), ...
                         {xlsub2_b}, ...
                         {xlsub2_c_to_ri1_out1, xlsub2_c_to_ri1_out2});

% block: twiddles_collections/twiddle_coeff_1/delay0
xlsub2_delay0 = xBlock(struct('source', 'Delay', 'name', 'delay0'), ...
                       struct('latency', mult_latency+add_latency+bram_latency+conv_latency, ...
                              'reg_retiming', 'on'), ...
                       {xlsub2_c_to_ri_out1}, ...
                       {xlsub2_a_re});

% block: twiddles_collections/twiddle_coeff_1/delay1
xlsub2_delay1 = xBlock(struct('source', 'Delay', 'name', 'delay1'), ...
                       struct('latency', mult_latency+add_latency+bram_latency+conv_latency, ...
                              'reg_retiming', 'on'), ...
                       {xlsub2_c_to_ri_out2}, ...
                       {xlsub2_a_im});

% block: twiddles_collections/twiddle_coeff_1/delay2
xlsub2_delay2 = xBlock(struct('source', 'Delay', 'name', 'delay2'), ...
                       struct('latency', mult_latency+add_latency+bram_latency+conv_latency, ...
                              'reg_retiming', 'on'), ...
                       {xlsub2_c_to_ri1_out1}, ...
                       {xlsub2_bw_im});

% block: twiddles_collections/twiddle_coeff_1/delay3
xlsub2_delay3 = xBlock(struct('source', 'Delay', 'name', 'delay3'), ...
                       struct('latency', mult_latency+add_latency+bram_latency+conv_latency, ...
                              'reg_retiming', 'on'), ...
                       {xlsub2_sync}, ...
                       {xlsub2_sync_out});

% block: twiddles_collections/twiddle_coeff_1/negate
xlsub2_negate = xBlock(struct('source', 'Negate', 'name', 'negate'), ...
                       struct('precision', 'User Defined', ...
                              'n_bits', input_bit_width, ...
                              'bin_pt', input_bit_width-1, ...
                              'latency', mult_latency+add_latency+bram_latency+conv_latency), ...
                       {xlsub2_c_to_ri1_out2}, ...
                       {xlsub2_bw_re});



end

