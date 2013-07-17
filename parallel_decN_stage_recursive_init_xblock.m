%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %      
%   Copyright (C) 2011    Hong Chen                                           %
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
function parallel_decN_stage_recursive_init_xblock(blk,n_stages,rate_change, n_inputs,add_latency, n_bits, bin_pt, reduced_crtc_path)

coeffs = zeros(1,n_stages+1);
for i = 1:n_stages+1
    coeffs(1,i) = nchoosek(n_stages,i-1);
end
 
if n_inputs ==1 && strcmp(reduced_crtc_path, 'off')
    
    inport = xInport('in');
    outport = xOutport('out');
    
    cic_blk = xBlock(struct('source','xrbsDSP_r4/CIC Filter','name','cic_blk'), ...
                     {'inpu_bitwidth', n_bits,  ...
                      'input_binpt', bin_pt, ...
                      'filter_type', 2, ...
                      'rate_change', rate_change, ...
                      'stages', n_stages, ...
                      'm', 1, ...
                      'pipeline', add_latency>0}, ...
                      {inport}, ...
                      {outport});
                                                              
elseif n_inputs ==1 && strcmp(reduced_crtc_path, 'on')
    
    inport = xInport('in');
    outport = xOutport('out');
    
    % draw integrator section
    int_ins = cell(1,n_stages+1);
    int_blks = cell(1,n_stages);
    int_ins{1} = inport;
    for i =1:n_stages
        int_ins{i+1} = xSignal(['int_in',num2str(i+1)]);
        int_blks{i} = xBlock(struct('srouce',@my_accumulator_init_xblock, 'name', ['integrator_',num2str(i)]), ...
                            {n_bits,bin_pt, add_latency, reduced_crtc_path}, ...
                            {int_ins{i}}, ...
                            {int_ins{i+1}});
    end
    
    % add down sampler
    ds_out = xSignal('ds_out');
    downsampler = xBlock(struct('source', 'xbsBasic_r4/Down Sample', 'name', 'Down_sample1'), ...
                           struct('sample_ratio',rate_change, ...
                                  'latency', 1), ...
                      {int_ins{n_stages+1}}, ...
                      {ds_out});
                  
    % add comb section
    comb_ins = cell(1,n_stages+1);
    comb_blks = cell(1,n_stages+1);
    comb_ins{1} = ds_out;
    for i = 1:n_stages
        comb_ins{i+1} = xSignal(['comb_in',num2str(i+1)]);
        comb_blks{i} = xBlock(struct('source',str2func('parallel_differentiator_init_xblock'),'name',['comb_',num2str(i)]), ...
                              {strcat(blk,['/comb_',num2str(i)]), ...
                               1,n_bits, bin_pt, 1, add_latency}, ...
                               {comb_ins{i}}, ...
                               {comb_ins{i+1}});
    end
    
    outport.bind(comb_ins{n_stages+1});
    
else
    inports = cell(1,n_inputs);
    outports = cell(1,n_inputs);
    
    for i =1:n_inputs
        inports{i} = xInport(['in',num2str(i)]);
        outports{i}=xOutport(['out',num2str(i)]);
    end

    % add parallel integrator
    int_ins = cell(1,n_stages+1);
    int_blks = cell(1,n_stages);
    int_ins{1} = inports;
    for i =1:n_stages
        int_ins{i+1} = cell(1,n_inputs);
        for j =1:n_inputs
            int_ins{i+1}{j} = xSignal(['int_ins',num2str(i),'_',num2str(j)]);
        end
        int_blks{i} = xBlock(struct('source',str2func('parallel_integrator_init_xblock'),'name',['int_',num2str(i)]), ...
                              {strcat(blk,['/int_',num2str(i)]), ...
                                n_inputs,n_bits, bin_pt, add_latency, reduced_crtc_path}, ...
                               [int_ins{i},{int_ins{i}{1}}], ...
                               [int_ins{i+1},{[]}]);
    end
    
    % add down sampler
    
    ds_outs=cell(1,n_inputs);
    for i =1:n_inputs
        ds_outs{i}=xSignal(['ds_out',num2str(i)]);
    end
    downsampler=xBlock(struct('source',str2func('parallel_filter_init_xblock'),'name',['downsample_',num2str(rate_change)]),...
                        {rate_change, n_inputs}, ...
                        [{int_ins{1}{1}}, int_ins{n_stages+1}],...
                        [{[]},ds_outs]);
    
    
    
    
    % and add comb section
    comb_ins = cell(1,n_stages+1);
    comb_blks = cell(1,n_stages);
    comb_ins{1} = ds_outs;
    for i =1:n_stages
        comb_ins{i+1} = cell(1,n_inputs);
        for j=1:n_inputs
            comb_ins{i+1}{j} = xSignal(['comb_ins',num2str(i),'_',num2str(j)]);
        end
        comb_blks{i} = xBlock(struct('source',str2func('parallel_differentiator_init_xblock'),'name',['comb_',num2str(i)]), ...
                              {strcat(blk,['/comb_',num2str(i)]), ...
                               n_inputs,n_bits, bin_pt, 1, add_latency}, ...
                               comb_ins{i}, ...
                               comb_ins{i+1});
    end
    
    for i =1:n_inputs
      outports{i}.bind(comb_ins{n_stages+1}{i});
    end
    
    
    
end

if ~isempty(blk) && ~strcmp(blk(1),'/')
    clean_blocks(blk);
end

end





function my_accumulator_init_xblock(n_bits, bin_pt, add_latency, reduced_crtc_path)

inport = xInport('in');
outport = xOutport('out');

feedback_signal = xSignal('feedback');
adder_out = xSignal('adder_out');
adder_blk = xBlock(struct('source','AddSub', 'name', 'adder_blk1'), ...
                         struct('mode', 'Addition', ...
                                'latency', add_latency, 'precision', 'User Defined', ...
                                'arith_type', 'Signed  (2''s comp)', ...
                                'n_bits', n_bits, 'bin_pt', bin_pt, ...
                                'quantization', 'Round  (unbiased: +/- Inf)',...
                                'overflow', 'Wrap', ...
                                'use_behavioral_HDL', 'on'), ...
                                {feedback_signal, inport}, ...
                                {adder_out});   
delay_blk = xBlock(struct('source','Delay','name', 'delay'), ...
                          struct('latency', 1), ...   
                          {adder_out}, ...
                          {feedback_signal});
                      
                      
if strcmp(reduced_crtc_path, 'off')                        
    outport.bind(adder_out);
else
    outport.bind(feedback_signal);
end

end
