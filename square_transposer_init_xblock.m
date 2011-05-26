function square_transposer_init_xblock(n_inputs)


if n_inputs < 1,
    error('Number of inputs must be 2^1 or greater.');
end

%% inports
xlsub2_sync = xInport('sync');
xlsub2_In = cell(1,2^n_inputs);
for i = 1:2^n_inputs,
    xlsub2_In{i} = xInport(['In',num2str(i)]);
end


%% outports
xlsub2_sync_out = xOutport('sync_out');
xlsub2_Out = cell(1,2^n_inputs);
for i = 1:2^n_inputs,
    xlsub2_Out{i} = xOutport(['Out',num2str(i)]);
end

%% diagram

% block: Delayf & Delayb
Delayf = cell(1,2^n_inputs);
Delayb = cell(1,2^n_inputs);
xlsub2_barrel_switcher_In = cell(1,2^n_inputs);
xlsub2_barrel_switcher_Out = cell(1,2^n_inputs);
for i=1:2^n_inputs,
    if i == 1,
        dport = 3;
    else,
        dport = (2^n_inputs - i + 2) + 2;
    end
    xlsub2_barrel_switcher_In{dport-2} = xSignal(['barrel_switcher_In',num2str(dport-2)]);
    xlsub2_barrel_switcher_Out{i} = xSignal(['barrel_switcher_Out',num2str(i)]);
    Delayf{i} = xBlock(struct('source', 'Delay', 'name', ['Delayf',num2str(i)]), ...
                        [], ...
                        {xlsub2_In{i}}, ...
                        {xlsub2_barrel_switcher_In{dport-2}});
    Delayb{i} = xBlock(struct('source', 'Delay', 'name', ['Delayb',num2str(i)]), ...
                        [], ...
                        {xlsub2_barrel_switcher_Out{i}}, ...
                        {xlsub2_Out{i}});
end

% block: untitled/square_transposer/counter
xlsub2_counter_out1 = xSignal;
xlsub2_counter = xBlock(struct('source', 'Counter', 'name', 'counter'), ...
                        struct('operation', 'Down', ...
                               'n_bits', n_inputs, ...
                               'rst', 'on', ...
                               'explicit_period', 'off', ...
                               'use_rpm', 'on'), ...
                        {xlsub2_sync}, ...
                        {xlsub2_counter_out1});

% block: untitled/square_transposer/delay0
xlsub2_barrel_switcher_out1 = xSignal;
xlsub2_delay0 = xBlock(struct('source', 'Delay', 'name', 'delay0'), ...
                       [], ...
                       {xlsub2_barrel_switcher_out1}, ...
                       {xlsub2_sync_out});

% block: untitled/square_transposer/barrel_switcher
xlsub2_barrel_switcher_sub = xBlock(struct('source', str2func('barrel_switcher_init_xblock'), 'name', 'barrel_switcher'), ...
                                {n_inputs}, ...
                                [{xlsub2_counter_out1}, {xlsub2_sync}, xlsub2_barrel_switcher_In], ...
                                [{xlsub2_barrel_switcher_out1}, xlsub2_barrel_switcher_Out]);




end

