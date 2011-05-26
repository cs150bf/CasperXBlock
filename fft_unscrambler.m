function fft_unscrambler(FFTSize, n_inputs, bram_latency)


if n_inputs >= FFTSize - 2,
    errordlg('FFT Unscrambler: 2^n_inputs must be < 2^(FFT size-2).');
end
part_mat = [0:2^(FFTSize-2*n_inputs)-1]*2^(n_inputs);
map_mat = [];
for i=0:2^n_inputs-1,
    map_mat = [map_mat, part_mat+i];
end
map_str = tostring(map_mat);



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

% block: untitled/fft_unscrambler/const
xlsub2_const_out1 = xSignal;
xlsub2_const = xBlock(struct('source', 'Constant', 'name', 'const'), ...
                      struct('arith_type', 'Boolean', ...
                             'n_bits', 1, ...
                             'bin_pt', 0, ...
                             'explicit_period', 'on'), ...
                      {}, ...
                      {xlsub2_const_out1});

                  
% Add dynamic lines
xlsub2_reorder_In= cell(1,2^n_inputs);
xlsub2_reorder_Out = cell(1,2^n_inputs);
xlsub2_square_transposer_Out = cell(1,2^n_inputs);
xlsub2_square_transposer_In = cell(1,2^n_inputs);
for i=1:2^n_inputs,
    xlsub2_square_transposer_In{i} = xlsub2_In{i};
    xlsub2_reorder_In{i} = xSignal(['xlsub2_reorder_In',num2str(i)]);
    xlsub2_square_transposer_Out{i} = xlsub2_reorder_In{i};
    xlsub2_reorder_Out{i+1} = xlsub2_Out{i};
end

% block: untitled/fft_unscrambler/reorder1
xlsub2_square_transposer1_out1 = xSignal;
xlsub2_reorder1_sub = xBlock(struct('source', str2func('reorder_init_xblock'), 'name', 'reorder1'), ...
                         {gcb,'map',map_mat,'n_inputs', 2^n_inputs, 'bram_latency',bram_latency, 'map_latency',1, 'double_buffer',0}, ...
                         [{xlsub2_square_transposer1_out1}, {xlsub2_const_out1}, xlsub2_reorder_In], ...
                         [{xlsub2_sync_out}, xlsub2_reorder_Out]);

% block: untitled/fft_unscrambler/square_transposer1
xlsub2_square_transposer1_sub = xBlock(struct('source', str2func('square_transposer_init_xblock'), 'name', 'square_transposer1'), ...
                                   {n_inputs}, ...
                                   [{xlsub2_sync}, xlsub2_sqaure_transposer_In], ...
                                   [{xlsub2_square_transposer1_out1}, xlsub2_square_transposer_Out]);





end

