set_param(gcb,'LinkStatus','inactive');
if(strcmp(opt_target, 'logic')), 
    latency = 'mult_latency+add_latency+bram_latency+conv_latency';
else,
    latency = 'mult_latency+add_latency*2+bram_latency+conv_latency';
end
set_param([gcb,'/delay0'], 'latency', latency);
set_param([gcb,'/delay1'], 'latency', latency);
set_param([gcb,'/delay2'], 'latency', latency);
set_param([gcb,'/delay3'], 'latency', latency);
set_param([gcb,'/negate'], 'latency', latency);