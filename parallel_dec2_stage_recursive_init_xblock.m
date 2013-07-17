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
function parallel_dec2_stage_recursive_init_xblock(blk, n_stages,n_inputs,add_latency,skip, n_bits, bin_pt,dec2_halfout, reduced_crtc_path)

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
                      'rate_change', 2, ...
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
                           struct('sample_ratio',2, ...
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
    
elseif strcmp(dec2_halfout,'on') 
    inports = cell(1,n_inputs);
    outports = cell(1,n_inputs/2);
    
    for i = 1:n_inputs
        inports{i} = xInport(['in',num2str(i)]);
        if mod(i,2) == skip
            outports{int32(i/2)}=xOutport(['out',num2str(int32(i/2))]);
        end
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
    
    % add terminators
    for i=1+mod(skip+1,2):2:n_inputs
        xBlock(struct('source','Terminator','name',['terminator',num2str(i)]), ...
                [], ...
                {int_ins{n_stages+1}{i}}, ...
                {[]});
    end
    
    % add down sampler
    % not really downsampler in this case, becasue we just thrown half of
    % the outputs of the parallel integrator
    % and add comb section
    comb_ins = cell(1,n_stages+1);
    comb_blks = cell(1,n_stages);
    comb_ins{1} = {int_ins{n_stages+1}{1+skip:2:end}};
    for i =1:n_stages
        comb_ins{i+1} = cell(1,n_inputs/2);
        for j=1:n_inputs/2
            comb_ins{i+1}{j} = xSignal(['comb_ins',num2str(i),'_',num2str(j)]);
        end
        comb_blks{i} = xBlock(struct('source',str2func('parallel_differentiator_init_xblock'),'name',['comb_',num2str(i)]), ...
                              {strcat(blk,['/comb_',num2str(i)]), ...
                               n_inputs/2,n_bits, bin_pt, 1, add_latency}, ...
                               comb_ins{i}, ...
                               comb_ins{i+1});
    end
    
    
    outports
    comb_ins
    for i =1:n_inputs/2
        outports{i}.bind(comb_ins{n_stages+1}{i})
    end
    

   
    
    
else
    disp('Not supported yet');
    
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


function delay_max = find_delay_max(coefficients,add_latency)

len = length(coefficients);

const_bin_array = cell(1,len);
for i = 1:len
    const_bin_array{i} = dec2bin(coefficients(i));
end

delay_max = 0;
for i=1:len
    
    temp_len = length(find(const_bin_array{i} == '1'));
    temp_delay = ceil(log2(temp_len))*add_latency;
    if temp_delay > delay_max
        delay_max = temp_delay;
    end
end

end