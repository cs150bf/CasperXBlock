function delay_tree(fanout, bfac)
% This is a generated function based on subsystem:
%     more_delays/delay_tree
% Though there are limitations about the generated script, 
% the main purpose of this utility is to make learning
% Sysgen Script easier.
% 
% To test it, run the following commands from MATLAB console:
% cfg.source = str2func('delay_tree');
% cfg.toplevel = 'more_delays/delay_tree';
% args = {my_fanout, my_bfac};
% xBlock(cfg, args);
% 
% You can edit delay_tree.m to debug your script.
% 
% You can also replace the MaskInitialization code with the 
% following commands so the subsystem will be generated 
% according to the values of mask parameters.
% cfg.source = str2func('delay_tree');
% cfg.toplevel = gcb;
% args = {fanout, bfac};
% xBlock(cfg, args);
% 
% To configure the xBlock call in debug mode, in which mode,
% autolayout will be performed every time a block is added,
% run the following commands:
% cfg.source = str2func('delay_tree');
% cfg.toplevel = gcb;
% cfg.debug = 1;
% args = {fanout, bfac};
% xBlock(cfg, args);
% 
% To make the xBlock smart so it won't re-generate the
% subsystem if neither the arguments nor the scripts are
% changes, use as the following:
% cfg.source = str2func('delay_tree');
% cfg.toplevel = gcb;
% cfg.depend = {'delay_tree'};
% args = {fanout, bfac};
% xBlock(cfg, args);
% 
% See also xBlock, xInport, xOutport, xSignal, xlsub2script.


%% inports
xlsub2_in = xInport('in');

%% outports
xlsub2_out1 = xOutport('out1');
xlsub2_out2 = xOutport('out2');

%% diagram

% block: more_delays/delay_tree/delay_c1_r1
xlsub2_delay_c1_r1_out1 = xSignal;
xlsub2_delay_c1_r1 = xBlock(struct('source', 'Delay', 'name', 'delay_c1_r1'), ...
                            [], ...
                            {xlsub2_in}, ...
                            {xlsub2_delay_c1_r1_out1});

% block: more_delays/delay_tree/delay_c2_r1
xlsub2_delay_c2_r1 = xBlock(struct('source', 'Delay', 'name', 'delay_c2_r1'), ...
                            [], ...
                            {xlsub2_delay_c1_r1_out1}, ...
                            {xlsub2_out1});

% block: more_delays/delay_tree/delay_c2_r2
xlsub2_delay_c2_r2 = xBlock(struct('source', 'Delay', 'name', 'delay_c2_r2'), ...
                            [], ...
                            {xlsub2_delay_c1_r1_out1}, ...
                            {xlsub2_out2});



end

