function hilbert_init_xblock(BitWidth, add_latency, conv_latency)



%% inports
xlsub2_a = xInport('a');
xlsub2_b = xInport('b');

%% outports
xlsub2_even = xOutport('even');
xlsub2_odd = xOutport('odd');

%% diagram

% block: xblocks_library_ffts_internal/hilbert/AddSub
xlsub2_c_to_ri_out1 = xSignal;
xlsub2_c_to_ri1_out1 = xSignal;
xlsub2_AddSub_out1 = xSignal;
xlsub2_AddSub = xBlock(struct('source', 'AddSub', 'name', 'AddSub'), ...
                       struct('latency', add_latency, ...
                              'n_bits', 8, ...
                              'bin_pt', 2, ...
                              'use_behavioral_HDL', 'on', ...
                              'use_rpm', 'on'), ...
                       {xlsub2_c_to_ri_out1, xlsub2_c_to_ri1_out1}, ...
                       {xlsub2_AddSub_out1});

% block: xblocks_library_ffts_internal/hilbert/AddSub1
xlsub2_AddSub1_out1 = xSignal;
xlsub2_AddSub1 = xBlock(struct('source', 'AddSub', 'name', 'AddSub1'), ...
                        struct('mode', 'Subtraction', ...
                               'latency', add_latency, ...
                               'n_bits', 8, ...
                               'bin_pt', 2, ...
                               'use_behavioral_HDL', 'on', ...
                               'use_rpm', 'on'), ...
                        {xlsub2_c_to_ri1_out1, xlsub2_c_to_ri_out1}, ...
                        {xlsub2_AddSub1_out1});

% block: xblocks_library_ffts_internal/hilbert/AddSub2
xlsub2_c_to_ri_out2 = xSignal;
xlsub2_c_to_ri1_out2 = xSignal;
xlsub2_AddSub2_out1 = xSignal;
xlsub2_AddSub2 = xBlock(struct('source', 'AddSub', 'name', 'AddSub2'), ...
                        struct('mode', 'Subtraction', ...
                               'latency', add_latency, ...
                               'n_bits', 8, ...
                               'bin_pt', 2, ...
                               'use_behavioral_HDL', 'on', ...
                               'use_rpm', 'on'), ...
                        {xlsub2_c_to_ri_out2, xlsub2_c_to_ri1_out2}, ...
                        {xlsub2_AddSub2_out1});

% block: xblocks_library_ffts_internal/hilbert/AddSub3
xlsub2_AddSub3_out1 = xSignal;
xlsub2_AddSub3 = xBlock(struct('source', 'AddSub', 'name', 'AddSub3'), ...
                        struct('latency', add_latency, ...
                               'n_bits', 8, ...
                               'bin_pt', 2, ...
                               'use_behavioral_HDL', 'on', ...
                               'use_rpm', 'on'), ...
                        {xlsub2_c_to_ri_out2, xlsub2_c_to_ri1_out2}, ...
                        {xlsub2_AddSub3_out1});

% block: xblocks_library_ffts_internal/hilbert/Convert
xlsub2_Scale_out1 = xSignal;
xlsub2_Convert_out1 = xSignal;
xlsub2_Convert = xBlock(struct('source', 'Convert', 'name', 'Convert'), ...
                        struct('n_bits', BitWidth, ...
                               'bin_pt', BitWidth - 1, ...
                               'quantization', 'Round  (unbiased: Even Values)', ...
                               'latency', conv_latency), ...
                        {xlsub2_Scale_out1}, ...
                        {xlsub2_Convert_out1});

% block: xblocks_library_ffts_internal/hilbert/Convert1
xlsub2_Scale1_out1 = xSignal;
xlsub2_Convert1_out1 = xSignal;
xlsub2_Convert1 = xBlock(struct('source', 'Convert', 'name', 'Convert1'), ...
                         struct('n_bits', BitWidth, ...
                                'bin_pt', BitWidth - 1, ...
                                'quantization', 'Round  (unbiased: Even Values)', ...
                                'latency', conv_latency), ...
                         {xlsub2_Scale1_out1}, ...
                         {xlsub2_Convert1_out1});

% block: xblocks_library_ffts_internal/hilbert/Convert2
xlsub2_Scale2_out1 = xSignal;
xlsub2_Convert2_out1 = xSignal;
xlsub2_Convert2 = xBlock(struct('source', 'Convert', 'name', 'Convert2'), ...
                         struct('n_bits', BitWidth, ...
                                'bin_pt', BitWidth - 1, ...
                                'quantization', 'Round  (unbiased: Even Values)', ...
                                'latency', conv_latency), ...
                         {xlsub2_Scale2_out1}, ...
                         {xlsub2_Convert2_out1});

% block: xblocks_library_ffts_internal/hilbert/Convert3
xlsub2_Scale3_out1 = xSignal;
xlsub2_Convert3_out1 = xSignal;
xlsub2_Convert3 = xBlock(struct('source', 'Convert', 'name', 'Convert3'), ...
                         struct('n_bits', BitWidth, ...
                                'bin_pt', BitWidth - 1, ...
                                'quantization', 'Round  (unbiased: Even Values)', ...
                                'latency', conv_latency), ...
                         {xlsub2_Scale3_out1}, ...
                         {xlsub2_Convert3_out1});

% block: xblocks_library_ffts_internal/hilbert/Scale
xlsub2_Scale = xBlock(struct('source', 'Scale', 'name', 'Scale'), ...
                      struct('scale_factor', -1), ...
                      {xlsub2_AddSub_out1}, ...
                      {xlsub2_Scale_out1});

% block: xblocks_library_ffts_internal/hilbert/Scale1
xlsub2_Scale1 = xBlock(struct('source', 'Scale', 'name', 'Scale1'), ...
                       struct('scale_factor', -1), ...
                       {xlsub2_AddSub1_out1}, ...
                       {xlsub2_Scale1_out1});

% block: xblocks_library_ffts_internal/hilbert/Scale2
xlsub2_Scale2 = xBlock(struct('source', 'Scale', 'name', 'Scale2'), ...
                       struct('scale_factor', -1), ...
                       {xlsub2_AddSub2_out1}, ...
                       {xlsub2_Scale2_out1});

% block: xblocks_library_ffts_internal/hilbert/Scale3
xlsub2_Scale3 = xBlock(struct('source', 'Scale', 'name', 'Scale3'), ...
                       struct('scale_factor', -1), ...
                       {xlsub2_AddSub3_out1}, ...
                       {xlsub2_Scale3_out1});

% block: xblocks_library_ffts_internal/hilbert/c_to_ri
xlsub2_c_to_ri_sub = xBlock(struct('source', str2func('c_to_ri_init_xblock'), 'name', 'c_to_ri'), ...
                        {BitWidth, BitWidth-1}, ...
                        {xlsub2_a}, ...
                        {xlsub2_c_to_ri_out1, xlsub2_c_to_ri_out2});

annotation=sprintf('%d_%d r/i',BitWidth,BitWidth-1);
gcb
set_param(gcb,'AttributesFormatString',annotation);

% block: xblocks_library_ffts_internal/hilbert/c_to_ri1
xlsub2_c_to_ri1_sub = xBlock(struct('source', str2func('c_to_ri_init_xblock'), 'name', 'c_to_ri1'), ...
                         {BitWidth, BitWidth-1}, ...
                         {xlsub2_b}, ...
                         {xlsub2_c_to_ri1_out1, xlsub2_c_to_ri1_out2});
                     

annotation=sprintf('%d_%d r/i',BitWidth,BitWidth-1);
gcb
set_param(gcb,'AttributesFormatString',annotation);

% block: xblocks_library_ffts_internal/hilbert/ri_to_c
xlsub2_ri_to_c_sub = xBlock(struct('source', str2func('ri_to_c_init_xblock'), 'name', 'ri_to_c'), ...
                        {}, ...
                        {xlsub2_Convert_out1, xlsub2_Convert2_out1}, ...
                        {xlsub2_even});
                    


% block: xblocks_library_ffts_internal/hilbert/ri_to_c1
xlsub2_ri_to_c1_sub = xBlock(struct('source', str2func('ri_to_c_init_xblock'), 'name', 'ri_to_c1'), ...
                         {}, ...
                         {xlsub2_Convert3_out1, xlsub2_Convert1_out1}, ...
                         {xlsub2_odd});




end

