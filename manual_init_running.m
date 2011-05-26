function [param,values] = manual_init_running(blk,init_script_name,setting)
%% running init script for current block
%%% Inputs:
% blk = the block to renew
% init_script_name,  type: string   the name of the init file
% settings = {'vername',value, ...} pairs
%%% Outputs:
% param = {'vername,value,...} pairs with all the user data
% values = {value, ...}  retrieves all the values from the param
%%%%%  to find out the parameter names, run it with setting={}
%%%%%  to reset some of the parameters, run it as
%%%%%  settings={'vername1',value1, 'vername2',value2, ...};
% example: [params,values]=manual_init_running(gcb, 'fir_col_init', {'n_inputs',2})
% then you can run fir_col_init_xblock(values{:});


%% 

dialogparam = getfield(get_param(gcb,'UserData'),'parameters');
try
    dialogparam=rmfield(dialogparam,'defaults');
catch
    err=1;
end
disp('Use Data:');
names = fieldnames(dialogparam)
size_names=size(names);
num_names=size_names(1);
param=cell(1,2*num_names);
for i=1:num_names,
    param{1,2*i-1}=names{i,1};
    if (~isnan(get_var(names{i,1},setting{:})))
        param{1,2*i}=get_var(names{i,1},setting{:});
    else
        param{1,2*i}=getfield(dialogparam,names{i,1});
    end;
end
param
values=param(2:2:end);

init_func=str2func(init_script_name);
init_func(blk, param{:});

