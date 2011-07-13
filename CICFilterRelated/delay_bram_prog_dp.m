function delay_bram_prog_dp(ram_bits, bram_latency)
% This is a generated function based on subsystem:
%     more_delays/delay_bram_prog_dp
% Though there are limitations about the generated script, 
% the main purpose of this utility is to make learning
% Sysgen Script easier.
% 
% To test it, run the following commands from MATLAB console:
% cfg.source = str2func('delay_bram_prog_dp');
% cfg.toplevel = 'more_delays/delay_bram_prog_dp';
% args = {my_ram_bits, my_bram_latency};
% xBlock(cfg, args);
% 
% You can edit delay_bram_prog_dp.m to debug your script.
% 
% You can also replace the MaskInitialization code with the 
% following commands so the subsystem will be generated 
% according to the values of mask parameters.
% cfg.source = str2func('delay_bram_prog_dp');
% cfg.toplevel = gcb;
% args = {ram_bits, bram_latency};
% xBlock(cfg, args);
% 
% To configure the xBlock call in debug mode, in which mode,
% autolayout will be performed every time a block is added,
% run the following commands:
% cfg.source = str2func('delay_bram_prog_dp');
% cfg.toplevel = gcb;
% cfg.debug = 1;
% args = {ram_bits, bram_latency};
% xBlock(cfg, args);
% 
% To make the xBlock smart so it won't re-generate the
% subsystem if neither the arguments nor the scripts are
% changes, use as the following:
% cfg.source = str2func('delay_bram_prog_dp');
% cfg.toplevel = gcb;
% cfg.depend = {'delay_bram_prog_dp'};
% args = {ram_bits, bram_latency};
% xBlock(cfg, args);
% 
% See also xBlock, xInport, xOutport, xSignal, xlsub2script.


%% inports
xlsub2_din = xInport('din');
xlsub2_delay = xInport('delay');

%% outports
xlsub2_dout = xOutport('dout');

%% diagram

% block: more_delays/delay_bram_prog_dp/AddSub
xlsub2_wr_addr_out1 = xSignal;
xlsub2_AddSub_out1 = xSignal;
xlsub2_AddSub = xBlock(struct('source', 'AddSub', 'name', 'AddSub'), ...
                       struct('mode', 'Subtraction', ...
                              'latency', 1, ...
                              'precision', 'User Defined', ...
                              'n_bits', ram_bits, ...
                              'bin_pt', 0, ...
                              'use_behavioral_HDL', 'on', ...
                              'use_rpm', 'on'), ...
                       {xlsub2_wr_addr_out1, xlsub2_delay}, ...
                       {xlsub2_AddSub_out1});

% block: more_delays/delay_bram_prog_dp/Constant2
xlsub2_Constant2_out1 = xSignal;
xlsub2_Constant2 = xBlock(struct('source', 'Constant', 'name', 'Constant2'), ...
                          struct('arith_type', 'Boolean', ...
                                 'n_bits', 1, ...
                                 'bin_pt', 0, ...
                                 'explicit_period', 'on'), ...
                          {}, ...
                          {xlsub2_Constant2_out1});

% block: more_delays/delay_bram_prog_dp/Constant4
xlsub2_Constant4_out1 = xSignal;
xlsub2_Constant4 = xBlock(struct('source', 'Constant', 'name', 'Constant4'), ...
                          struct('arith_type', 'Boolean', ...
                                 'const', 0, ...
                                 'n_bits', 1, ...
                                 'bin_pt', 0, ...
                                 'explicit_period', 'on'), ...
                          {}, ...
                          {xlsub2_Constant4_out1});

% block: more_delays/delay_bram_prog_dp/Dual Port RAM
xlsub2_Dual_Port_RAM_out1 = xSignal;
xlsub2_Dual_Port_RAM = xBlock(struct('source', 'Dual Port RAM', 'name', 'Dual Port RAM'), ...
                              struct('depth', 2^ram_bits, ...
                                     'initVector', 0, ...
                                     'latency', bram_latency, ...
                                     'optimize', 'Speed'), ...
                              {xlsub2_wr_addr_out1, xlsub2_din, xlsub2_Constant2_out1, xlsub2_AddSub_out1, xlsub2_din, xlsub2_Constant4_out1}, ...
                              {xlsub2_Dual_Port_RAM_out1, xlsub2_dout});


% block: more_delays/delay_bram_prog_dp/wr_addr
xlsub2_wr_addr = xBlock(struct('source', 'Counter', 'name', 'wr_addr'), ...
                        struct('n_bits', ram_bits, ...
                               'use_behavioral_HDL', 'on', ...
                               'use_rpm', 'on'), ...
                        {}, ...
                        {xlsub2_wr_addr_out1});



end

