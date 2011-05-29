function fft_unscrambler_init_xblock_old(varargin)

% Set default vararg values.
defaults = { ...
    'FFTSize', 5, ...
    'n_inputs', 2, ...
    'bram_latency', 2, ...
};

% Retrieve values from mask fields.
FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});

% Validate input fields.

if (n_inputs >= FFTSize - 2),
    errordlg('FFT Unscrambler: 2^n_inputs must be < 2^(FFT size-2).');
end

%% inports
sync = xInport('sync');
In1 = xInport('In1');
In2 = xInport('In2');

%% outports
sync_out = xOutport('sync_out');
Out1 = xOutport('Out1');
Out2 = xOutport('Out2');




for i=1:2^n_inputs,
    reuse_block(blk, ['In',num2str(i)], 'built-in/inport', 'Position', [30 20*i+60 60 20*i+74], 'Port', num2str(i+1));
    reuse_block(blk, ['Out',num2str(i)], 'built-in/outport', 'Position', [500 55*i+40 530 55*i+54], 'Port', num2str(i+1));
end

%% diagram
part_mat = [0:2^(FFTSize-2*n_inputs)-1]*2^(n_inputs);
map_mat = [];
for i=0:2^n_inputs-1,
    map_mat = [map_mat, part_mat+i];
end
map_str = tostring(map_mat);


% Add static blocks
reuse_block(blk, 'square_transposer', str2func('square_transposer_init_xblock'), ...
    'Position', [85 30 170 2^n_inputs*20+80], ...
    'n_inputs', num2str(n_inputs));
reuse_block(blk, 'reorder', str2func('reorder_init_xblock'), ...
    'Position', [265 37 360 93], ...
    'map', map_str, ...
    'n_inputs', num2str(2^n_inputs), ...
    'bram_latency', num2str(bram_latency), ...
    'map_latency', num2str(1), ...
    'double_buffer', '0');
reuse_block(blk, 'const', 'xbsIndex_r4/Constant', ...
    'Position', [225 57 250 73], ...
    'arith_type', 'Boolean', ...
    'explicit_period', 'on');

% Add static lines
add_line(blk, 'sync/1', 'square_transposer/1');
add_line(blk, 'square_transposer/1', 'reorder/1');
add_line(blk, 'reorder/1', 'sync_out/1');
add_line(blk, 'const/1', 'reorder/2');

% Add dynamic lines
for i=1:2^n_inputs,
    in_name = ['In',num2str(i)];
    out_name = ['Out',num2str(i)];
    add_line(blk, [in_name,'/1'], ['square_transposer/',num2str(i+1)]);
    add_line(blk, ['square_transposer/',num2str(i+1)], ['reorder/',num2str(i+2)]);
    add_line(blk, ['reorder/',num2str(i+2)], [out_name,'/1']);
end

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d, n_inputs=%d', FFTSize, n_inputs);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});



end

