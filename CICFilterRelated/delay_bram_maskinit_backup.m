%delay_bram Mask initialization command back up
if (DelayLen <= bram_latency)
	error('delay value must be greater than BRAM Latency');
end
BitWidth = max(ceil(log2(DelayLen)), 2);
if strcmp(use_dsp48,'on'),
    set_param([gcb,'/Counter'], 'use_behavioral_HDL', 'off', ...
        'use_rpm', 'on', 'implementation', 'DSP48');
else, %default counter settings
        set_param([gcb,'/Counter'], 'use_behavioral_HDL', 'off', ...
        'use_rpm', 'off', 'implementation', 'Fabric');
end