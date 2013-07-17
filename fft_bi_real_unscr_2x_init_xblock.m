%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %      
%   Copyright (C) 2011  Hong Chen, William Mallard                            %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fft_bi_real_unscr_2x_init_xblock(blk, varargin)

defaults = { ...
    'FFTSize', 2, ...
    'n_bits', 18, ...
    'add_latency', 1, ...
    'conv_latency', 1, ...
    'bram_latency', 2, ...
    'bram_map', 'off', ...
    'dsp48_adders', 'off', ...
};

% Retrieve values from mask fields.
FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
n_bits = get_var('n_bits', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
bram_map = get_var('bram_map', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

% Generate reorder maps.
map_even = bit_reverse(0:2^(FFTSize-1)-1, FFTSize-1);
map_odd = bit_reverse(2^(FFTSize-1)-1:-1:0, FFTSize-1);


%% inports
xlsub2_sync = xInport('sync');
xlsub2_even = xInport('even');
xlsub2_odd = xInport('odd');

%% outports
xlsub2_sync_out = xOutport('sync_out');
xlsub2_pol12_out = xOutport('pol12_out');
xlsub2_pol34_out = xOutport('pol34_out');

%% diagram

% block: untitled/bi_real_unscr_2x/Constant
xlsub2_Constant_out1 = xSignal;
xlsub2_Constant = xBlock(struct('source', 'Constant', 'name', 'Constant'), ...
                         struct('ShowName', 'off', ...
                                'arith_type', 'Unsigned', ...
                                'const', 0, ...
                                'n_bits', FFTSize-1, ...
                                'bin_pt', 0, ...
                                'explicit_period', 'on', ...
                                'period', 1), ...
                         {}, ...
                         {xlsub2_Constant_out1});

% block: untitled/bi_real_unscr_2x/Counter
xlsub2_reorder_even_out1 = xSignal;
xlsub2_Counter_out1 = xSignal;
xlsub2_Counter = xBlock(struct('source', 'Counter', 'name', 'Counter'), ...
                        struct('ShowName', 'off', ...
                                'cnt_type', 'Free Running', ...
                                'cnt_to', 'Inf', ...
                                'operation', 'Up', ...
                                'start_count', 0, ...
                                'cnt_by_val', 1, ...
                                'arith_type', 'Unsigned', ...
                                'n_bits', FFTSize-1, ...
                                'bin_pt', 0, ...
                                'load_pin', 'off', ...
                                'rst', 'on', ...
                                'en', 'off', ...
                                'explicit_period', 'on', ...
                                'period', 1, ...
                                'use_behavioral_HDL', 'off', ...
                                'implementation', 'Fabric'), ...
                        {xlsub2_reorder_even_out1}, ...
                        {xlsub2_Counter_out1});

% block: untitled/bi_real_unscr_2x/Delay
xlsub2_reorder_odd_out3 = xSignal;
xlsub2_Delay_out1 = xSignal;
xlsub2_Delay = xBlock(struct('source', 'Delay', 'name', 'Delay'), ...
                      {'ShowName', 'off', ...
                         'latency', 1, ...
                        'reg_retiming', 'off'}, ...
                      {xlsub2_reorder_odd_out3}, ...
                      {xlsub2_Delay_out1});

% block: untitled/bi_real_unscr_2x/Mux
xlsub2_Relational_out1 = xSignal;
xlsub2_reorder_even_out3 = xSignal;
xlsub2_Mux_out1 = xSignal;
xlsub2_Mux = xBlock(struct('source', 'Mux', 'name', 'Mux'), ...
                    struct('ShowName', 'off', ...
                                'inputs', 2, ...
                                'en', 'off', ...
                                'latency', 0, ...
                                'Precision', 'Full', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                               'n_bits', 8, ...
                               'bin_pt', 2), ...
                    {xlsub2_Relational_out1, xlsub2_Delay_out1, xlsub2_reorder_even_out3}, ...
                    {xlsub2_Mux_out1});

% block: untitled/bi_real_unscr_2x/Relational
xlsub2_Relational = xBlock(struct('source', 'Relational', 'name', 'Relational'), ...
                           struct('ShowName', 'off', ...
                                        'mode', 'a=b', ...
                                        'en', 'off', ...
                                        'latency', 0), ...
                           {xlsub2_Counter_out1, xlsub2_Constant_out1}, ...
                           {xlsub2_Relational_out1});

% block: untitled/bi_real_unscr_2x/en_even
xlsub2_en_even_out1 = xSignal;
xlsub2_en_even = xBlock(struct('source', 'Constant', 'name', 'en_even'), ...
                        struct('ShowName', 'off', ...
                               'arith_type', 'Boolean', ...
                               'const',1, ...
                               'period', 1, ...
                               'n_bits', 1, ...
                               'bin_pt', 0, ...
                               'explicit_period', 'on'), ...
                        {}, ...
                        {xlsub2_en_even_out1});

% block: untitled/bi_real_unscr_2x/en_odd
xlsub2_en_odd_out1 = xSignal;
xlsub2_en_odd = xBlock(struct('source', 'Constant', 'name', 'en_odd'), ...
                       struct('ShowName', 'off', ...
                              'arith_type', 'Boolean', ...
                              'const',1,...
                              'period', 1, ...
                              'n_bits', 1, ...
                              'bin_pt', 0, ...
                              'explicit_period', 'on'), ...
                       {}, ...
                       {xlsub2_en_odd_out1});

% block: untitled/bi_real_unscr_2x/sync_delay
xlsub2_sync_delay = xBlock(struct('source', 'Delay', 'name', 'sync_delay'), ...
                           struct('latency', add_latency + conv_latency, ...
                                    'ShowName', 'on', ...
                                    'reg_retiming', 'off'), ...
                           {xlsub2_reorder_even_out1}, ...
                           {xlsub2_sync_out});

if strcmp(dsp48_adders,'off')
    hilbert_name = 'hilbert';
    % block: untitled/bi_real_unscr_2x/hilbert
    xlsub2_hilbert_sub = xBlock(struct('source', str2func('hilbert_init_xblock'), 'name', hilbert_name), ...
                            {[blk, '/',hilbert_name],n_bits, add_latency, conv_latency}, ...
                            {xlsub2_reorder_even_out3, xlsub2_Mux_out1}, ...
                            {xlsub2_pol12_out, xlsub2_pol34_out});
else
    hilbert_name ='hilbert_dsp48e';
    xlsub2_hilbert_sub = xBlock(struct('source', str2func('hilbert_dsp48e_init_xblock'), 'name', hilbert_name), ...
                            {[blk, '/',hilbert_name],n_bits,  conv_latency}, ...
                            {xlsub2_reorder_even_out3, xlsub2_Mux_out1}, ...
                            {xlsub2_pol12_out, xlsub2_pol34_out});
end

% block: untitled/bi_real_unscr_2x/reorder_even
xlsub2_reorder_even_sub = xBlock(struct('source', str2func('reorder_init_xblock'), 'name', 'reorder_even'), ...
                             {[blk, '/reorder_even'], ...
                                'map', mat2str(map_even), ...
                                'n_inputs', 1, ...
                                'bram_latency', bram_latency, ...
                                'map_latency', 1, ...
                                'double_buffer',0, ...
                                'bram_map', bram_map}, ...
                             {xlsub2_sync, xlsub2_en_even_out1, xlsub2_even}, ...
                             {xlsub2_reorder_even_out1, [], xlsub2_reorder_even_out3});

% block: untitled/bi_real_unscr_2x/reorder_odd
xlsub2_reorder_odd_sub = xBlock(struct('source', str2func('reorder_init_xblock'), 'name', 'reorder_odd'), ...
                            {[blk, '/reorder_odd'], ...
                                'map', mat2str(map_odd), ...
                                'n_inputs', 1, ...
                                'bram_latency', bram_latency, ...
                                'map_latency', 1, ...
                                'double_buffer',0, ...
                                'bram_map', bram_map}, ...
                            {xlsub2_sync, xlsub2_en_odd_out1, xlsub2_odd}, ...
                            {[], [], xlsub2_reorder_odd_out3});



if ~isempty(blk) && ~strcmp(blk(1),'/')
    clean_blocks(blk);
end
end