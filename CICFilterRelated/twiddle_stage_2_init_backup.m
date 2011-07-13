set_param(gcb,'LinkStatus','inactive');
if(strcmp(opt_target, 'logic')), 
    lat = add_latency;
    lat_str = 'add_latency';
else,
    lat = add_latency*2;
    lat_str = 'add_latency*2';
end
set_param([gcb,'/delay0'], 'latency', ...
    ['bram_latency+mult_latency+conv_latency+',lat_str]);
set_param([gcb,'/delay1'], 'latency', ...
    ['bram_latency+mult_latency+conv_latency+',lat_str]);

% any dynamic mux latency must be a number,
% or else simulink will throw obscure errors.
set_param([gcb,'/mux0'], 'latency', ...
    num2str(mult_latency+conv_latency+lat));
set_param([gcb,'/delay2'], 'latency', ...
    ['mult_latency+conv_latency+',lat_str,'-1']);
set_param([gcb,'/delay3'], 'latency', ...
    ['mult_latency+conv_latency+',lat_str,'-1']);
set_param([gcb,'/delay4'], 'latency', ...
    ['bram_latency+mult_latency+',lat_str,'-2']);

set_param([gcb,'/delay8'], 'latency', ...
    ['mult_latency+conv_latency+',lat_str]);