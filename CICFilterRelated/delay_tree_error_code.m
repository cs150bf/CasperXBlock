function delay_tree_new(fanout, bfac)

if (fanout < 1),
    errordlg('Invalid fanout. Should be greater than zero.');
    return
end

if (bfac < 2),
    errordlg('Invalid branching factor. Should be greater than one.');
    return
end

if (bfac > fanout),
    errordlg('Branching factor cannot exceed fanout.');
    return
end

% Calculate number of columns.

if (bfac == 2),
    num_cols = nextpow2(fanout);
else
    num_cols = ceil(log2(fanout)/log2(bfac));
end

%% inports
xlsub2_in = xInport('in');

%% outports
for row = 1:bfac^num_cols,
    if (row <= fanout),
		xlsub2_out(row) = xOutport(['out',num2str(row)]);
    else
        xlsub2_out(row) = xBlock(struct('source', 'terminator', 'name', ['out',num2str(row)]), ...
								 struct('ShowName','off'));
    end
end

%% diagram

% block: more_delays/delay_tree/delay_c1_r1


for col = 1:num_cols+1,
    for row = 1:bfac^(col-1),
        %disp(['blk',['c',num2str(col), '_r',num2str(row)],'     ',['c',num2str(col),'_r',num2str(row)]]);
        xlsub2_blk_in.(['c',num2str(col),'_r',num2str(row)]) = xSignal;
        xlsub2_blk_out.(['c',num2str(col),'_r',num2str(row)]) = xSignal;
		xlsub2_delay.(['c',num2str(col),'_r',num2str(row)]) = xBlock('Delay', struct('ShowName', 'off', ...
                                                    	'latency', 1, ...
                                                    	'reg_retiming', 'off'), ...
                                        {xlsub2_blk_in.(['c',num2str(col),'_r',num2str(row)])}, ...
                                        {xlsub2_blk_out.(['c',num2str(col),'_r',num2str(row)])});
        xlsub2_blk_in
        xlsub2_blk_out
        xlsub2_delay
    end
end

xlsub2_blk_in.('c1_r1').bind(xlsub2_in);

for col = 1:num_cols,
    for row = 1:bfac^(col-1),
        for group = 1:bfac,
            dst_id = 1+(row-1)*bfac+(group-1);
            %disp([['c',num2str(col+1), '_r',num2str(dst_id)],'     ',['c',num2str(col),'_r',num2str(row)]]);
            xlsub2_blk_in.(['c',num2str(col+1), '_r',num2str(dst_id)]).bind(xlsub2_blk_out.(['c',num2str(col),'_r',num2str(row)])); 
        end
    end
end


end

