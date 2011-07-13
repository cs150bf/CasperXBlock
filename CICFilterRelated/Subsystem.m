function Subsystem()
% This is a generated function based on subsystem:
%     untitled/Subsystem
% Though there are limitations about the generated script, 
% the main purpose of this utility is to make learning
% Sysgen Script easier.
% 
% To test it, run the following commands from MATLAB console:
% cfg.source = str2func('Subsystem');
% cfg.toplevel = 'untitled/Subsystem';
% args = {};
% xBlock(cfg, args);
% 
% You can edit Subsystem.m to debug your script.
% 
% You can also replace the MaskInitialization code with the 
% following commands so the subsystem will be generated 
% according to the values of mask parameters.
% cfg.source = str2func('Subsystem');
% cfg.toplevel = gcb;
% args = {};
% xBlock(cfg, args);
% 
% To configure the xBlock call in debug mode, in which mode,
% autolayout will be performed every time a block is added,
% run the following commands:
% cfg.source = str2func('Subsystem');
% cfg.toplevel = gcb;
% cfg.debug = 1;
% args = {};
% xBlock(cfg, args);
% 
% To make the xBlock smart so it won't re-generate the
% subsystem if neither the arguments nor the scripts are
% changes, use as the following:
% cfg.source = str2func('Subsystem');
% cfg.toplevel = gcb;
% cfg.depend = {'Subsystem'};
% args = {};
% xBlock(cfg, args);
% 
% See also xBlock, xInport, xOutport, xSignal, xlsub2script.


%% inports
xlsub2_a = xInport('a');
xlsub2_b = xInport('b');

%% outports
xlsub2_mac = xOutport('mac');

%% diagram

% block: untitled/Subsystem/Accumulator
xlsub2_Mult_out1 = xSignal;
xlsub2_Accumulator = xBlock(struct('source', 'Accumulator', 'name', 'Accumulator'), ...
                            struct('rst', 'off'), ...
                            {xlsub2_Mult_out1}, ...
                            {xlsub2_mac});

% block: untitled/Subsystem/Mult
xlsub2_Mult = xBlock(struct('source', 'Mult', 'name', 'Mult'), ...
                     struct('latency', 0, ...
                            'use_behavioral_HDL', 'on'), ...
                     {xlsub2_a, xlsub2_b}, ...
                     {xlsub2_Mult_out1});



end

