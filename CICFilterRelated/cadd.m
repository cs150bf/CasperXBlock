function xlsub6_cadd(mode, n_bits_a, bin_pt_a, n_bits_b, bin_pt_b, full_precision, n_bits_c, bin_pt_c, quantization, overflow, cast_latency)



%% inports
xlsub7_a_re = xInport('a_re');
xlsub7_a_im = xInport('a_im');
xlsub7_b_re = xInport('b_re');
xlsub7_b_im = xInport('b_im');

%% outports
xlsub7_c_re = xOutport('c_re');
xlsub7_c_im = xOutport('c_im');

%% diagram

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/DSP48E
xlsub7_Reinterpret_A_out1 = xSignal;
xlsub7_Reinterpret_B_out1 = xSignal;
xlsub7_Reinterpret_C_out1 = xSignal;
xlsub7_opmode_out1 = xSignal;
xlsub7_alumode_out1 = xSignal;
xlsub7_carryin_out1 = xSignal;
xlsub7_carryinsel_out1 = xSignal;
xlsub7_DSP48E_out1 = xSignal;
xlsub7_DSP48E = xBlock(struct('source', 'DSP48E', 'name', 'DSP48E'), ...
                       struct('use_creg', 'on', ...
                              'addsub_mode', 'TWO24'), ...
                       {xlsub7_Reinterpret_A_out1, xlsub7_Reinterpret_B_out1, xlsub7_Reinterpret_C_out1, xlsub7_opmode_out1, xlsub7_alumode_out1, xlsub7_carryin_out1, xlsub7_carryinsel_out1}, ...
                       {xlsub7_DSP48E_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/Reinterpret_A
xlsub7_Slice_A_out1 = xSignal;
xlsub7_Reinterpret_A = xBlock(struct('source', 'Reinterpret', 'name', 'Reinterpret_A'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub7_Slice_A_out1}, ...
                              {xlsub7_Reinterpret_A_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/Reinterpret_B
xlsub7_Slice_B_out1 = xSignal;
xlsub7_Reinterpret_B = xBlock(struct('source', 'Reinterpret', 'name', 'Reinterpret_B'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub7_Slice_B_out1}, ...
                              {xlsub7_Reinterpret_B_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/Reinterpret_C
xlsub7_concat_a_out1 = xSignal;
xlsub7_Reinterpret_C = xBlock(struct('source', 'Reinterpret', 'name', 'Reinterpret_C'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub7_concat_a_out1}, ...
                              {xlsub7_Reinterpret_C_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/Slice_A
xlsub7_concat_b_out1 = xSignal;
xlsub7_Slice_A = xBlock(struct('source', 'Slice', 'name', 'Slice_A'), ...
                        struct('nbits', 30), ...
                        {xlsub7_concat_b_out1}, ...
                        {xlsub7_Slice_A_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/Slice_B
xlsub7_Slice_B = xBlock(struct('source', 'Slice', 'name', 'Slice_B'), ...
                        struct('nbits', 18, ...
                               'mode', 'Lower Bit Location + Width'), ...
                        {xlsub7_concat_b_out1}, ...
                        {xlsub7_Slice_B_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/alumode
xlsub7_alumode = xBlock(struct('source', 'Constant', 'name', 'alumode'), ...
                        struct('arith_type', 'Unsigned', ...
                               'const', 0, ...
                               'n_bits', 4, ...
                               'bin_pt', 0), ...
                        {}, ...
                        {xlsub7_alumode_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/carryin
xlsub7_carryin = xBlock(struct('source', 'Constant', 'name', 'carryin'), ...
                        struct('arith_type', 'Unsigned', ...
                               'const', 0, ...
                               'n_bits', 1, ...
                               'bin_pt', 0), ...
                        {}, ...
                        {xlsub7_carryin_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/carryinsel
xlsub7_carryinsel = xBlock(struct('source', 'Constant', 'name', 'carryinsel'), ...
                           struct('arith_type', 'Unsigned', ...
                                  'const', 0, ...
                                  'n_bits', 3, ...
                                  'bin_pt', 0), ...
                           {}, ...
                           {xlsub7_carryinsel_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/cast_c_im
xlsub7_reinterp_c_im_out1 = xSignal;
xlsub7_cast_c_im = xBlock(struct('source', 'Convert', 'name', 'cast_c_im'), ...
                          struct('n_bits', 19, ...
                                 'bin_pt', 17, ...
                                 'pipeline', 'on'), ...
                          {xlsub7_reinterp_c_im_out1}, ...
                          {xlsub7_c_im});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/cast_c_re
xlsub7_reinterp_c_re_out1 = xSignal;
xlsub7_cast_c_re = xBlock(struct('source', 'Convert', 'name', 'cast_c_re'), ...
                          struct('n_bits', 19, ...
                                 'bin_pt', 17, ...
                                 'pipeline', 'on'), ...
                          {xlsub7_reinterp_c_re_out1}, ...
                          {xlsub7_c_re});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/concat_a
xlsub7_reinterp_a_re_out1 = xSignal;
xlsub7_reinterp_a_im_out1 = xSignal;
xlsub7_concat_a = xBlock(struct('source', 'Concat', 'name', 'concat_a'), ...
                         [], ...
                         {xlsub7_reinterp_a_re_out1, xlsub7_reinterp_a_im_out1}, ...
                         {xlsub7_concat_a_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/concat_b
xlsub7_reinterp_b_re_out1 = xSignal;
xlsub7_reinterp_b_im_out1 = xSignal;
xlsub7_concat_b = xBlock(struct('source', 'Concat', 'name', 'concat_b'), ...
                         [], ...
                         {xlsub7_reinterp_b_re_out1, xlsub7_reinterp_b_im_out1}, ...
                         {xlsub7_concat_b_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/opmode
xlsub7_opmode = xBlock(struct('source', 'Constant', 'name', 'opmode'), ...
                       struct('arith_type', 'Unsigned', ...
                              'const', 51, ...
                              'n_bits', 7, ...
                              'bin_pt', 0), ...
                       {}, ...
                       {xlsub7_opmode_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/realign_a_im
xlsub7_realign_a_im_out1 = xSignal;
xlsub7_realign_a_im = xBlock(struct('source', 'Convert', 'name', 'realign_a_im'), ...
                             struct('n_bits', 24, ...
                                    'bin_pt', 21, ...
                                    'pipeline', 'on'), ...
                             {xlsub7_a_im}, ...
                             {xlsub7_realign_a_im_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/realign_a_re
xlsub7_realign_a_re_out1 = xSignal;
xlsub7_realign_a_re = xBlock(struct('source', 'Convert', 'name', 'realign_a_re'), ...
                             struct('n_bits', 24, ...
                                    'bin_pt', 21, ...
                                    'pipeline', 'on'), ...
                             {xlsub7_a_re}, ...
                             {xlsub7_realign_a_re_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/realign_b_im
xlsub7_realign_b_im_out1 = xSignal;
xlsub7_realign_b_im = xBlock(struct('source', 'Convert', 'name', 'realign_b_im'), ...
                             struct('n_bits', 24, ...
                                    'bin_pt', 21, ...
                                    'pipeline', 'on'), ...
                             {xlsub7_b_im}, ...
                             {xlsub7_realign_b_im_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/realign_b_re
xlsub7_realign_b_re_out1 = xSignal;
xlsub7_realign_b_re = xBlock(struct('source', 'Convert', 'name', 'realign_b_re'), ...
                             struct('n_bits', 24, ...
                                    'bin_pt', 21, ...
                                    'pipeline', 'on'), ...
                             {xlsub7_b_re}, ...
                             {xlsub7_realign_b_re_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/reinterp_a_im
xlsub7_reinterp_a_im = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_a_im'), ...
                              struct('force_arith_type', 'on', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub7_realign_a_im_out1}, ...
                              {xlsub7_reinterp_a_im_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/reinterp_a_re
xlsub7_reinterp_a_re = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_a_re'), ...
                              struct('force_arith_type', 'on', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub7_realign_a_re_out1}, ...
                              {xlsub7_reinterp_a_re_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/reinterp_b_im
xlsub7_reinterp_b_im = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_b_im'), ...
                              struct('force_arith_type', 'on', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub7_realign_b_im_out1}, ...
                              {xlsub7_reinterp_b_im_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/reinterp_b_re
xlsub7_reinterp_b_re = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_b_re'), ...
                              struct('force_arith_type', 'on', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub7_realign_b_re_out1}, ...
                              {xlsub7_reinterp_b_re_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/reinterp_c_im
xlsub7_slice_c_im_out1 = xSignal;
xlsub7_reinterp_c_im = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_c_im'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on', ...
                                     'bin_pt', 21), ...
                              {xlsub7_slice_c_im_out1}, ...
                              {xlsub7_reinterp_c_im_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/reinterp_c_re
xlsub7_slice_c_re_out1 = xSignal;
xlsub7_reinterp_c_re = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_c_re'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on', ...
                                     'bin_pt', 21), ...
                              {xlsub7_slice_c_re_out1}, ...
                              {xlsub7_reinterp_c_re_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/slice_c_im
xlsub7_slice_c_im = xBlock(struct('source', 'Slice', 'name', 'slice_c_im'), ...
                           struct('nbits', 24, ...
                                  'mode', 'Lower Bit Location + Width'), ...
                           {xlsub7_DSP48E_out1}, ...
                           {xlsub7_slice_c_im_out1});

% block: single_pol_xblock_tb/fft_wideband_real1/fft_biplex_real_4x0/biplex_core/fft_stage_1/butterfly_direct/cadd/slice_c_re
xlsub7_slice_c_re = xBlock(struct('source', 'Slice', 'name', 'slice_c_re'), ...
                           struct('nbits', 24, ...
                                  'mode', 'Lower Bit Location + Width', ...
                                  'bit0', 24), ...
                           {xlsub7_DSP48E_out1}, ...
                           {xlsub7_slice_c_re_out1});



end