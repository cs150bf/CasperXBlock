function half_band_init_xblock()



%% inports
xlsub2_In1 = xInport('In1');
xlsub2_In2 = xInport('In2');
xlsub2_In3 = xInport('In3');
xlsub2_In4 = xInport('In4');
xlsub2_In5 = xInport('In5');
xlsub2_In6 = xInport('In6');
xlsub2_In7 = xInport('In7');
xlsub2_In8 = xInport('In8');
xlsub2_In9 = xInport('In9');
xlsub2_In10 = xInport('In10');
xlsub2_In11 = xInport('In11');
xlsub2_In12 = xInport('In12');

%% outports
xlsub2_Out1 = xOutport('Out1');
xlsub2_Out2 = xOutport('Out2');
xlsub2_Out3 = xOutport('Out3');
xlsub2_Out4 = xOutport('Out4');
xlsub2_Out5 = xOutport('Out5');
xlsub2_Out6 = xOutport('Out6');
xlsub2_Out7 = xOutport('Out7');
xlsub2_Out8 = xOutport('Out8');

%% diagram

% block: half_band_xblock/Subsystem/adder_tree
xlsub2_parallel_fir_out1 = xSignal;
xlsub2_parallel_fir_out2 = xSignal;
xlsub2_parallel_fir1_out2 = xSignal;
xlsub2_parallel_fir2_out2 = xSignal;
xlsub2_parallel_fir3_out2 = xSignal;
xlsub2_adder_tree_sub = xBlock(struct('source',str2func('adder_tree_init_xblock'), 'name', 'adder_tree'), ...
                           {4,1,[],[],'Fabric'}, ...
                           {xlsub2_parallel_fir_out1, xlsub2_parallel_fir_out2, xlsub2_parallel_fir1_out2, xlsub2_parallel_fir2_out2, xlsub2_parallel_fir3_out2}, ...
                           {xlsub2_Out1, xlsub2_Out2});

% block: half_band_xblock/Subsystem/adder_tree1
xlsub2_parallel_fir1_out1 = xSignal;
xlsub2_parallel_fir_out3 = xSignal;
xlsub2_parallel_fir1_out3 = xSignal;
xlsub2_parallel_fir2_out3 = xSignal;
xlsub2_parallel_fir3_out3 = xSignal;
xlsub2_adder_tree1_sub = xBlock(struct('source', str2func('adder_tree_init_xblock'), 'name', 'adder_tree1'), ...
                            {4,1,[],[],'Fabric'}, ...
                            {xlsub2_parallel_fir1_out1, xlsub2_parallel_fir_out3, xlsub2_parallel_fir1_out3, xlsub2_parallel_fir2_out3, xlsub2_parallel_fir3_out3}, ...
                            {xlsub2_Out3, xlsub2_Out4});

% block: half_band_xblock/Subsystem/adder_tree3
xlsub2_parallel_fir2_out1 = xSignal;
xlsub2_parallel_fir_out4 = xSignal;
xlsub2_parallel_fir1_out4 = xSignal;
xlsub2_parallel_fir2_out4 = xSignal;
xlsub2_parallel_fir3_out4 = xSignal;
xlsub2_adder_tree3_sub = xBlock(struct('source',str2func('adder_tree_init_xblock'), 'name', 'adder_tree3'), ...
                            {4,1,[],[],'Fabric'},...
                            {xlsub2_parallel_fir2_out1, xlsub2_parallel_fir_out4, xlsub2_parallel_fir1_out4, xlsub2_parallel_fir2_out4, xlsub2_parallel_fir3_out4}, ...
                            {xlsub2_Out5, xlsub2_Out6});

% block: half_band_xblock/Subsystem/adder_tree4
xlsub2_parallel_fir3_out1 = xSignal;
xlsub2_parallel_fir_out5 = xSignal;
xlsub2_parallel_fir1_out5 = xSignal;
xlsub2_parallel_fir2_out5 = xSignal;
xlsub2_parallel_fir3_out5 = xSignal;
xlsub2_adder_tree4_sub = xBlock(struct('source', str2func('adder_tree_init_xblock'), 'name', 'adder_tree4'), ...
                            {4,1,[],[],'Fabric'}, ...
                            {xlsub2_parallel_fir3_out1, xlsub2_parallel_fir_out5, xlsub2_parallel_fir1_out5, xlsub2_parallel_fir2_out5, xlsub2_parallel_fir3_out5}, ...
                            {xlsub2_Out7, xlsub2_Out8});

% block: half_band_xblock/Subsystem/parallel_fir
xlsub2_parallel_fir_sub = xBlock(struct('source', @xlsub2_parallel_fir, 'name', 'parallel_fir'), ...
                             {0}, ...
                             {xlsub2_In1, xlsub2_In2, xlsub2_In3}, ...
                             {xlsub2_parallel_fir_out1, xlsub2_parallel_fir_out2, xlsub2_parallel_fir_out3, xlsub2_parallel_fir_out4, xlsub2_parallel_fir_out5});

% block: half_band_xblock/Subsystem/parallel_fir1
xlsub2_parallel_fir1_sub = xBlock(struct('source', @xlsub2_parallel_fir1, 'name', 'parallel_fir1'), ...
                              {0}, ...
                              {xlsub2_In4, xlsub2_In5, xlsub2_In6}, ...
                              {xlsub2_parallel_fir1_out1, xlsub2_parallel_fir1_out2, xlsub2_parallel_fir1_out3, xlsub2_parallel_fir1_out4, xlsub2_parallel_fir1_out5});

% block: half_band_xblock/Subsystem/parallel_fir2
xlsub2_parallel_fir2_sub = xBlock(struct('source', @xlsub2_parallel_fir2, 'name', 'parallel_fir2'), ...
                              {0}, ...
                              {xlsub2_In7, xlsub2_In8, xlsub2_In9}, ...
                              {xlsub2_parallel_fir2_out1, xlsub2_parallel_fir2_out2, xlsub2_parallel_fir2_out3, xlsub2_parallel_fir2_out4, xlsub2_parallel_fir2_out5});

% block: half_band_xblock/Subsystem/parallel_fir3
xlsub2_parallel_fir3_sub = xBlock(struct('source', str2func('parallel_fir'), 'name', 'parallel_fir3'), ...
                              {0}, ...
                              {xlsub2_In10, xlsub2_In11, xlsub2_In12}, ...
                              {xlsub2_parallel_fir3_out1, xlsub2_parallel_fir3_out2, xlsub2_parallel_fir3_out3, xlsub2_parallel_fir3_out4, xlsub2_parallel_fir3_out5});





function xlsub2_parallel_fir(filter_coeffs)



%% inports
xlsub3_In1 = xInport('In1');
xlsub3_In2 = xInport('In2');
xlsub3_In3 = xInport('In3');

%% outports
xlsub3_sync_out = xOutport('sync_out');
xlsub3_y0r = xOutport('y0r');
xlsub3_y0i = xOutport('y0i');
xlsub3_y1r = xOutport('y1r');
xlsub3_y1i = xOutport('y1i');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/AddSub1
xlsub3_c_to_ri1_out1 = xSignal;
xlsub3_c_to_ri2_out1 = xSignal;
xlsub3_AddSub1_out1 = xSignal;
xlsub3_AddSub1 = xBlock(struct('source', 'AddSub', 'name', 'AddSub1'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri1_out1, xlsub3_c_to_ri2_out1}, ...
                        {xlsub3_AddSub1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/AddSub2
xlsub3_c_to_ri_out1 = xSignal;
xlsub3_Delay_out1 = xSignal;
xlsub3_AddSub2 = xBlock(struct('source', 'AddSub', 'name', 'AddSub2'), ...
                        [], ...
                        {xlsub3_c_to_ri_out1, xlsub3_Delay_out1}, ...
                        {xlsub3_y0r});

% block: half_band_xblock/Subsystem/parallel_fir/AddSub3
xlsub3_c_to_ri1_out2 = xSignal;
xlsub3_c_to_ri2_out2 = xSignal;
xlsub3_AddSub3_out1 = xSignal;
xlsub3_AddSub3 = xBlock(struct('source', 'AddSub', 'name', 'AddSub3'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri1_out2, xlsub3_c_to_ri2_out2}, ...
                        {xlsub3_AddSub3_out1});

% block: half_band_xblock/Subsystem/parallel_fir/AddSub4
xlsub3_c_to_ri_out2 = xSignal;
xlsub3_Delay1_out1 = xSignal;
xlsub3_AddSub4 = xBlock(struct('source', 'AddSub', 'name', 'AddSub4'), ...
                        [], ...
                        {xlsub3_c_to_ri_out2, xlsub3_Delay1_out1}, ...
                        {xlsub3_y0i});

% block: half_band_xblock/Subsystem/parallel_fir/AddSub5
xlsub3_AddSub5 = xBlock(struct('source', 'AddSub', 'name', 'AddSub5'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri_out1, xlsub3_AddSub1_out1}, ...
                        {xlsub3_y1r});

% block: half_band_xblock/Subsystem/parallel_fir/AddSub6
xlsub3_AddSub6 = xBlock(struct('source', 'AddSub', 'name', 'AddSub6'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri_out2, xlsub3_AddSub3_out1}, ...
                        {xlsub3_y1i});

% block: half_band_xblock/Subsystem/parallel_fir/Delay
xlsub3_Delay = xBlock(struct('source', 'Delay', 'name', 'Delay'), ...
                      [], ...
                      {xlsub3_c_to_ri2_out1}, ...
                      {xlsub3_Delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir/Delay1
xlsub3_Delay1 = xBlock(struct('source', 'Delay', 'name', 'Delay1'), ...
                       [], ...
                       {xlsub3_c_to_ri2_out2}, ...
                       {xlsub3_Delay1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri
xlsub3_f0_out2 = xSignal;
xlsub3_c_to_ri_sub = xBlock(struct('source', @xlsub3_c_to_ri, 'name', 'c_to_ri'), ...
                        {8, 7}, ...
                        {xlsub3_f0_out2}, ...
                        {xlsub3_c_to_ri_out1, xlsub3_c_to_ri_out2});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri1
xlsub3_f0pf1_out2 = xSignal;
xlsub3_c_to_ri1_sub = xBlock(struct('source', @xlsub3_c_to_ri1, 'name', 'c_to_ri1'), ...
                         {8, 7}, ...
                         {xlsub3_f0pf1_out2}, ...
                         {xlsub3_c_to_ri1_out1, xlsub3_c_to_ri1_out2});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri2
xlsub3_f1_out2 = xSignal;
xlsub3_c_to_ri2_sub = xBlock(struct('source', @xlsub3_c_to_ri2, 'name', 'c_to_ri2'), ...
                         {8, 7}, ...
                         {xlsub3_f1_out2}, ...
                         {xlsub3_c_to_ri2_out1, xlsub3_c_to_ri2_out2});

% block: half_band_xblock/Subsystem/parallel_fir/f0
xlsub3_f0_sub = xBlock(struct('source', @xlsub3_f0, 'name', 'f0'), ...
                   {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                   {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                   {xlsub3_sync_out, xlsub3_f0_out2});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1
xlsub3_f0pf1_sub = xBlock(struct('source', @xlsub3_f0pf1, 'name', 'f0pf1'), ...
                      {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                      {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                      {[], xlsub3_f0pf1_out2});

% block: half_band_xblock/Subsystem/parallel_fir/f1
xlsub3_f1_sub = xBlock(struct('source', @xlsub3_f1, 'name', 'f1'), ...
                   {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                   {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                   {[], xlsub3_f1_out2});



function xlsub3_c_to_ri(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_c_to_ri1(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri1/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri1/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri1/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri1/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_c_to_ri2(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri2/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri2/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri2/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir/c_to_ri2/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_f0(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir/f0/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir/f0/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir/f0/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir/f0/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

function xlsub3_f0pf1(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir/f0pf1/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

function xlsub3_f1(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir/f1/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir/f1/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir/f1/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir/f1/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir/f1/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir/f1/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir/f1/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

end

function xlsub2_parallel_fir1(filter_coeffs)



%% inports
xlsub3_In1 = xInport('In1');
xlsub3_In2 = xInport('In2');
xlsub3_In3 = xInport('In3');

%% outports
xlsub3_sync_out = xOutport('sync_out');
xlsub3_y0r = xOutport('y0r');
xlsub3_y0i = xOutport('y0i');
xlsub3_y1r = xOutport('y1r');
xlsub3_y1i = xOutport('y1i');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/AddSub1
xlsub3_c_to_ri1_out1 = xSignal;
xlsub3_c_to_ri2_out1 = xSignal;
xlsub3_AddSub1_out1 = xSignal;
xlsub3_AddSub1 = xBlock(struct('source', 'AddSub', 'name', 'AddSub1'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri1_out1, xlsub3_c_to_ri2_out1}, ...
                        {xlsub3_AddSub1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/AddSub2
xlsub3_c_to_ri_out1 = xSignal;
xlsub3_Delay_out1 = xSignal;
xlsub3_AddSub2 = xBlock(struct('source', 'AddSub', 'name', 'AddSub2'), ...
                        [], ...
                        {xlsub3_c_to_ri_out1, xlsub3_Delay_out1}, ...
                        {xlsub3_y0r});

% block: half_band_xblock/Subsystem/parallel_fir1/AddSub3
xlsub3_c_to_ri1_out2 = xSignal;
xlsub3_c_to_ri2_out2 = xSignal;
xlsub3_AddSub3_out1 = xSignal;
xlsub3_AddSub3 = xBlock(struct('source', 'AddSub', 'name', 'AddSub3'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri1_out2, xlsub3_c_to_ri2_out2}, ...
                        {xlsub3_AddSub3_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/AddSub4
xlsub3_c_to_ri_out2 = xSignal;
xlsub3_Delay1_out1 = xSignal;
xlsub3_AddSub4 = xBlock(struct('source', 'AddSub', 'name', 'AddSub4'), ...
                        [], ...
                        {xlsub3_c_to_ri_out2, xlsub3_Delay1_out1}, ...
                        {xlsub3_y0i});

% block: half_band_xblock/Subsystem/parallel_fir1/AddSub5
xlsub3_AddSub5 = xBlock(struct('source', 'AddSub', 'name', 'AddSub5'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri_out1, xlsub3_AddSub1_out1}, ...
                        {xlsub3_y1r});

% block: half_band_xblock/Subsystem/parallel_fir1/AddSub6
xlsub3_AddSub6 = xBlock(struct('source', 'AddSub', 'name', 'AddSub6'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri_out2, xlsub3_AddSub3_out1}, ...
                        {xlsub3_y1i});

% block: half_band_xblock/Subsystem/parallel_fir1/Delay
xlsub3_Delay = xBlock(struct('source', 'Delay', 'name', 'Delay'), ...
                      [], ...
                      {xlsub3_c_to_ri2_out1}, ...
                      {xlsub3_Delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/Delay1
xlsub3_Delay1 = xBlock(struct('source', 'Delay', 'name', 'Delay1'), ...
                       [], ...
                       {xlsub3_c_to_ri2_out2}, ...
                       {xlsub3_Delay1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri
xlsub3_f0_out2 = xSignal;
xlsub3_c_to_ri_sub = xBlock(struct('source', @xlsub3_c_to_ri, 'name', 'c_to_ri'), ...
                        {8, 7}, ...
                        {xlsub3_f0_out2}, ...
                        {xlsub3_c_to_ri_out1, xlsub3_c_to_ri_out2});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri1
xlsub3_f0pf1_out2 = xSignal;
xlsub3_c_to_ri1_sub = xBlock(struct('source', @xlsub3_c_to_ri1, 'name', 'c_to_ri1'), ...
                         {8, 7}, ...
                         {xlsub3_f0pf1_out2}, ...
                         {xlsub3_c_to_ri1_out1, xlsub3_c_to_ri1_out2});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri2
xlsub3_f1_out2 = xSignal;
xlsub3_c_to_ri2_sub = xBlock(struct('source', @xlsub3_c_to_ri2, 'name', 'c_to_ri2'), ...
                         {8, 7}, ...
                         {xlsub3_f1_out2}, ...
                         {xlsub3_c_to_ri2_out1, xlsub3_c_to_ri2_out2});

% block: half_band_xblock/Subsystem/parallel_fir1/f0
xlsub3_f0_sub = xBlock(struct('source', @xlsub3_f0, 'name', 'f0'), ...
                   {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                   {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                   {xlsub3_sync_out, xlsub3_f0_out2});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1
xlsub3_f0pf1_sub = xBlock(struct('source', @xlsub3_f0pf1, 'name', 'f0pf1'), ...
                      {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                      {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                      {[], xlsub3_f0pf1_out2});

% block: half_band_xblock/Subsystem/parallel_fir1/f1
xlsub3_f1_sub = xBlock(struct('source', @xlsub3_f1, 'name', 'f1'), ...
                   {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                   {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                   {[], xlsub3_f1_out2});



function xlsub3_c_to_ri(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_c_to_ri1(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri1/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri1/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri1/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri1/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_c_to_ri2(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri2/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri2/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri2/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/c_to_ri2/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_f0(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir1/f0/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

function xlsub3_f0pf1(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir1/f0pf1/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

function xlsub3_f1(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir1/f1/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir1/f1/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

end

function xlsub2_parallel_fir2(filter_coeffs)



%% inports
xlsub3_In1 = xInport('In1');
xlsub3_In2 = xInport('In2');
xlsub3_In3 = xInport('In3');

%% outports
xlsub3_sync_out = xOutport('sync_out');
xlsub3_y0r = xOutport('y0r');
xlsub3_y0i = xOutport('y0i');
xlsub3_y1r = xOutport('y1r');
xlsub3_y1i = xOutport('y1i');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/AddSub1
xlsub3_c_to_ri1_out1 = xSignal;
xlsub3_c_to_ri2_out1 = xSignal;
xlsub3_AddSub1_out1 = xSignal;
xlsub3_AddSub1 = xBlock(struct('source', 'AddSub', 'name', 'AddSub1'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri1_out1, xlsub3_c_to_ri2_out1}, ...
                        {xlsub3_AddSub1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/AddSub2
xlsub3_c_to_ri_out1 = xSignal;
xlsub3_Delay_out1 = xSignal;
xlsub3_AddSub2 = xBlock(struct('source', 'AddSub', 'name', 'AddSub2'), ...
                        [], ...
                        {xlsub3_c_to_ri_out1, xlsub3_Delay_out1}, ...
                        {xlsub3_y0r});

% block: half_band_xblock/Subsystem/parallel_fir2/AddSub3
xlsub3_c_to_ri1_out2 = xSignal;
xlsub3_c_to_ri2_out2 = xSignal;
xlsub3_AddSub3_out1 = xSignal;
xlsub3_AddSub3 = xBlock(struct('source', 'AddSub', 'name', 'AddSub3'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri1_out2, xlsub3_c_to_ri2_out2}, ...
                        {xlsub3_AddSub3_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/AddSub4
xlsub3_c_to_ri_out2 = xSignal;
xlsub3_Delay1_out1 = xSignal;
xlsub3_AddSub4 = xBlock(struct('source', 'AddSub', 'name', 'AddSub4'), ...
                        [], ...
                        {xlsub3_c_to_ri_out2, xlsub3_Delay1_out1}, ...
                        {xlsub3_y0i});

% block: half_band_xblock/Subsystem/parallel_fir2/AddSub5
xlsub3_AddSub5 = xBlock(struct('source', 'AddSub', 'name', 'AddSub5'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri_out1, xlsub3_AddSub1_out1}, ...
                        {xlsub3_y1r});

% block: half_band_xblock/Subsystem/parallel_fir2/AddSub6
xlsub3_AddSub6 = xBlock(struct('source', 'AddSub', 'name', 'AddSub6'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri_out2, xlsub3_AddSub3_out1}, ...
                        {xlsub3_y1i});

% block: half_band_xblock/Subsystem/parallel_fir2/Delay
xlsub3_Delay = xBlock(struct('source', 'Delay', 'name', 'Delay'), ...
                      [], ...
                      {xlsub3_c_to_ri2_out1}, ...
                      {xlsub3_Delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/Delay1
xlsub3_Delay1 = xBlock(struct('source', 'Delay', 'name', 'Delay1'), ...
                       [], ...
                       {xlsub3_c_to_ri2_out2}, ...
                       {xlsub3_Delay1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri
xlsub3_f0_out2 = xSignal;
xlsub3_c_to_ri_sub = xBlock(struct('source', @xlsub3_c_to_ri, 'name', 'c_to_ri'), ...
                        {8, 7}, ...
                        {xlsub3_f0_out2}, ...
                        {xlsub3_c_to_ri_out1, xlsub3_c_to_ri_out2});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri1
xlsub3_f0pf1_out2 = xSignal;
xlsub3_c_to_ri1_sub = xBlock(struct('source', @xlsub3_c_to_ri1, 'name', 'c_to_ri1'), ...
                         {8, 7}, ...
                         {xlsub3_f0pf1_out2}, ...
                         {xlsub3_c_to_ri1_out1, xlsub3_c_to_ri1_out2});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri2
xlsub3_f1_out2 = xSignal;
xlsub3_c_to_ri2_sub = xBlock(struct('source', @xlsub3_c_to_ri2, 'name', 'c_to_ri2'), ...
                         {8, 7}, ...
                         {xlsub3_f1_out2}, ...
                         {xlsub3_c_to_ri2_out1, xlsub3_c_to_ri2_out2});

% block: half_band_xblock/Subsystem/parallel_fir2/f0
xlsub3_f0_sub = xBlock(struct('source', @xlsub3_f0, 'name', 'f0'), ...
                   {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                   {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                   {xlsub3_sync_out, xlsub3_f0_out2});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1
xlsub3_f0pf1_sub = xBlock(struct('source', @xlsub3_f0pf1, 'name', 'f0pf1'), ...
                      {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                      {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                      {[], xlsub3_f0pf1_out2});

% block: half_band_xblock/Subsystem/parallel_fir2/f1
xlsub3_f1_sub = xBlock(struct('source', @xlsub3_f1, 'name', 'f1'), ...
                   {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                   {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                   {[], xlsub3_f1_out2});



function xlsub3_c_to_ri(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_c_to_ri1(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri1/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri1/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri1/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri1/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_c_to_ri2(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri2/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri2/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri2/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/c_to_ri2/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_f0(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir2/f0/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

function xlsub3_f0pf1(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir2/f0pf1/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

function xlsub3_f1(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir2/f1/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir2/f1/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

end

function xlsub2_parallel_fir3(filter_coeffs)



%% inports
xlsub3_In1 = xInport('In1');
xlsub3_In2 = xInport('In2');
xlsub3_In3 = xInport('In3');

%% outports
xlsub3_sync_out = xOutport('sync_out');
xlsub3_y0r = xOutport('y0r');
xlsub3_y0i = xOutport('y0i');
xlsub3_y1r = xOutport('y1r');
xlsub3_y1i = xOutport('y1i');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/AddSub1
xlsub3_c_to_ri1_out1 = xSignal;
xlsub3_c_to_ri2_out1 = xSignal;
xlsub3_AddSub1_out1 = xSignal;
xlsub3_AddSub1 = xBlock(struct('source', 'AddSub', 'name', 'AddSub1'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri1_out1, xlsub3_c_to_ri2_out1}, ...
                        {xlsub3_AddSub1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/AddSub2
xlsub3_c_to_ri_out1 = xSignal;
xlsub3_Delay_out1 = xSignal;
xlsub3_AddSub2 = xBlock(struct('source', 'AddSub', 'name', 'AddSub2'), ...
                        [], ...
                        {xlsub3_c_to_ri_out1, xlsub3_Delay_out1}, ...
                        {xlsub3_y0r});

% block: half_band_xblock/Subsystem/parallel_fir3/AddSub3
xlsub3_c_to_ri1_out2 = xSignal;
xlsub3_c_to_ri2_out2 = xSignal;
xlsub3_AddSub3_out1 = xSignal;
xlsub3_AddSub3 = xBlock(struct('source', 'AddSub', 'name', 'AddSub3'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri1_out2, xlsub3_c_to_ri2_out2}, ...
                        {xlsub3_AddSub3_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/AddSub4
xlsub3_c_to_ri_out2 = xSignal;
xlsub3_Delay1_out1 = xSignal;
xlsub3_AddSub4 = xBlock(struct('source', 'AddSub', 'name', 'AddSub4'), ...
                        [], ...
                        {xlsub3_c_to_ri_out2, xlsub3_Delay1_out1}, ...
                        {xlsub3_y0i});

% block: half_band_xblock/Subsystem/parallel_fir3/AddSub5
xlsub3_AddSub5 = xBlock(struct('source', 'AddSub', 'name', 'AddSub5'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri_out1, xlsub3_AddSub1_out1}, ...
                        {xlsub3_y1r});

% block: half_band_xblock/Subsystem/parallel_fir3/AddSub6
xlsub3_AddSub6 = xBlock(struct('source', 'AddSub', 'name', 'AddSub6'), ...
                        struct('mode', 'Subtraction'), ...
                        {xlsub3_c_to_ri_out2, xlsub3_AddSub3_out1}, ...
                        {xlsub3_y1i});

% block: half_band_xblock/Subsystem/parallel_fir3/Delay
xlsub3_Delay = xBlock(struct('source', 'Delay', 'name', 'Delay'), ...
                      [], ...
                      {xlsub3_c_to_ri2_out1}, ...
                      {xlsub3_Delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/Delay1
xlsub3_Delay1 = xBlock(struct('source', 'Delay', 'name', 'Delay1'), ...
                       [], ...
                       {xlsub3_c_to_ri2_out2}, ...
                       {xlsub3_Delay1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri
xlsub3_f0_out2 = xSignal;
xlsub3_c_to_ri_sub = xBlock(struct('source', @xlsub3_c_to_ri, 'name', 'c_to_ri'), ...
                        {8, 7}, ...
                        {xlsub3_f0_out2}, ...
                        {xlsub3_c_to_ri_out1, xlsub3_c_to_ri_out2});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri1
xlsub3_f0pf1_out2 = xSignal;
xlsub3_c_to_ri1_sub = xBlock(struct('source', @xlsub3_c_to_ri1, 'name', 'c_to_ri1'), ...
                         {8, 7}, ...
                         {xlsub3_f0pf1_out2}, ...
                         {xlsub3_c_to_ri1_out1, xlsub3_c_to_ri1_out2});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri2
xlsub3_f1_out2 = xSignal;
xlsub3_c_to_ri2_sub = xBlock(struct('source', @xlsub3_c_to_ri2, 'name', 'c_to_ri2'), ...
                         {8, 7}, ...
                         {xlsub3_f1_out2}, ...
                         {xlsub3_c_to_ri2_out1, xlsub3_c_to_ri2_out2});

% block: half_band_xblock/Subsystem/parallel_fir3/f0
xlsub3_f0_sub = xBlock(struct('source', @xlsub3_f0, 'name', 'f0'), ...
                   {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                   {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                   {xlsub3_sync_out, xlsub3_f0_out2});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1
xlsub3_f0pf1_sub = xBlock(struct('source', @xlsub3_f0pf1, 'name', 'f0pf1'), ...
                      {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                      {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                      {[], xlsub3_f0pf1_out2});

% block: half_band_xblock/Subsystem/parallel_fir3/f1
xlsub3_f1_sub = xBlock(struct('source', @xlsub3_f1, 'name', 'f1'), ...
                   {1, getfield( getfield( get_param( gcb,'UserData' ), 'parameters'),'coeff'), 4, 'Truncate', 1, 2, 25, 24, 'on'}, ...
                   {xlsub3_In1, xlsub3_In2, xlsub3_In3}, ...
                   {[], xlsub3_f1_out2});



function xlsub3_c_to_ri(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_c_to_ri1(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri1/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri1/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri1/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri1/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_c_to_ri2(n_bits, bin_pt)



%% inports
xlsub4_c = xInport('c');

%% outports
xlsub4_re = xOutport('re');
xlsub4_im = xOutport('im');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri2/force_im
xlsub4_slice_im_out1 = xSignal;
xlsub4_force_im = xBlock(struct('source', 'Reinterpret', 'name', 'force_im'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_im_out1}, ...
                         {xlsub4_im});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri2/force_re
xlsub4_slice_re_out1 = xSignal;
xlsub4_force_re = xBlock(struct('source', 'Reinterpret', 'name', 'force_re'), ...
                         struct('force_arith_type', 'on', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'force_bin_pt', 'on', ...
                                'bin_pt', bin_pt), ...
                         {xlsub4_slice_re_out1}, ...
                         {xlsub4_re});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri2/slice_im
xlsub4_slice_im = xBlock(struct('source', 'Slice', 'name', 'slice_im'), ...
                         struct('nbits', n_bits, ...
                                'mode', 'Lower Bit Location + Width'), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_im_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/c_to_ri2/slice_re
xlsub4_slice_re = xBlock(struct('source', 'Slice', 'name', 'slice_re'), ...
                         struct('nbits', n_bits), ...
                         {xlsub4_c}, ...
                         {xlsub4_slice_re_out1});



end

function xlsub3_f0(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir3/f0/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

function xlsub3_f0pf1(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir3/f0pf1/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

function xlsub3_f1(n_inputs, coeff, n_bits, quantization, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub4_sync_in = xInport('sync_in');
xlsub4_real1 = xInport('real1');
xlsub4_imag1 = xInport('imag1');

%% outports
xlsub4_sync_out = xOutport('sync_out');
xlsub4_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/convert1
xlsub4_shift1_out1 = xSignal;
xlsub4_convert1_out1 = xSignal;
xlsub4_convert1 = xBlock(struct('source', 'Convert', 'name', 'convert1'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift1_out1}, ...
                         {xlsub4_convert1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/convert2
xlsub4_shift2_out1 = xSignal;
xlsub4_convert2_out1 = xSignal;
xlsub4_convert2 = xBlock(struct('source', 'Convert', 'name', 'convert2'), ...
                         struct('n_bits', 4, ...
                                'bin_pt', 3, ...
                                'latency', 1), ...
                         {xlsub4_shift2_out1}, ...
                         {xlsub4_convert2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/delay
xlsub4_delay_out1 = xSignal;
xlsub4_delay = xBlock(struct('source', 'Delay', 'name', 'delay'), ...
                      struct('latency', 3), ...
                      {xlsub4_sync_in}, ...
                      {xlsub4_delay_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/ri_to_c
xlsub4_ri_to_c = xBlock(struct('source', 'casper_library_misc/ri_to_c', 'name', 'ri_to_c'), ...
                        [], ...
                        {xlsub4_convert1_out1, xlsub4_convert2_out1}, ...
                        {xlsub4_dout});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/shift1
xlsub4_real_sum_out2 = xSignal;
xlsub4_shift1 = xBlock(struct('source', 'Shift', 'name', 'shift1'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_real_sum_out2}, ...
                       {xlsub4_shift1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/shift2
xlsub4_imag_sum_out2 = xSignal;
xlsub4_shift2 = xBlock(struct('source', 'Shift', 'name', 'shift2'), ...
                       struct('shift_bits', 1), ...
                       {xlsub4_imag_sum_out2}, ...
                       {xlsub4_shift2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col1
xlsub4_fir_col1_out1 = xSignal;
xlsub4_fir_col1_out2 = xSignal;
xlsub4_fir_col1_out3 = xSignal;
xlsub4_fir_col1_out4 = xSignal;
xlsub4_fir_col1_sub = xBlock(struct('source', @xlsub4_fir_col1, 'name', 'fir_col1'), ...
                         {1, 0.10000000000000000555111512312578, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_real1, xlsub4_imag1}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2, xlsub4_fir_col1_out3, xlsub4_fir_col1_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col2
xlsub4_fir_col2_out1 = xSignal;
xlsub4_fir_col2_out2 = xSignal;
xlsub4_fir_col2_out3 = xSignal;
xlsub4_fir_col2_out4 = xSignal;
xlsub4_fir_col2_sub = xBlock(struct('source', @xlsub4_fir_col2, 'name', 'fir_col2'), ...
                         {1, 0.20000000000000001110223024625157, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col1_out1, xlsub4_fir_col1_out2}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2, xlsub4_fir_col2_out3, xlsub4_fir_col2_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col3
xlsub4_fir_col3_out1 = xSignal;
xlsub4_fir_col3_out2 = xSignal;
xlsub4_fir_col3_out3 = xSignal;
xlsub4_fir_col3_out4 = xSignal;
xlsub4_fir_col3_sub = xBlock(struct('source', @xlsub4_fir_col3, 'name', 'fir_col3'), ...
                         {1, 0.29999999999999998889776975374843, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col2_out1, xlsub4_fir_col2_out2}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2, xlsub4_fir_col3_out3, xlsub4_fir_col3_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col4
xlsub4_fir_col4_out1 = xSignal;
xlsub4_fir_col4_out2 = xSignal;
xlsub4_fir_col4_out3 = xSignal;
xlsub4_fir_col4_out4 = xSignal;
xlsub4_fir_col4_sub = xBlock(struct('source', @xlsub4_fir_col4, 'name', 'fir_col4'), ...
                         {1, 0.40000000000000002220446049250313, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col3_out1, xlsub4_fir_col3_out2}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2, xlsub4_fir_col4_out3, xlsub4_fir_col4_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col5
xlsub4_fir_col5_out1 = xSignal;
xlsub4_fir_col5_out2 = xSignal;
xlsub4_fir_col5_out3 = xSignal;
xlsub4_fir_col5_out4 = xSignal;
xlsub4_fir_col5_sub = xBlock(struct('source', @xlsub4_fir_col5, 'name', 'fir_col5'), ...
                         {1, 0.5, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col4_out1, xlsub4_fir_col4_out2}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2, xlsub4_fir_col5_out3, xlsub4_fir_col5_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col6
xlsub4_fir_col6_out1 = xSignal;
xlsub4_fir_col6_out2 = xSignal;
xlsub4_fir_col6_out3 = xSignal;
xlsub4_fir_col6_out4 = xSignal;
xlsub4_fir_col6_sub = xBlock(struct('source', @xlsub4_fir_col6, 'name', 'fir_col6'), ...
                         {1, 0.59999999999999997779553950749687, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col5_out1, xlsub4_fir_col5_out2}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2, xlsub4_fir_col6_out3, xlsub4_fir_col6_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col7
xlsub4_fir_col7_out1 = xSignal;
xlsub4_fir_col7_out2 = xSignal;
xlsub4_fir_col7_out3 = xSignal;
xlsub4_fir_col7_out4 = xSignal;
xlsub4_fir_col7_sub = xBlock(struct('source', @xlsub4_fir_col7, 'name', 'fir_col7'), ...
                         {1, 0.69999999999999995559107901499374, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col6_out1, xlsub4_fir_col6_out2}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2, xlsub4_fir_col7_out3, xlsub4_fir_col7_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col8
xlsub4_fir_col8_out3 = xSignal;
xlsub4_fir_col8_out4 = xSignal;
xlsub4_fir_col8_sub = xBlock(struct('source', @xlsub4_fir_col8, 'name', 'fir_col8'), ...
                         {1, 0.80000000000000004440892098500626, 1, 2, 25, 24, 'on'}, ...
                         {xlsub4_fir_col7_out1, xlsub4_fir_col7_out2}, ...
                         {[], [], xlsub4_fir_col8_out3, xlsub4_fir_col8_out4});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/imag_sum
xlsub4_imag_sum_sub = xBlock(struct('source', @xlsub4_imag_sum, 'name', 'imag_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out4, xlsub4_fir_col2_out4, xlsub4_fir_col3_out4, xlsub4_fir_col4_out4, xlsub4_fir_col5_out4, xlsub4_fir_col6_out4, xlsub4_fir_col7_out4, xlsub4_fir_col8_out4}, ...
                         {[], xlsub4_imag_sum_out2});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/real_sum
xlsub4_real_sum_sub = xBlock(struct('source', @xlsub4_real_sum, 'name', 'real_sum'), ...
                         {8, 1, 'off', 'off'}, ...
                         {xlsub4_delay_out1, xlsub4_fir_col1_out3, xlsub4_fir_col2_out3, xlsub4_fir_col3_out3, xlsub4_fir_col4_out3, xlsub4_fir_col5_out3, xlsub4_fir_col6_out3, xlsub4_fir_col7_out3, xlsub4_fir_col8_out3}, ...
                         {xlsub4_sync_out, xlsub4_real_sum_out2});



function xlsub4_fir_col1(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col1/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.1), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col2(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col2/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.2), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col3(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col3/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.3), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col4(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col4/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.4), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col5(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col5/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.5), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col6(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col6/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.6), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col7(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col7/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.7), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_fir_col8(n_inputs, coeff, add_latency, mult_latency, coeff_bit_width, coeff_bin_pt, adder_tree_hdl)



%% inports
xlsub5_real1 = xInport('real1');
xlsub5_imag1 = xInport('imag1');

%% outports
xlsub5_real_out1 = xOutport('real_out1');
xlsub5_imag_out1 = xOutport('imag_out1');
xlsub5_real_sum = xOutport('real_sum');
xlsub5_imag_sum = xOutport('imag_sum');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/fir_col8/fir_tap1
xlsub5_fir_tap1 = xBlock(struct('source', 'casper_library_downconverter/fir_tap', 'name', 'fir_tap1'), ...
                         struct('factor', 0.8), ...
                         {xlsub5_real1, xlsub5_imag1}, ...
                         {xlsub5_real_out1, xlsub5_imag_out1, xlsub5_real_sum, xlsub5_imag_sum});



end

function xlsub4_imag_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/imag_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/imag_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/imag_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/imag_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/imag_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/imag_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/imag_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/imag_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

function xlsub4_real_sum(n_inputs, latency, first_stage_hdl, behavioral)



%% inports
xlsub5_sync = xInport('sync');
xlsub5_din1 = xInport('din1');
xlsub5_din2 = xInport('din2');
xlsub5_din3 = xInport('din3');
xlsub5_din4 = xInport('din4');
xlsub5_din5 = xInport('din5');
xlsub5_din6 = xInport('din6');
xlsub5_din7 = xInport('din7');
xlsub5_din8 = xInport('din8');

%% outports
xlsub5_sync_out = xOutport('sync_out');
xlsub5_dout = xOutport('dout');

%% diagram

% block: half_band_xblock/Subsystem/parallel_fir3/f1/real_sum/addr1
xlsub5_addr1_out1 = xSignal;
xlsub5_addr1 = xBlock(struct('source', 'AddSub', 'name', 'addr1'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din1, xlsub5_din2}, ...
                      {xlsub5_addr1_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/real_sum/addr2
xlsub5_addr2_out1 = xSignal;
xlsub5_addr2 = xBlock(struct('source', 'AddSub', 'name', 'addr2'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din3, xlsub5_din4}, ...
                      {xlsub5_addr2_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/real_sum/addr3
xlsub5_addr3_out1 = xSignal;
xlsub5_addr3 = xBlock(struct('source', 'AddSub', 'name', 'addr3'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din5, xlsub5_din6}, ...
                      {xlsub5_addr3_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/real_sum/addr4
xlsub5_addr4_out1 = xSignal;
xlsub5_addr4 = xBlock(struct('source', 'AddSub', 'name', 'addr4'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_din7, xlsub5_din8}, ...
                      {xlsub5_addr4_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/real_sum/addr5
xlsub5_addr5_out1 = xSignal;
xlsub5_addr5 = xBlock(struct('source', 'AddSub', 'name', 'addr5'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr1_out1, xlsub5_addr2_out1}, ...
                      {xlsub5_addr5_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/real_sum/addr6
xlsub5_addr6_out1 = xSignal;
xlsub5_addr6 = xBlock(struct('source', 'AddSub', 'name', 'addr6'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr3_out1, xlsub5_addr4_out1}, ...
                      {xlsub5_addr6_out1});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/real_sum/addr7
xlsub5_addr7 = xBlock(struct('source', 'AddSub', 'name', 'addr7'), ...
                      struct('latency', 1, ...
                             'pipelined', 'on', ...
                             'use_rpm', 'on'), ...
                      {xlsub5_addr5_out1, xlsub5_addr6_out1}, ...
                      {xlsub5_dout});

% block: half_band_xblock/Subsystem/parallel_fir3/f1/real_sum/sync_delay
xlsub5_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', 3, ...
                                  'reg_retiming', 'on'), ...
                           {xlsub5_sync}, ...
                           {xlsub5_sync_out});



end

end

end

end

