delay_tree_new(4,2)

xlsub2_blk_in = 

    c1_r1: [1x1 xSignal]


xlsub2_blk_out = 

    c1_r1: [1x1 xSignal]


xlsub2_delay = 

    c1_r1: [1x1 xBlock]


xlsub2_blk_in = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]


xlsub2_blk_out = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]


xlsub2_delay = 

    c1_r1: [1x1 xBlock]
    c2_r1: [1x1 xBlock]


xlsub2_blk_in = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]
    c2_r2: [1x1 xSignal]


xlsub2_blk_out = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]
    c2_r2: [1x1 xSignal]


xlsub2_delay = 

    c1_r1: [1x1 xBlock]
    c2_r1: [1x1 xBlock]
    c2_r2: [1x1 xBlock]


xlsub2_blk_in = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]
    c2_r2: [1x1 xSignal]
    c3_r1: [1x1 xSignal]


xlsub2_blk_out = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]
    c2_r2: [1x1 xSignal]
    c3_r1: [1x1 xSignal]


xlsub2_delay = 

    c1_r1: [1x1 xBlock]
    c2_r1: [1x1 xBlock]
    c2_r2: [1x1 xBlock]
    c3_r1: [1x1 xBlock]


xlsub2_blk_in = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]
    c2_r2: [1x1 xSignal]
    c3_r1: [1x1 xSignal]
    c3_r2: [1x1 xSignal]


xlsub2_blk_out = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]
    c2_r2: [1x1 xSignal]
    c3_r1: [1x1 xSignal]
    c3_r2: [1x1 xSignal]


xlsub2_delay = 

    c1_r1: [1x1 xBlock]
    c2_r1: [1x1 xBlock]
    c2_r2: [1x1 xBlock]
    c3_r1: [1x1 xBlock]
    c3_r2: [1x1 xBlock]


xlsub2_blk_in = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]
    c2_r2: [1x1 xSignal]
    c3_r1: [1x1 xSignal]
    c3_r2: [1x1 xSignal]
    c3_r3: [1x1 xSignal]


xlsub2_blk_out = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]
    c2_r2: [1x1 xSignal]
    c3_r1: [1x1 xSignal]
    c3_r2: [1x1 xSignal]
    c3_r3: [1x1 xSignal]


xlsub2_delay = 

    c1_r1: [1x1 xBlock]
    c2_r1: [1x1 xBlock]
    c2_r2: [1x1 xBlock]
    c3_r1: [1x1 xBlock]
    c3_r2: [1x1 xBlock]
    c3_r3: [1x1 xBlock]


xlsub2_blk_in = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]
    c2_r2: [1x1 xSignal]
    c3_r1: [1x1 xSignal]
    c3_r2: [1x1 xSignal]
    c3_r3: [1x1 xSignal]
    c3_r4: [1x1 xSignal]


xlsub2_blk_out = 

    c1_r1: [1x1 xSignal]
    c2_r1: [1x1 xSignal]
    c2_r2: [1x1 xSignal]
    c3_r1: [1x1 xSignal]
    c3_r2: [1x1 xSignal]
    c3_r3: [1x1 xSignal]
    c3_r4: [1x1 xSignal]


xlsub2_delay = 

    c1_r1: [1x1 xBlock]
    c2_r1: [1x1 xBlock]
    c2_r2: [1x1 xBlock]
    c3_r1: [1x1 xBlock]
    c3_r2: [1x1 xBlock]
    c3_r3: [1x1 xBlock]
    c3_r4: [1x1 xBlock]

??? Error using ==> xSignal_assign_xSignal at 755
Invalid Simulink object handle.

Error in ==>
/opt/Xilinx/11.1/DSP_Tools/lin64/sysgen/bin/xl_script_callbacks.p>xl_script_callbacks
at 15


Error in ==>
/opt/Xilinx/11.1/DSP_Tools/lin64/sysgen/bin/@xSignal/subsref.p>subsref
at 23


Error in ==> delay_tree_new at 67
            xlsub2_blk_in.(['c',num2str(col+1),
            '_r',num2str(dst_id)]).bind(xlsub2_blk_out.(['c',num2str(col),'_r',num2str(row)])); 
