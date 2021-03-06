% Hong Chen 
% Feb 10, 2011 version 1.0

function delay7(delaytype, varargin)

switch delaytype
	case 'delay_bram'
		defaults = {'DelayLen',6,'bram_latency',2,'use_dsp48','off'};
		DelayLen = get_var('DelayLen', 'defaults', defaults, varargin{:});
		bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
		use_dsp48 = get_var('use_dsp48', 'defaults', defaults, varargin{:});
        if (DelayLen <= bram_latency)
            error('delay value must be greater than BRAM Latency');
        end
        BitWidth = max(ceil(log2(DelayLen)), 2);
        if strcmp(use_dsp48, 'on'),
            use_dsp48_im='DSP48';
        else
            use_dsp48_im='Fabric';
        end

        %% inports
        xlsub2_In1 = xInport('In1');

        %% outports
        xlsub2_Out1 = xOutport('Out1');

        %% diagram

        % block: delay_7/delay_bram/Constant2
        xlsub2_Constant2_out1 = xSignal;
        xlsub2_Constant2 = xBlock(struct('source', 'Constant', 'name', 'Constant2'), ...
                                  struct('arith_type', 'Boolean', ...
                                         'n_bits', 1, ...
                                         'bin_pt', 0, ...
                                         'explicit_period', 'on'), ...
                                  {}, ...
                                  {xlsub2_Constant2_out1});

        % block: delay_7/delay_bram/Counter
        xlsub2_Counter_out1 = xSignal;
        xlsub2_Counter = xBlock(struct('source', 'Counter', 'name', 'Counter'), ...
                                struct('cnt_type', 'Count Limited', ...
                                       'cnt_to', DelayLen - bram_latency - 1, ...
                                       'n_bits', BitWidth, ...
                                       'use_rpm', use_dsp48, ...
                                       'implementation', use_dsp48_im), ...
                                {}, ...
                                {xlsub2_Counter_out1});

        % block: delay_7/delay_bram/Single Port RAM
        xlsub2_Single_Port_RAM = xBlock(struct('source', 'Single Port RAM', 'name', 'Single Port RAM'), ...
                                        struct('depth', 2^BitWidth, ...
                                               'initVector', 0, ...
                                               'write_mode', 'Read Before Write', ...
                                               'latency', bram_latency, ...
                                               'use_rpm', 'off'), ...
                                        {xlsub2_Counter_out1, xlsub2_In1, xlsub2_Constant2_out1}, ...
                                        {xlsub2_Out1});
    case 'delay_slr'
		defaults = {'DelayLen',6};
		DelayLen = get_var('DelayLen', 'defaults', defaults, varargin{:});
        %% inports
        xlsub2_In1 = xInport('In1');

        %% outports
        xlsub2_Out1 = xOutport('Out1');

        %% diagram

        % block: delay_7/delay_slr/delay_slr
        xlsub2_delay_slr = xBlock(struct('source', 'Delay', 'name', 'delay_slr'), ...
                                  struct('latency', DelayLen), ...
                                  {xlsub2_In1}, ...
                                  {xlsub2_Out1});
    case 'sync_delay'
		defaults = {'DelayLen',6};
		DelayLen = get_var('DelayLen', 'defaults', defaults, varargin{:});
        % Mask Initialization code
        BitWidth = max(2, ceil(log2(DelayLen+1)));
        UseCounter = 1;
        if DelayLen == 0,
            UseCounter = 0;
        end

        %% inports
        xlsub2_In = xInport('In');

        %% outports
        xlsub2_Out = xOutport('Out');

        %% diagram

        % block: delay_7/sync_delay/Constant
        xlsub2_Constant_out1 = xSignal;
        xlsub2_Constant = xBlock(struct('source', 'Constant', 'name', 'Constant'), ...
                                 struct('arith_type', 'Unsigned', ...
                                        'n_bits', BitWidth, ...
                                        'bin_pt', 0, ...
                                        'explicit_period', 'on'), ...
                                 {}, ...
                                 {xlsub2_Constant_out1});

        % block: delay_7/sync_delay/Constant1
        xlsub2_Constant1_out1 = xSignal;
        xlsub2_Constant1 = xBlock(struct('source', 'Constant', 'name', 'Constant1'), ...
                                  struct('arith_type', 'Unsigned', ...
                                         'const', 0, ...
                                         'n_bits', BitWidth, ...
                                         'bin_pt', 0, ...
                                         'explicit_period', 'on'), ...
                                  {}, ...
                                  {xlsub2_Constant1_out1});

        % block: delay_7/sync_delay/Constant2
        xlsub2_Constant2_out1 = xSignal;
        xlsub2_Constant2 = xBlock(struct('source', 'Constant', 'name', 'Constant2'), ...
                                  struct('arith_type', 'Unsigned', ...
                                         'const', DelayLen, ...
                                         'n_bits', BitWidth, ...
                                         'bin_pt', 0, ...
                                         'explicit_period', 'on'), ...
                                  {}, ...
                                  {xlsub2_Constant2_out1});

        % block: delay_7/sync_delay/Constant3
        xlsub2_Constant3_out1 = xSignal;
        xlsub2_Constant3 = xBlock(struct('source', 'Constant', 'name', 'Constant3'), ...
                                  struct('arith_type', 'Unsigned', ...
                                         'const', UseCounter, ...
                                         'n_bits', 1, ...
                                         'bin_pt', 0, ...
                                         'explicit_period', 'on'), ...
                                  {}, ...
                                  {xlsub2_Constant3_out1});

        % block: delay_7/sync_delay/Counter
        xlsub2_Logical_out1 = xSignal;
        xlsub2_Counter_out1 = xSignal;
        xlsub2_Counter = xBlock(struct('source', 'Counter', 'name', 'Counter'), ...
                                struct('operation', 'Down', ...
                                       'n_bits', BitWidth, ...
                                       'load_pin', 'on', ...
                                       'en', 'on', ...
                                       'use_rpm', 'on'), ...
                                {xlsub2_In, xlsub2_Constant2_out1, xlsub2_Logical_out1}, ...
                                {xlsub2_Counter_out1});

        % block: delay_7/sync_delay/Logical
        xlsub2_Relational1_out1 = xSignal;
        xlsub2_Logical = xBlock(struct('source', 'Logical', 'name', 'Logical'), ...
                                struct('logical_function', 'OR', ...
                                       'n_bits', 8, ...
                                       'bin_pt', 2), ...
                                {xlsub2_In, xlsub2_Relational1_out1}, ...
                                {xlsub2_Logical_out1});

        % block: delay_7/sync_delay/Mux
        xlsub2_Relational_out1 = xSignal;
        xlsub2_Mux = xBlock(struct('source', 'Mux', 'name', 'Mux'), ...
                            struct('arith_type', 'Signed  (2''s comp)', ...
                                   'n_bits', 8, ...
                                   'bin_pt', 2), ...
                            {xlsub2_Constant3_out1, xlsub2_In, xlsub2_Relational_out1}, ...
                            {xlsub2_Out});

        % block: delay_7/sync_delay/Relational
        xlsub2_Relational = xBlock(struct('source', 'Relational', 'name', 'Relational'), ...
                                   struct('latency', 0), ...
                                   {xlsub2_Constant_out1, xlsub2_Counter_out1}, ...
                                   {xlsub2_Relational_out1});

        % block: delay_7/sync_delay/Relational1
        xlsub2_Relational1 = xBlock(struct('source', 'Relational', 'name', 'Relational1'), ...
                                    struct('mode', 'a!=b', ...
                                           'latency', 0), ...
                                    {xlsub2_Counter_out1, xlsub2_Constant1_out1}, ...
                                    {xlsub2_Relational1_out1});

        % block: delay_7/sync_delay/warn period Logical0
        xlsub2_warn_period_Logical0 = xBlock(struct('source', 'xbsReplacements_r4/Warning', 'name', 'warn period Logical0'), ...
                                             struct('period', 1), ...
                                             {}, ...
                                             {});

        % block: delay_7/sync_delay/warn period Relational10
        xlsub2_warn_period_Relational10 = xBlock(struct('source', 'xbsReplacements_r4/Warning', 'name', 'warn period Relational10'), ...
                                                 struct('period', 1), ...
                                                 {}, ...
                                                 {});


    case 'sync_delay_en'
		defaults = {'DelayLen',6};
		DelayLen = get_var('DelayLen', 'defaults', defaults, varargin{:});
        % Mask Initialization code
        BitWidth = max(2, ceil(log2(DelayLen+1)));
        UseCounter = 1;
        if DelayLen == 0,
            UseCounter = 0;
        end

        %% inports
        xlsub2_In = xInport('In');
        xlsub2_en = xInport('en');

        %% outports
        xlsub2_Out = xOutport('Out');

        %% diagram

        % block: delay_7/sync_delay_en/Constant
        xlsub2_Constant_out1 = xSignal;
        xlsub2_Constant = xBlock(struct('source', 'Constant', 'name', 'Constant'), ...
                                 struct('arith_type', 'Unsigned', ...
                                        'n_bits', BitWidth, ...
                                        'bin_pt', 0, ...
                                        'explicit_period', 'on'), ...
                                 {}, ...
                                 {xlsub2_Constant_out1});

        % block: delay_7/sync_delay_en/Constant1
        xlsub2_Constant1_out1 = xSignal;
        xlsub2_Constant1 = xBlock(struct('source', 'Constant', 'name', 'Constant1'), ...
                                  struct('arith_type', 'Unsigned', ...
                                         'const', 0, ...
                                         'n_bits', BitWidth, ...
                                         'bin_pt', 0, ...
                                         'explicit_period', 'on'), ...
                                  {}, ...
                                  {xlsub2_Constant1_out1});

        % block: delay_7/sync_delay_en/Constant2
        xlsub2_Constant2_out1 = xSignal;
        xlsub2_Constant2 = xBlock(struct('source', 'Constant', 'name', 'Constant2'), ...
                                  struct('arith_type', 'Unsigned', ...
                                         'const', DelayLen, ...
                                         'n_bits', BitWidth, ...
                                         'bin_pt', 0, ...
                                         'explicit_period', 'on'), ...
                                  {}, ...
                                  {xlsub2_Constant2_out1});

        % block: delay_7/sync_delay_en/Constant3
        xlsub2_Constant3_out1 = xSignal;
        xlsub2_Constant3 = xBlock(struct('source', 'Constant', 'name', 'Constant3'), ...
                                  struct('arith_type', 'Unsigned', ...
                                         'const', UseCounter, ...
                                         'n_bits', 1, ...
                                         'bin_pt', 0, ...
                                         'explicit_period', 'on'), ...
                                  {}, ...
                                  {xlsub2_Constant3_out1});

        % block: delay_7/sync_delay_en/Counter
        xlsub2_Logical1_out1 = xSignal;
        xlsub2_Counter_out1 = xSignal;
        xlsub2_Counter = xBlock(struct('source', 'Counter', 'name', 'Counter'), ...
                                struct('operation', 'Down', ...
                                       'n_bits', BitWidth, ...
                                       'load_pin', 'on', ...
                                       'en', 'on', ...
                                       'use_rpm', 'on'), ...
                                {xlsub2_In, xlsub2_Constant2_out1, xlsub2_Logical1_out1}, ...
                                {xlsub2_Counter_out1});

        % block: delay_7/sync_delay_en/Logical
        xlsub2_Relational1_out1 = xSignal;
        xlsub2_Logical_out1 = xSignal;
        xlsub2_Logical = xBlock(struct('source', 'Logical', 'name', 'Logical'), ...
                                struct('logical_function', 'OR', ...
                                       'n_bits', 8, ...
                                       'bin_pt', 2), ...
                                {xlsub2_In, xlsub2_Relational1_out1}, ...
                                {xlsub2_Logical_out1});

        % block: delay_7/sync_delay_en/Logical1
        xlsub2_Logical1 = xBlock(struct('source', 'Logical', 'name', 'Logical1'), ...
                                 struct('n_bits', 8, ...
                                        'bin_pt', 2), ...
                                 {xlsub2_Logical_out1, xlsub2_en}, ...
                                 {xlsub2_Logical1_out1});

        % block: delay_7/sync_delay_en/Mux
        xlsub2_Relational_out1 = xSignal;
        xlsub2_Mux = xBlock(struct('source', 'Mux', 'name', 'Mux'), ...
                            struct('arith_type', 'Signed  (2''s comp)', ...
                                   'n_bits', 8, ...
                                   'bin_pt', 2), ...
                            {xlsub2_Constant3_out1, xlsub2_In, xlsub2_Relational_out1}, ...
                            {xlsub2_Out});

        % block: delay_7/sync_delay_en/Relational
        xlsub2_Relational = xBlock(struct('source', 'Relational', 'name', 'Relational'), ...
                                   struct('latency', 0), ...
                                   {xlsub2_Constant_out1, xlsub2_Counter_out1}, ...
                                   {xlsub2_Relational_out1});

        % block: delay_7/sync_delay_en/Relational1
        xlsub2_Relational1 = xBlock(struct('source', 'Relational', 'name', 'Relational1'), ...
                                    struct('mode', 'a!=b', ...
                                           'latency', 0), ...
                                    {xlsub2_Counter_out1, xlsub2_Constant1_out1}, ...
                                    {xlsub2_Relational1_out1});

        % block: delay_7/sync_delay_en/warn period Logical0
        xlsub2_warn_period_Logical0 = xBlock(struct('source', 'xbsReplacements_r4/Warning', 'name', 'warn period Logical0'), ...
                                             struct('period', 1), ...
                                             {}, ...
                                             {});

        % block: delay_7/sync_delay_en/warn period Logical10
        xlsub2_warn_period_Logical10 = xBlock(struct('source', 'xbsReplacements_r4/Warning', 'name', 'warn period Logical10'), ...
                                              struct('period', 1), ...
                                              {}, ...
                                              {});

        % block: delay_7/sync_delay_en/warn period Relational10
        xlsub2_warn_period_Relational10 = xBlock(struct('source', 'xbsReplacements_r4/Warning', 'name', 'warn period Relational10'), ...
                                                 struct('period', 1), ...
                                                 {}, ...
                                                 {});




    
    
    case 'sync_delay_prog'
		defaults = {'MaxDelay',7};
		MaxDelay = get_var('MaxDelay', 'defaults', defaults, varargin{:});
        %% inports
        xlsub2_sync = xInport('sync');
        xlsub2_delay = xInport('delay');

        %% outports
        xlsub2_sync_out = xOutport('sync_out');

        %% diagram

        % block: delay_7/sync_delay_prog/Constant
        xlsub2_Constant_out1 = xSignal;
        xlsub2_Constant = xBlock(struct('source', 'Constant', 'name', 'Constant'), ...
                                 struct('arith_type', 'Unsigned', ...
                                        'n_bits', MaxDelay, ...
                                        'bin_pt', 0, ...
                                        'explicit_period', 'on'), ...
                                 {}, ...
                                 {xlsub2_Constant_out1});

        % block: delay_7/sync_delay_prog/Constant1
        xlsub2_Constant1_out1 = xSignal;
        xlsub2_Constant1 = xBlock(struct('source', 'Constant', 'name', 'Constant1'), ...
                                  struct('arith_type', 'Unsigned', ...
                                         'const', 0, ...
                                         'n_bits', MaxDelay, ...
                                         'bin_pt', 0, ...
                                         'explicit_period', 'on'), ...
                                  {}, ...
                                  {xlsub2_Constant1_out1});

        % block: delay_7/sync_delay_prog/Counter
        xlsub2_Logical_out1 = xSignal;
        xlsub2_Counter_out1 = xSignal;
        xlsub2_Counter = xBlock(struct('source', 'Counter', 'name', 'Counter'), ...
                                struct('operation', 'Down', ...
                                       'n_bits', MaxDelay, ...
                                       'load_pin', 'on', ...
                                       'en', 'on', ...
                                       'use_rpm', 'on'), ...
                                {xlsub2_sync, xlsub2_delay, xlsub2_Logical_out1}, ...
                                {xlsub2_Counter_out1});

        % block: delay_7/sync_delay_prog/Logical
        xlsub2_Relational1_out1 = xSignal;
        xlsub2_Logical = xBlock(struct('source', 'Logical', 'name', 'Logical'), ...
                                struct('logical_function', 'OR', ...
                                       'n_bits', 8, ...
                                       'bin_pt', 2), ...
                                {xlsub2_sync, xlsub2_Relational1_out1}, ...
                                {xlsub2_Logical_out1});

        % block: delay_7/sync_delay_prog/Relational
        xlsub2_Relational = xBlock(struct('source', 'Relational', 'name', 'Relational'), ...
                                   struct('latency', 0), ...
                                   {xlsub2_Constant_out1, xlsub2_Counter_out1}, ...
                                   {xlsub2_sync_out});

        % block: delay_7/sync_delay_prog/Relational1
        xlsub2_Relational1 = xBlock(struct('source', 'Relational', 'name', 'Relational1'), ...
                                    struct('mode', 'a!=b', ...
                                           'latency', 0), ...
                                    {xlsub2_Counter_out1, xlsub2_Constant1_out1}, ...
                                    {xlsub2_Relational1_out1});




    
    case 'window_delay'
		defaults = {'delay',2};
		delay = get_var('delay', 'defaults', defaults, varargin{:});
        %% inports
        xlsub2_in = xInport('in');

        %% outports
        xlsub2_out = xOutport('out');

        %% diagram

        % block: delay_7/window_delay/Gateway Out2
        xlsub2_sync_delay1_out1 = xSignal;
        xlsub2_Gateway_Out2_out1 = xSignal;
        xlsub2_Gateway_Out2 = xBlock(struct('source', 'Gateway Out', 'name', 'Gateway Out2'), ...
                                     [], ...
                                     {xlsub2_sync_delay1_out1}, ...
                                     {xlsub2_Gateway_Out2_out1});

        % block: delay_7/window_delay/Gateway Out3
        xlsub2_Register_out1 = xSignal;
        xlsub2_Gateway_Out3_out1 = xSignal;
        xlsub2_Gateway_Out3 = xBlock(struct('source', 'Gateway Out', 'name', 'Gateway Out3'), ...
                                     [], ...
                                     {xlsub2_Register_out1}, ...
                                     {xlsub2_Gateway_Out3_out1});

        % block: delay_7/window_delay/Gateway Out55
        xlsub2_Gateway_Out55_out1 = xSignal;
        xlsub2_Gateway_Out55 = xBlock(struct('source', 'Gateway Out', 'name', 'Gateway Out55'), ...
                                      [], ...
                                      {xlsub2_in}, ...
                                      {xlsub2_Gateway_Out55_out1});

        % block: delay_7/window_delay/Gateway Out56
        xlsub2_sync_delay_out1 = xSignal;
        xlsub2_Gateway_Out56_out1 = xSignal;
        xlsub2_Gateway_Out56 = xBlock(struct('source', 'Gateway Out', 'name', 'Gateway Out56'), ...
                                      [], ...
                                      {xlsub2_sync_delay_out1}, ...
                                      {xlsub2_Gateway_Out56_out1});

        % block: delay_7/window_delay/Register
        xlsub2_Register = xBlock(struct('source', 'Register', 'name', 'Register'), ...
                                 struct('rst', 'on', ...
                                        'en', 'on'), ...
                                 {xlsub2_sync_delay_out1, xlsub2_sync_delay1_out1, xlsub2_sync_delay_out1}, ...
                                 {xlsub2_Register_out1});


        % block: delay_7/window_delay/negedge
        xlsub2_negedge_out1 = xSignal;
        xlsub2_negedge = xBlock(struct('source', 'casper_library_misc/negedge', 'name', 'negedge'), ...
                                [], ...
                                {xlsub2_in}, ...
                                {xlsub2_negedge_out1});

        % block: delay_7/window_delay/posedge3
        xlsub2_posedge3_out1 = xSignal;
        xlsub2_posedge3 = xBlock(struct('source', 'casper_library_misc/posedge', 'name', 'posedge3'), ...
                                 [], ...
                                 {xlsub2_in}, ...
                                 {xlsub2_posedge3_out1});

        % block: delay_7/window_delay/sync_delay
        xlsub2_sync_delay = xBlock(struct('source', 'casper_library_delays/sync_delay', 'name', 'sync_delay'), ...
                                   struct('DelayLen', delay-1), ...
                                   {xlsub2_posedge3_out1}, ...
                                   {xlsub2_sync_delay_out1});

        % block: delay_7/window_delay/sync_delay1
        xlsub2_sync_delay1 = xBlock(struct('source', 'casper_library_delays/sync_delay', 'name', 'sync_delay1'), ...
                                    struct('DelayLen', delay-1), ...
                                    {xlsub2_negedge_out1}, ...
                                    {xlsub2_sync_delay1_out1});

        % extra outport assignment
        xlsub2_out.assign(xlsub2_Register_out1);


    
    case 'pipeline'
		defaults = {'latency',2};
		latency = get_var('latency', 'defaults', defaults, varargin{:});
        %disp(varargin(1));
        %% inports
        xlsub2_d = xInport('d');

        %% outports
        xlsub2_q = xOutport('q');

        %% diagram

        if (latency==0)
            xlsub2_q.bind(xlsub2_d);
        else
            prev=xlsub2_d;
            next=xSignal;
            for i=1:latency,
                xlsub2_Register.(['R',num2str(i-1)]) = xBlock(struct('source', 'Register', 'name', ['Register',num2str(i-1)]), ...
                                                     [], ...
                                                     {prev}, ...
                                                     {next});
                prev=xSignal;
                prev.bind(next);
                next=xSignal;
            end
            xlsub2_q.bind(prev);
        end


end

end