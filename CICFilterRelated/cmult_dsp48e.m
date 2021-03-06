function cmult_dsp48e(n_bits_a, bin_pt_a, n_bits_b, bin_pt_b, conjugated, full_precision, n_bits_c, bin_pt_c, quantization, overflow, cast_latency)
% This is a generated function based on subsystem:
%     DSP48CMULT/cmult_dsp48e
% Though there are limitations about the generated script, 
% the main purpose of this utility is to make learning
% Sysgen Script easier.
% 
% To test it, run the following commands from MATLAB console:
% cfg.source = str2func('cmult_dsp48e');
% cfg.toplevel = 'DSP48CMULT/cmult_dsp48e';
% args = {my_n_bits_a, my_bin_pt_a, my_n_bits_b, my_bin_pt_b, my_conjugated, my_full_precision, my_n_bits_c, my_bin_pt_c, my_quantization, my_overflow, my_cast_latency};
% xBlock(cfg, args);
% 
% You can edit cmult_dsp48e.m to debug your script.
% 
% You can also replace the MaskInitialization code with the 
% following commands so the subsystem will be generated 
% according to the values of mask parameters.
% cfg.source = str2func('cmult_dsp48e');
% cfg.toplevel = gcb;
% args = {n_bits_a, bin_pt_a, n_bits_b, bin_pt_b, conjugated, full_precision, n_bits_c, bin_pt_c, quantization, overflow, cast_latency};
% xBlock(cfg, args);
% 
% To configure the xBlock call in debug mode, in which mode,
% autolayout will be performed every time a block is added,
% run the following commands:
% cfg.source = str2func('cmult_dsp48e');
% cfg.toplevel = gcb;
% cfg.debug = 1;
% args = {n_bits_a, bin_pt_a, n_bits_b, bin_pt_b, conjugated, full_precision, n_bits_c, bin_pt_c, quantization, overflow, cast_latency};
% xBlock(cfg, args);
% 
% To make the xBlock smart so it won't re-generate the
% subsystem if neither the arguments nor the scripts are
% changes, use as the following:
% cfg.source = str2func('cmult_dsp48e');
% cfg.toplevel = gcb;
% cfg.depend = {'cmult_dsp48e'};
% args = {n_bits_a, bin_pt_a, n_bits_b, bin_pt_b, conjugated, full_precision, n_bits_c, bin_pt_c, quantization, overflow, cast_latency};
% xBlock(cfg, args);
% 
% See also xBlock, xInport, xOutport, xSignal, xlsub2script.


%% inports
xlsub2_a_re = xInport('a_re');
xlsub2_a_im = xInport('a_im');
xlsub2_b_re = xInport('b_re');
xlsub2_b_im = xInport('b_im');

%% outports
xlsub2_c_re = xOutport('c_re');
xlsub2_c_im = xOutport('c_im');

%% diagram

% block: DSP48CMULT/cmult_dsp48e/Convert
xlsub2_reinterp_a_im_out1 = xSignal;
xlsub2_Convert_out1 = xSignal;
xlsub2_Convert = xBlock(struct('source', 'Convert', 'name', 'Convert'), ...
                        struct('n_bits', 30, ...
                               'bin_pt', 0, ...
                               'pipeline', 'on'), ...
                        {xlsub2_reinterp_a_im_out1}, ...
                        {xlsub2_Convert_out1});

% block: DSP48CMULT/cmult_dsp48e/Convert1
xlsub2_Convert1_out1 = xSignal;
xlsub2_Convert1 = xBlock(struct('source', 'Convert', 'name', 'Convert1'), ...
                         struct('n_bits', 30, ...
                                'bin_pt', 0, ...
                                'pipeline', 'on'), ...
                         {xlsub2_reinterp_a_im_out1}, ...
                         {xlsub2_Convert1_out1});

% block: DSP48CMULT/cmult_dsp48e/Convert2
xlsub2_reinterp_a_re_out1 = xSignal;
xlsub2_Convert2_out1 = xSignal;
xlsub2_Convert2 = xBlock(struct('source', 'Convert', 'name', 'Convert2'), ...
                         struct('n_bits', 30, ...
                                'bin_pt', 0, ...
                                'pipeline', 'on'), ...
                         {xlsub2_reinterp_a_re_out1}, ...
                         {xlsub2_Convert2_out1});

% block: DSP48CMULT/cmult_dsp48e/Convert3
xlsub2_reinterp_b_im_out1 = xSignal;
xlsub2_Convert3_out1 = xSignal;
xlsub2_Convert3 = xBlock(struct('source', 'Convert', 'name', 'Convert3'), ...
                         struct('n_bits', 18, ...
                                'bin_pt', 0, ...
                                'pipeline', 'on'), ...
                         {xlsub2_reinterp_b_im_out1}, ...
                         {xlsub2_Convert3_out1});

% block: DSP48CMULT/cmult_dsp48e/Convert4
xlsub2_reinterp_b_re_out1 = xSignal;
xlsub2_Convert4_out1 = xSignal;
xlsub2_Convert4 = xBlock(struct('source', 'Convert', 'name', 'Convert4'), ...
                         struct('n_bits', 18, ...
                                'bin_pt', 0, ...
                                'pipeline', 'on'), ...
                         {xlsub2_reinterp_b_re_out1}, ...
                         {xlsub2_Convert4_out1});

% block: DSP48CMULT/cmult_dsp48e/Convert5
xlsub2_Convert5_out1 = xSignal;
xlsub2_Convert5 = xBlock(struct('source', 'Convert', 'name', 'Convert5'), ...
                         struct('n_bits', 30, ...
                                'bin_pt', 0, ...
                                'pipeline', 'on'), ...
                         {xlsub2_reinterp_a_re_out1}, ...
                         {xlsub2_Convert5_out1});

% block: DSP48CMULT/cmult_dsp48e/Convert6
xlsub2_Convert6_out1 = xSignal;
xlsub2_Convert6 = xBlock(struct('source', 'Convert', 'name', 'Convert6'), ...
                         struct('n_bits', 18, ...
                                'bin_pt', 0, ...
                                'pipeline', 'on'), ...
                         {xlsub2_reinterp_b_re_out1}, ...
                         {xlsub2_Convert6_out1});

% block: DSP48CMULT/cmult_dsp48e/Convert7
xlsub2_Convert7_out1 = xSignal;
xlsub2_Convert7 = xBlock(struct('source', 'Convert', 'name', 'Convert7'), ...
                         struct('n_bits', 18, ...
                                'bin_pt', 0, ...
                                'pipeline', 'on'), ...
                         {xlsub2_reinterp_b_im_out1}, ...
                         {xlsub2_Convert7_out1});

% block: DSP48CMULT/cmult_dsp48e/DSP48E_0
xlsub2_opmode0_out1 = xSignal;
xlsub2_alumode0_out1 = xSignal;
xlsub2_carryin0_out1 = xSignal;
xlsub2_carryinsel0_out1 = xSignal;
xlsub2_DSP48E_0_out1 = xSignal;
xlsub2_DSP48E_0_out2 = xSignal;
xlsub2_DSP48E_0 = xBlock(struct('source', 'DSP48E', 'name', 'DSP48E_0'), ...
                         struct('use_pcout', 'on'), ...
                         {xlsub2_Convert5_out1, xlsub2_Convert7_out1, xlsub2_opmode0_out1, xlsub2_alumode0_out1, xlsub2_carryin0_out1, xlsub2_carryinsel0_out1}, ...
                         {xlsub2_DSP48E_0_out1, xlsub2_DSP48E_0_out2});

% block: DSP48CMULT/cmult_dsp48e/DSP48E_1
xlsub2_opmode1_out1 = xSignal;
xlsub2_alumode1_out1 = xSignal;
xlsub2_carryin1_out1 = xSignal;
xlsub2_carryinsel1_out1 = xSignal;
xlsub2_DSP48E_1_out1 = xSignal;
xlsub2_DSP48E_1 = xBlock(struct('source', 'DSP48E', 'name', 'DSP48E_1'), ...
                         struct('use_pcin', 'on', ...
                                'pipeline_a', '2', ...
                                'pipeline_b', '2'), ...
                         {xlsub2_Convert1_out1, xlsub2_Convert6_out1, xlsub2_DSP48E_0_out2, xlsub2_opmode1_out1, xlsub2_alumode1_out1, xlsub2_carryin1_out1, xlsub2_carryinsel1_out1}, ...
                         {xlsub2_DSP48E_1_out1});

% block: DSP48CMULT/cmult_dsp48e/DSP48E_2
xlsub2_opmode2_out1 = xSignal;
xlsub2_alumode2_out1 = xSignal;
xlsub2_carryin2_out1 = xSignal;
xlsub2_carryinsel2_out1 = xSignal;
xlsub2_DSP48E_2_out1 = xSignal;
xlsub2_DSP48E_2_out2 = xSignal;
xlsub2_DSP48E_2 = xBlock(struct('source', 'DSP48E', 'name', 'DSP48E_2'), ...
                         struct('use_pcout', 'on'), ...
                         {xlsub2_Convert2_out1, xlsub2_Convert4_out1, xlsub2_opmode2_out1, xlsub2_alumode2_out1, xlsub2_carryin2_out1, xlsub2_carryinsel2_out1}, ...
                         {xlsub2_DSP48E_2_out1, xlsub2_DSP48E_2_out2});

% block: DSP48CMULT/cmult_dsp48e/DSP48E_3
xlsub2_opmode3_out1 = xSignal;
xlsub2_alumode3_out1 = xSignal;
xlsub2_carryin3_out1 = xSignal;
xlsub2_carryinsel3_out1 = xSignal;
xlsub2_DSP48E_3_out1 = xSignal;
xlsub2_DSP48E_3 = xBlock(struct('source', 'DSP48E', 'name', 'DSP48E_3'), ...
                         struct('use_pcin', 'on', ...
                                'pipeline_a', '2', ...
                                'pipeline_b', '2'), ...
                         {xlsub2_Convert_out1, xlsub2_Convert3_out1, xlsub2_DSP48E_2_out2, xlsub2_opmode3_out1, xlsub2_alumode3_out1, xlsub2_carryin3_out1, xlsub2_carryinsel3_out1}, ...
                         {xlsub2_DSP48E_3_out1});



% block: DSP48CMULT/cmult_dsp48e/alumode0
xlsub2_alumode0 = xBlock(struct('source', 'Constant', 'name', 'alumode0'), ...
                         struct('arith_type', 'Unsigned', ...
                                'const', 0, ...
                                'n_bits', 4, ...
                                'bin_pt', 0), ...
                         {}, ...
                         {xlsub2_alumode0_out1});

% block: DSP48CMULT/cmult_dsp48e/alumode1
xlsub2_alumode1 = xBlock(struct('source', 'Constant', 'name', 'alumode1'), ...
                         struct('arith_type', 'Unsigned', ...
                                'const', 0, ...
                                'n_bits', 4, ...
                                'bin_pt', 0), ...
                         {}, ...
                         {xlsub2_alumode1_out1});

% block: DSP48CMULT/cmult_dsp48e/alumode2
xlsub2_alumode2 = xBlock(struct('source', 'Constant', 'name', 'alumode2'), ...
                         struct('arith_type', 'Unsigned', ...
                                'const', 0, ...
                                'n_bits', 4, ...
                                'bin_pt', 0), ...
                         {}, ...
                         {xlsub2_alumode2_out1});

% block: DSP48CMULT/cmult_dsp48e/alumode3
xlsub2_alumode3 = xBlock(struct('source', 'Constant', 'name', 'alumode3'), ...
                         struct('arith_type', 'Unsigned', ...
                                'const', 3, ...
                                'n_bits', 4, ...
                                'bin_pt', 0), ...
                         {}, ...
                         {xlsub2_alumode3_out1});

% block: DSP48CMULT/cmult_dsp48e/carryin0
xlsub2_carryin0 = xBlock(struct('source', 'Constant', 'name', 'carryin0'), ...
                         struct('arith_type', 'Unsigned', ...
                                'const', 0, ...
                                'n_bits', 1, ...
                                'bin_pt', 0), ...
                         {}, ...
                         {xlsub2_carryin0_out1});

% block: DSP48CMULT/cmult_dsp48e/carryin1
xlsub2_carryin1 = xBlock(struct('source', 'Constant', 'name', 'carryin1'), ...
                         struct('arith_type', 'Unsigned', ...
                                'const', 0, ...
                                'n_bits', 1, ...
                                'bin_pt', 0), ...
                         {}, ...
                         {xlsub2_carryin1_out1});

% block: DSP48CMULT/cmult_dsp48e/carryin2
xlsub2_carryin2 = xBlock(struct('source', 'Constant', 'name', 'carryin2'), ...
                         struct('arith_type', 'Unsigned', ...
                                'const', 0, ...
                                'n_bits', 1, ...
                                'bin_pt', 0), ...
                         {}, ...
                         {xlsub2_carryin2_out1});

% block: DSP48CMULT/cmult_dsp48e/carryin3
xlsub2_carryin3 = xBlock(struct('source', 'Constant', 'name', 'carryin3'), ...
                         struct('arith_type', 'Unsigned', ...
                                'const', 0, ...
                                'n_bits', 1, ...
                                'bin_pt', 0), ...
                         {}, ...
                         {xlsub2_carryin3_out1});

% block: DSP48CMULT/cmult_dsp48e/carryinsel0
xlsub2_carryinsel0 = xBlock(struct('source', 'Constant', 'name', 'carryinsel0'), ...
                            struct('arith_type', 'Unsigned', ...
                                   'const', 0, ...
                                   'n_bits', 3, ...
                                   'bin_pt', 0), ...
                            {}, ...
                            {xlsub2_carryinsel0_out1});

% block: DSP48CMULT/cmult_dsp48e/carryinsel1
xlsub2_carryinsel1 = xBlock(struct('source', 'Constant', 'name', 'carryinsel1'), ...
                            struct('arith_type', 'Unsigned', ...
                                   'const', 0, ...
                                   'n_bits', 3, ...
                                   'bin_pt', 0), ...
                            {}, ...
                            {xlsub2_carryinsel1_out1});

% block: DSP48CMULT/cmult_dsp48e/carryinsel2
xlsub2_carryinsel2 = xBlock(struct('source', 'Constant', 'name', 'carryinsel2'), ...
                            struct('arith_type', 'Unsigned', ...
                                   'const', 0, ...
                                   'n_bits', 3, ...
                                   'bin_pt', 0), ...
                            {}, ...
                            {xlsub2_carryinsel2_out1});

% block: DSP48CMULT/cmult_dsp48e/carryinsel3
xlsub2_carryinsel3 = xBlock(struct('source', 'Constant', 'name', 'carryinsel3'), ...
                            struct('arith_type', 'Unsigned', ...
                                   'const', 0, ...
                                   'n_bits', 3, ...
                                   'bin_pt', 0), ...
                            {}, ...
                            {xlsub2_carryinsel3_out1});

% block: DSP48CMULT/cmult_dsp48e/cast_c_im
xlsub2_reinterp_c_im_out1 = xSignal;
xlsub2_cast_c_im = xBlock(struct('source', 'Convert', 'name', 'cast_c_im'), ...
                          struct('n_bits', 37, ...
                                 'bin_pt', 34, ...
                                 'pipeline', 'on'), ...
                          {xlsub2_reinterp_c_im_out1}, ...
                          {xlsub2_c_im});

% block: DSP48CMULT/cmult_dsp48e/cast_c_re
xlsub2_reinterp_c_re_out1 = xSignal;
xlsub2_cast_c_re = xBlock(struct('source', 'Convert', 'name', 'cast_c_re'), ...
                          struct('n_bits', 37, ...
                                 'bin_pt', 34, ...
                                 'pipeline', 'on'), ...
                          {xlsub2_reinterp_c_re_out1}, ...
                          {xlsub2_c_re});

% block: DSP48CMULT/cmult_dsp48e/opmode0
xlsub2_opmode0 = xBlock(struct('source', 'Constant', 'name', 'opmode0'), ...
                        struct('arith_type', 'Unsigned', ...
                               'const', 5, ...
                               'n_bits', 7, ...
                               'bin_pt', 0), ...
                        {}, ...
                        {xlsub2_opmode0_out1});

% block: DSP48CMULT/cmult_dsp48e/opmode1
xlsub2_opmode1 = xBlock(struct('source', 'Constant', 'name', 'opmode1'), ...
                        struct('arith_type', 'Unsigned', ...
                               'const', 21, ...
                               'n_bits', 7, ...
                               'bin_pt', 0), ...
                        {}, ...
                        {xlsub2_opmode1_out1});

% block: DSP48CMULT/cmult_dsp48e/opmode2
xlsub2_opmode2 = xBlock(struct('source', 'Constant', 'name', 'opmode2'), ...
                        struct('arith_type', 'Unsigned', ...
                               'const', 5, ...
                               'n_bits', 7, ...
                               'bin_pt', 0), ...
                        {}, ...
                        {xlsub2_opmode2_out1});

% block: DSP48CMULT/cmult_dsp48e/opmode3
xlsub2_opmode3 = xBlock(struct('source', 'Constant', 'name', 'opmode3'), ...
                        struct('arith_type', 'Unsigned', ...
                               'const', 21, ...
                               'n_bits', 7, ...
                               'bin_pt', 0), ...
                        {}, ...
                        {xlsub2_opmode3_out1});

% block: DSP48CMULT/cmult_dsp48e/realign_a_im
xlsub2_realign_a_im_out1 = xSignal;
xlsub2_realign_a_im = xBlock(struct('source', 'Convert', 'name', 'realign_a_im'), ...
                             struct('n_bits', 18, ...
                                    'bin_pt', 17, ...
                                    'pipeline', 'on'), ...
                             {xlsub2_a_im}, ...
                             {xlsub2_realign_a_im_out1});

% block: DSP48CMULT/cmult_dsp48e/realign_a_re
xlsub2_realign_a_re_out1 = xSignal;
xlsub2_realign_a_re = xBlock(struct('source', 'Convert', 'name', 'realign_a_re'), ...
                             struct('n_bits', 18, ...
                                    'bin_pt', 17, ...
                                    'pipeline', 'on'), ...
                             {xlsub2_a_re}, ...
                             {xlsub2_realign_a_re_out1});

% block: DSP48CMULT/cmult_dsp48e/realign_b_im
xlsub2_realign_b_im_out1 = xSignal;
xlsub2_realign_b_im = xBlock(struct('source', 'Convert', 'name', 'realign_b_im'), ...
                             struct('n_bits', 18, ...
                                    'bin_pt', 17, ...
                                    'pipeline', 'on'), ...
                             {xlsub2_b_im}, ...
                             {xlsub2_realign_b_im_out1});

% block: DSP48CMULT/cmult_dsp48e/realign_b_re
xlsub2_realign_b_re_out1 = xSignal;
xlsub2_realign_b_re = xBlock(struct('source', 'Convert', 'name', 'realign_b_re'), ...
                             struct('n_bits', 18, ...
                                    'bin_pt', 17, ...
                                    'pipeline', 'on'), ...
                             {xlsub2_b_re}, ...
                             {xlsub2_realign_b_re_out1});

% block: DSP48CMULT/cmult_dsp48e/reinterp_a_im
xlsub2_reinterp_a_im = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_a_im'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub2_realign_a_im_out1}, ...
                              {xlsub2_reinterp_a_im_out1});

% block: DSP48CMULT/cmult_dsp48e/reinterp_a_re
xlsub2_reinterp_a_re = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_a_re'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub2_realign_a_re_out1}, ...
                              {xlsub2_reinterp_a_re_out1});

% block: DSP48CMULT/cmult_dsp48e/reinterp_b_im
xlsub2_reinterp_b_im = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_b_im'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub2_realign_b_im_out1}, ...
                              {xlsub2_reinterp_b_im_out1});

% block: DSP48CMULT/cmult_dsp48e/reinterp_b_re
xlsub2_reinterp_b_re = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_b_re'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on'), ...
                              {xlsub2_realign_b_re_out1}, ...
                              {xlsub2_reinterp_b_re_out1});

% block: DSP48CMULT/cmult_dsp48e/reinterp_c_im
xlsub2_reinterp_c_im = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_c_im'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on', ...
                                     'bin_pt', 34), ...
                              {xlsub2_DSP48E_1_out1}, ...
                              {xlsub2_reinterp_c_im_out1});

% block: DSP48CMULT/cmult_dsp48e/reinterp_c_re
xlsub2_reinterp_c_re = xBlock(struct('source', 'Reinterpret', 'name', 'reinterp_c_re'), ...
                              struct('force_arith_type', 'on', ...
                                     'arith_type', 'Signed  (2''s comp)', ...
                                     'force_bin_pt', 'on', ...
                                     'bin_pt', 34), ...
                              {xlsub2_DSP48E_3_out1}, ...
                              {xlsub2_reinterp_c_re_out1});



end

