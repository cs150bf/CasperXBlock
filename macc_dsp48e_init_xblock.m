%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %      
%   Copyright (C) 2011 Suraj Gowda                                            %
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

%% TODO

function macc_dsp48e_init_xblock(blk, n_bits_a, bin_pt_a, n_bits_b, bin_pt_b, full_precision, n_bits_c, bin_pt_c, quantization, overflow, cast_latency, n_taps)
% no depends

%% inports



%% outports


%% diagram


% block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/Convert
for k = 1:ceil(n_taps/2)
    first_suffix = ['_', num2str(2*(k-1))];
    second_suffix = ['_', num2str(2*k-1)];    
    xlsub3_a = xInport(['a', first_suffix]);
    xlsub3_b = xInport(['b', first_suffix]);    


    tap_dout_name = ['a', first_suffix, '*', 'b', first_suffix];
    if 2*k <= n_taps,
        tap_dout_name = [tap_dout_name, '+', 'a', second_suffix, '*', 'b', second_suffix];
    end
    tap_dout = xOutport(tap_dout_name);
    
    xlsub3_reinterp_a_im_out1 = xSignal;
    xlsub3_Convert_out1 = xSignal;
    xlsub3_reinterp_a_re_out1 = xSignal;
    xlsub3_Convert2_out1 = xSignal;
    xlsub3_reinterp_b_im_out1 = xSignal;
    xlsub3_Convert3_out1 = xSignal;
    xlsub3_reinterp_b_re_out1 = xSignal;
    xlsub3_Convert4_out1 = xSignal;
    xlsub3_opmode2_out1 = xSignal;
    xlsub3_alumode2_out1 = xSignal;
    xlsub3_carryin2_out1 = xSignal;
    xlsub3_carryinsel2_out1 = xSignal;
    xlsub3_DSP48E_0_out2 = xSignal;
    xlsub3_opmode3_out1 = xSignal;
    xlsub3_alumode3_out1 = xSignal;
    xlsub3_carryin3_out1 = xSignal;
    xlsub3_carryinsel3_out1 = xSignal;
    xlsub3_DSP48E_1_out1 = xSignal;
    xlsub3_reinterp_c_re_out1 = xSignal;
    xlsub3_realign_b_im_out1 = xSignal;
    xlsub3_realign_a_im_out1 = xSignal;
    xlsub3_realign_a_re_out1 = xSignal;
    xlsub3_realign_b_re_out1 = xSignal;
    

    
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/Convert2
    xlsub3_Convert2 = xBlock(struct('source', 'Convert', 'name', ['conv_a', first_suffix]), ...
        struct('n_bits', 30, ...
        'bin_pt', 0, ...
        'pipeline', 'on'), ...
        {xlsub3_reinterp_a_re_out1}, ...
        {xlsub3_Convert2_out1});
    
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/Convert4
    xlsub3_Convert4 = xBlock(struct('source', 'Convert', 'name', ['conv_b', first_suffix]), ...
        struct('n_bits', 18, ...
        'bin_pt', 0, ...
        'pipeline', 'on'), ...
        {xlsub3_reinterp_b_re_out1}, ...
        {xlsub3_Convert4_out1});
    
    

    
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/alumode2
    xlsub3_alumode2 = xBlock(struct('source', 'Constant', 'name', ['alumode0', first_suffix]), ...
        struct('arith_type', 'Unsigned', ...
        'const', 0, ...
        'n_bits', 4, ...
        'bin_pt', 0), ...
        {}, ...
        {xlsub3_alumode2_out1});
    
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/carryin2
    xlsub3_carryin2 = xBlock(struct('source', 'Constant', 'name', ['carryin2', first_suffix]), ...
        struct('arith_type', 'Unsigned', ...
        'const', 0, ...
        'n_bits', 1, ...
        'bin_pt', 0), ...
        {}, ...
        {xlsub3_carryin2_out1});
    
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/carryinsel2
    xlsub3_carryinsel2 = xBlock(struct('source', 'Constant', 'name', ['carryinsel2', first_suffix]), ...
        struct('arith_type', 'Unsigned', ...
        'const', 0, ...
        'n_bits', 3, ...
        'bin_pt', 0), ...
        {}, ...
        {xlsub3_carryinsel2_out1});
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/cast_c_re
    xlsub3_cast_c_re = xBlock(struct('source', 'Convert', 'name', ['cast_c_re', first_suffix]), ...
        struct('n_bits', 37, ...
        'bin_pt', 34, ...
        'pipeline', 'on'), ...
        {xlsub3_reinterp_c_re_out1}, ...
        {tap_dout});
    
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/opmode2
    xlsub3_opmode2 = xBlock(struct('source', 'Constant', 'name', ['opmode2', first_suffix]), ...
        struct('arith_type', 'Unsigned', ...
        'const', 5, ...
        'n_bits', 7, ...
        'bin_pt', 0), ...
        {}, ...
        {xlsub3_opmode2_out1});
    
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/realign_a_re
    
    xlsub3_realign_a_re = xBlock(struct('source', 'Convert', 'name', ['realign_a_re', first_suffix]), ...
        struct('n_bits', 18, ...
        'bin_pt', 17, ...
        'pipeline', 'on'), ...
        {xlsub3_a}, ...
        {xlsub3_realign_a_re_out1});
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/realign_b_re
    xlsub3_realign_b_re = xBlock(struct('source', 'Convert', 'name', ['realign_b_re', first_suffix]), ...
        struct('n_bits', 18, ...
        'bin_pt', 17, ...
        'pipeline', 'on'), ...
        {xlsub3_b}, ...
        {xlsub3_realign_b_re_out1});
    
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/reinterp_a_re
    xlsub3_reinterp_a_re = xBlock(struct('source', 'Reinterpret', 'name', ['reinterp_a_re', first_suffix]), ...
        struct('force_arith_type', 'on', ...
        'arith_type', 'Signed  (2''s comp)', ...
        'force_bin_pt', 'on'), ...
        {xlsub3_realign_a_re_out1}, ...
        {xlsub3_reinterp_a_re_out1});
    % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/reinterp_b_re
    xlsub3_reinterp_b_re = xBlock(struct('source', 'Reinterpret', 'name', ['reinterp_b_re', first_suffix]), ...
        struct('force_arith_type', 'on', ...
        'arith_type', 'Signed  (2''s comp)', ...
        'force_bin_pt', 'on'), ...
        {xlsub3_realign_b_re_out1}, ...
        {xlsub3_reinterp_b_re_out1});

                                  
    if 2*k <= n_taps, 
        xlsub3_c = xInport(['a', second_suffix]);
        xlsub3_d = xInport(['b', second_suffix]);           
        
        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/DSP48E_0
        xlsub3_DSP48E_0 = xBlock(struct('source', 'DSP48E', 'name', ['DSP48E', first_suffix]), ...
            struct('use_pcout', 'on'), ...
            {xlsub3_Convert2_out1, xlsub3_Convert4_out1, xlsub3_opmode2_out1, xlsub3_alumode2_out1, xlsub3_carryin2_out1, xlsub3_carryinsel2_out1}, ...
            {[], xlsub3_DSP48E_0_out2});        
        
        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/reinterp_c_re
        xlsub3_reinterp_c_re = xBlock(struct('source', 'Reinterpret', 'name', ['reinterp_c_re', first_suffix]), ...
            struct('force_arith_type', 'on', ...
            'arith_type', 'Signed  (2''s comp)', ...
            'force_bin_pt', 'on', ...
            'bin_pt', 34), ...
            {xlsub3_DSP48E_1_out1}, ...
            {xlsub3_reinterp_c_re_out1});        
        
        xlsub3_Convert = xBlock(struct('source', 'Convert', 'name', ['Convert', second_suffix]), ...
                                struct('n_bits', 30, ...
                                       'bin_pt', 0, ...
                                       'pipeline', 'on'), ...
                                {xlsub3_reinterp_a_im_out1}, ...
                                {xlsub3_Convert_out1});
                            
        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/Convert3
        xlsub3_Convert3 = xBlock(struct('source', 'Convert', 'name', ['Convert3', second_suffix]), ...
                                 struct('n_bits', 18, ...
                                        'bin_pt', 0, ...
                                        'pipeline', 'on'), ...
                                 {xlsub3_reinterp_b_im_out1}, ...
                                 {xlsub3_Convert3_out1});

        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/DSP48E_1
        xlsub3_DSP48E_1 = xBlock(struct('source', 'DSP48E', 'name', ['DSP48E', second_suffix]), ...
                                 struct('use_pcin', 'on', ...
                                        'pipeline_a', '2', ...
                                        'pipeline_b', '2'), ...
                                 {xlsub3_Convert_out1, xlsub3_Convert3_out1, xlsub3_DSP48E_0_out2, xlsub3_opmode3_out1, xlsub3_alumode3_out1, xlsub3_carryin3_out1, xlsub3_carryinsel3_out1}, ...
                                 {xlsub3_DSP48E_1_out1});                            
                             
        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/alumode3
        xlsub3_alumode3 = xBlock(struct('source', 'Constant', 'name', ['alumode3', second_suffix]), ...
                                 struct('arith_type', 'Unsigned', ...
                                        'const', 0, ...
                                        'n_bits', 4, ...
                                        'bin_pt', 0), ...
                                 {}, ...
                                 {xlsub3_alumode3_out1});

        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/carryin3
        xlsub3_carryin3 = xBlock(struct('source', 'Constant', 'name', ['carryin3', second_suffix]), ...
                                 struct('arith_type', 'Unsigned', ...
                                        'const', 0, ...
                                        'n_bits', 1, ...
                                        'bin_pt', 0), ...
                                 {}, ...
                                 {xlsub3_carryin3_out1});

        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/carryinsel3
        xlsub3_carryinsel3 = xBlock(struct('source', 'Constant', 'name', ['carryinsel3', second_suffix]), ...
                                    struct('arith_type', 'Unsigned', ...
                                           'const', 0, ...
                                           'n_bits', 3, ...
                                           'bin_pt', 0), ...
                                    {}, ...
                                    {xlsub3_carryinsel3_out1});

        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/realign_a_im

        xlsub3_realign_a_im = xBlock(struct('source', 'Convert', 'name', ['realign_a_im', second_suffix]), ...
                                     struct('n_bits', 18, ...
                                            'bin_pt', 17, ...
                                            'pipeline', 'on'), ...
                                     {xlsub3_c}, ...
                                     {xlsub3_realign_a_im_out1});

        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/realign_b_im
        xlsub3_realign_b_im = xBlock(struct('source', 'Convert', 'name', ['realign_b_im', second_suffix]), ...
                                     struct('n_bits', 18, ...
                                            'bin_pt', 17, ...
                                            'pipeline', 'on'), ...
                                     {xlsub3_d}, ...
                                     {xlsub3_realign_b_im_out1});

        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/opmode3
        xlsub3_opmode3 = xBlock(struct('source', 'Constant', 'name', ['opmode3', second_suffix]), ...
                                struct('arith_type', 'Unsigned', ...
                                       'const', 21, ...
                                       'n_bits', 7, ...
                                       'bin_pt', 0), ...
                                {}, ...
                                {xlsub3_opmode3_out1});

        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/reinterp_a_im
        xlsub3_reinterp_a_im = xBlock(struct('source', 'Reinterpret', 'name', ['reinterp_a_im', second_suffix]), ...
                                      struct('force_arith_type', 'on', ...
                                             'arith_type', 'Signed  (2''s comp)', ...
                                             'force_bin_pt', 'on'), ...
                                      {xlsub3_realign_a_im_out1}, ...
                                      {xlsub3_reinterp_a_im_out1});                                  
                                  
        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/reinterp_b_im
        xlsub3_reinterp_b_im = xBlock(struct('source', 'Reinterpret', 'name', ['reinterp_b_im', second_suffix]), ...
                                      struct('force_arith_type', 'on', ...
                                             'arith_type', 'Signed  (2''s comp)', ...
                                             'force_bin_pt', 'on'), ...
                                      {xlsub3_realign_b_im_out1}, ...
                                      {xlsub3_reinterp_b_im_out1});    
    else
        
        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/DSP48E_0
        xlsub3_DSP48E_0 = xBlock(struct('source', 'DSP48E', 'name', ['DSP48E', first_suffix]), ...
            struct(), ...
            {xlsub3_Convert2_out1, xlsub3_Convert4_out1, xlsub3_opmode2_out1, xlsub3_alumode2_out1, xlsub3_carryin2_out1, xlsub3_carryinsel2_out1}, ...
            { xlsub3_DSP48E_0_out2}); 
        
        % block: dsp48e_pfb_test2/pfb_row/macc_dsp48e_2in_0/reinterp_c_re
        xlsub3_reinterp_c_re = xBlock(struct('source', 'Reinterpret', 'name', ['reinterp_c_re', first_suffix]), ...
            struct('force_arith_type', 'on', ...
            'arith_type', 'Signed  (2''s comp)', ...
            'force_bin_pt', 'on', ...
            'bin_pt', 34), ...
            {xlsub3_DSP48E_0_out2}, ...
            {xlsub3_reinterp_c_re_out1});     
    end
    
end

end

