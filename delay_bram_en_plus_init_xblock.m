%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %      
%   Copyright (C) 2011 Suraj Gowda    Hong Chen                               %
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

function delay_bram_en_plus_init_xblock(DelayLen, bram_latency)

% Mask Initialization code
BitWidth = max(ceil(log2(DelayLen)), 2);

%% inports
xlsub2_din = xInport('din');
xlsub2_en = xInport('en');

%% outports
xlsub2_dout = xOutport('dout');
xlsub2_valid = xOutport('valid');

%% diagram

% block: more_delays/delay_bram_en_plus/Counter
xlsub2_Counter_out1 = xSignal;
xlsub2_Counter = xBlock(struct('source', 'Counter', 'name', 'Counter'), ...
                        struct('cnt_type', 'Count Limited', ...
                               'cnt_to', DelayLen - 1, ...
                               'n_bits', BitWidth, ...
                               'en', 'on', ...
                               'explicit_period', 'off', ...
                               'use_rpm', 'off'), ...
                        {xlsub2_en}, ...
                        {xlsub2_Counter_out1});

% block: more_delays/delay_bram_en_plus/Delay
xlsub2_Delay = xBlock(struct('source', 'Delay', 'name', 'Delay'), ...
                      struct('latency', bram_latency), ...
                      {xlsub2_en}, ...
                      {xlsub2_valid});

% block: more_delays/delay_bram_en_plus/Single Port RAM
xlsub2_Single_Port_RAM = xBlock(struct('source', 'Single Port RAM', 'name', 'Single Port RAM'), ...
                                struct('depth', 2^BitWidth, ...
                                       'initVector', 0, ...
                                       'write_mode', 'Read Before Write', ...
                                       'latency', bram_latency, ...
                                       'use_rpm', 'off'), ...
                                {xlsub2_Counter_out1, xlsub2_din, xlsub2_en}, ...
                                {xlsub2_dout});



end

