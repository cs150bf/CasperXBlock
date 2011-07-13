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
		xlsub2_out(row) = xOutput(['out',num2str(row)]);
    else
        xlsub2_out(row) = xBlock(struct('source', 'terminator', 'name', ['out',num2str(row)]), ...
								 struct{'ShowName','off'});
    end
end

%% diagram

% block: more_delays/delay_tree/delay_c1_r1

for col = 1:num_cols+1,
    for row = 1:bfac^(col-1),
		name = ['delay_c', num2str(col), '_r', num2str(row)];
		xlsub2_delay(col,row) = xBlock(struct('source', 'Delay', 'name', name), ...
										struct{'ShowName', 'off', ...
												'latency', '1', ...
												'reg_retiming', 'off'});
	end;
end;

prev = xlsub2_in; % this is the wire between blocks;
next = xSignal; % this is the wire between blocks;
xlsub2_delay(1,1).bindPort({prev}, {next});

for col = 1:num_cols,
    for row = 1:bfac^(col-1),
        currentBlock = xlsub2_delay(col,row);
        for group = 1:bfac,
            dst_id = 1+(row-1)*bfac+(group-1);
            nextBlock = xlsub2_delay(col+1, dst_id); 
            currentBlock.bindPort({prev},{next});
			prev = next;
			next = xSignal;
			nextBlock.bindPort({prev},{next});
        end
    end
end

end

