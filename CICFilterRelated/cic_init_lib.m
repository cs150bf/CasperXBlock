% CIC Single Channel v1.0
% Set Block Logo
sav_gcb=gcb;
[bg,fg] = xlcmap('XBlock',0);
iPos = get_param(sav_gcb,'Position');
iWidth=iPos(3)-iPos(1); iHeight=iPos(4)-iPos(2);
iCx=iWidth/2;
iCy=iHeight/2;
[logoX, logoY] = xlogo(iPos);

% Determine previous filter type and number of stages
prev_stages_list = find_system(sav_gcb, 'lookUnderMasks', 'all', 'FollowLinks', 'on', 'Regexp', 'on', 'Name', '^Integrator*'); %this is a cell array
prev_stages = length(prev_stages_list);

prev_filter_list = find_system(sav_gcb, 'lookUnderMasks', 'all', 'FollowLinks', 'on', 'Regexp', 'on', 'Name', '^Up Sample*'); %this is a cell array
if (isempty(prev_filter_list))
    prev_filter_list = find_system(sav_gcb, 'lookUnderMasks', 'all', 'FollowLinks', 'on', 'Regexp', 'on', 'Name', '^Down Sample*'); %this is a cell array
    if (isempty(prev_filter_list))
        errordlg('Previous Filter Type could not be determined')
    else
        prev_filter_type = 2;
    end
else
    prev_filter_type = 1;
end
  
  
% Print label on the block
if(filter_type == 2)
   cic_str = sprintf('%d-Stage\n CIC\n%d:1 Decimator',stages, rate_change);
else
   cic_str = sprintf('%d-Stage\n CIC\n1:%d Interpolator',stages, rate_change);	
end

% Make sure the entered values for stages and channels are positive integers
nstages = round(sum(abs(stages)));

% issue an error if the number of stages entered is zero
if (nstages == 0)
	nstages = prev_stages;
	errordlg('Number of Stages must be more than zero')
end

if (nstages == prev_stages) & (filter_type == prev_filter_type)
    return
end

if(filter_type == 2) % Decimator
   if (prev_filter_type == 1) % was interpolator so turn to decimator
       for i= 2:prev_stages,
	      delete_line(sav_gcb, ['Integrator' int2str(i-1) '/' int2str(1)], ['Integrator' int2str(i) '/' int2str(1)]);
	      delete_line(sav_gcb, ['Differentiator' int2str(i-1) '/' int2str(1)], ['Differentiator' int2str(i) '/' int2str(1)]);
       end

       % disconnect the last blocks in the two sections
       delete_line(sav_gcb, ['Differentiator' int2str(prev_stages) '/' int2str(1)], ['Up Sample/1']);
       delete_line(sav_gcb, ['Integrator' int2str(prev_stages) '/' int2str(1)], 'Out1/1');
	
	   % delete the line from the Up sampler to the Integrator
	   delete_line(sav_gcb, 'Up Sample/1', 'Integrator1/1'); 
	   delete_line(sav_gcb, 'In1/1', 'Differentiator1/1'); 
	   
	   % Delete the Up Sampler and then replace with an Down Sampler
	   pup = get_param([sav_gcb '/Up Sample'], 'position');
	   delete_block([sav_gcb '/Up Sample']);
	   load_system('xbsIndex_r4');
	   add_block('xbsIndex_r4/Down Sample', [sav_gcb '/Down Sample'], 'sample_ratio', 'rate_change','sample_phase', 'First Value of Frame', 'position', [pup(1), pup(2), pup(3),pup(4)]);
	   
	   % Switch the Integrators and Decimators around
	   for i=1:prev_stages,
		   tempi = get_param([sav_gcb '/Integrator' int2str(i)], 'position');
	       tempd = get_param([sav_gcb '/Differentiator' int2str(i)], 'position');
		   set_param([sav_gcb '/Differentiator' int2str(i)], 'position', [tempi(1), tempi(2), tempi(3), tempi(4)], 'output_bitwidth', 'ceil(stages*log2(rate_change*m) + input_bitwidth)');
		   set_param([sav_gcb '/Integrator' int2str(i)], 'position', [tempd(1), tempd(2), tempd(3), tempd(4)]);
	   end
	   	   	
	   % add back in the lines
       add_line(sav_gcb, 'In1/1', 'Integrator1/1', 'autorouting', 'on');
	   add_line(sav_gcb, ['Integrator' int2str(prev_stages) '/1'], 'Down Sample/1', 'autorouting', 'on');
	   add_line(sav_gcb, 'Down Sample/1', 'Differentiator1/1', 'autorouting', 'on');
	   add_line(sav_gcb, ['Differentiator' int2str(prev_stages) '/1'], 'Out1/1', 'autorouting', 'on');
	   for i= 2:prev_stages,
          add_line(sav_gcb, ['Integrator' int2str(i-1) '/1'], ['Integrator' int2str(i) '/' int2str(1)], 'autorouting', 'on');
          add_line(sav_gcb, ['Differentiator' int2str(i-1) '/1'], ['Differentiator' int2str(i) '/' int2str(1)], 'autorouting', 'on');
	   end
		
       %Set the Output bit widths of Differentiator and Integrator stages
       set_param([sav_gcb '/Differentiator1'], 'output_bitwidth', 'ceil(stages*log2(rate_change*m) + input_bitwidth)');
	   	   %Set the Output bit width of Integrator stages
	   %Calculate the Interpolator Integrator Output Bit Growth
       for i= 1:prev_stages,
			 j = nstages+i;
	         set_param([sav_gcb '/Integrator' int2str(i)], 'output_bitwidth', 'ceil(stages*log2(rate_change*m) + input_bitwidth)');
             set_param([sav_gcb '/Differentiator' int2str(i)], 'output_bitwidth', 'ceil(stages*log2(rate_change*m) + input_bitwidth)');
	   end
	   
   end
   
   if (nstages ~= prev_stages)
    
       % disconnect all the wires from all the blocks
       for i= 2:prev_stages,
	      delete_line(sav_gcb, ['Integrator' int2str(i-1) '/' int2str(1)], ['Integrator' int2str(i) '/' int2str(1)]);
	      delete_line(sav_gcb, ['Differentiator' int2str(i-1) '/' int2str(1)], ['Differentiator' int2str(i) '/' int2str(1)]);
       end

       % disconnect the last blocks in the two sections
       delete_line(sav_gcb, ['Integrator' int2str(prev_stages) '/' int2str(1)], ['Down Sample/1']);
       delete_line(sav_gcb, ['Differentiator' int2str(prev_stages) '/' int2str(1)], 'Out1/1');
	
	   % delete the line from the down sampler to the differentiator
	   delete_line(sav_gcb, 'Down Sample/1', 'Differentiator1/1');
	
	   % Remove all the blocks except the first one (as we always will have one)
       for i=2:prev_stages,
		  delete_block([sav_gcb '/Differentiator' int2str(i)]);
	      delete_block([sav_gcb '/Integrator' int2str(i)]);
       end
	   
	   %Set the Output bit width of Differentiator stages
       set_param([sav_gcb '/Differentiator1'], 'output_bitwidth', 'ceil(stages*log2(rate_change*m) + input_bitwidth)');
	   
	   % collect data on the position of existing blocks
	   pi = get_param([sav_gcb '/Integrator1'], 'position');
	   pd = get_param([sav_gcb '/Differentiator1'], 'position');
	   set_param([sav_gcb '/Differentiator1'], 'position', [pi(1)+(nstages+1)*80, pd(2), pi(3)+(nstages+1)*80, pd(4)]);
	   pd = get_param([sav_gcb '/Differentiator1'], 'position');
	
	   % move the current blocks to accomadate for new blocks to be added 
	   pds = get_param([sav_gcb '/Down Sample'], 'position');
	   set_param([sav_gcb '/Down Sample'], 'position', [pi(1)+(nstages)*80, pds(2), pi(3)+(nstages)*80, pds(4)]);
	   
	   po = get_param([sav_gcb '/Out1'], 'position');
	   set_param([sav_gcb '/Out1'], 'position', [pd(1)+(nstages+1)*80, po(2), pd(1)+(po(3)-po(1))+(nstages+1)*80, po(4)]);	
	
	   % add back in the line between the Down Sampler and the 1st Differentiator
       add_line(sav_gcb, 'Down Sample/1', ['Differentiator1/' int2str(1)], 'autorouting', 'on');

	   % Only add blocks if more than one stage is required
	   if (nstages ~= 1)
		
	       % Add in a copy of the first block to make up the required number of stages
           for i=2:nstages,
               add_block([sav_gcb '/Integrator1'], [sav_gcb '/Integrator' int2str(i)], 'position', [pi(1)+(i-1)*80, pi(2), pi(3)+(i-1)*80, pi(4)]);
		       add_block([sav_gcb '/Differentiator1'], [sav_gcb '/Differentiator' int2str(i)], 'position', [pd(1)+(i-1)*80, pd(2), pd(3)+(i-1)*80, pd(4)]);
	       end
		
	       % Connect up the wires to each block use autorouting
           for i= 2:nstages,
 		       add_line(sav_gcb, ['Integrator' int2str(i-1) '/' int2str(1)], ['Integrator' int2str(i) '/' int2str(1)], 'autorouting', 'on');
	           add_line(sav_gcb, ['Differentiator' int2str(i-1) '/' int2str(1)], ['Differentiator' int2str(i) '/' int2str(1)], 'autorouting', 'on');
           end
	    end
	       % Connect the last blocks in the two sections
           add_line(sav_gcb, ['Integrator' int2str(nstages) '/' int2str(1)], ['Down Sample/1'], 'autorouting', 'on');
           add_line(sav_gcb, ['Differentiator' int2str(nstages) '/' int2str(1)], ['Out1/1'], 'autorouting', 'on');
   end

else % Interpolator
   
	
	if (prev_filter_type == 2) % was decimator so turn to interpolator
	
	  % disconnect all the wires from all the blocks
       for i= 2:prev_stages,
	      delete_line(sav_gcb, ['Integrator' int2str(i-1) '/' int2str(1)], ['Integrator' int2str(i) '/' int2str(1)]);
	      delete_line(sav_gcb, ['Differentiator' int2str(i-1) '/' int2str(1)], ['Differentiator' int2str(i) '/' int2str(1)]);
       end

       % disconnect the last blocks in the two sections
       delete_line(sav_gcb, ['Integrator' int2str(prev_stages) '/' int2str(1)], ['Down Sample/1']);
       delete_line(sav_gcb, ['Differentiator' int2str(prev_stages) '/' int2str(1)], 'Out1/1');
	
	   % delete the line from the down sampler to the Differentiator
	   delete_line(sav_gcb, 'Down Sample/1', 'Differentiator1/1'); 
	   delete_line(sav_gcb, 'In1/1', 'Integrator1/1'); 
	   
	   % Delete the Down Sampler and then replace with a Up Sampler
	   pdwn = get_param([sav_gcb '/Down Sample'], 'position');
	   delete_block([sav_gcb '/Down Sample']);
	   load_system('xbsIndex_r4');
	   add_block('xbsIndex_r4/Up Sample', [sav_gcb '/Up Sample'], 'sample_ratio', 'rate_change', 'position', [pdwn(1), pdwn(2), pdwn(3), pdwn(4)]);
	   
	   % Switch the Integrators and Decimators around
	   for i=1:prev_stages,
		   tempi = get_param([sav_gcb '/Integrator' int2str(i)], 'position');
	       tempd = get_param([sav_gcb '/Differentiator' int2str(i)], 'position');
		   set_param([sav_gcb '/Differentiator' int2str(i)], 'position', [tempi(1), tempi(2), tempi(3), tempi(4)], 'output_bitwidth', [int2str(i) '+ input_bitwidth']);
		   set_param([sav_gcb '/Integrator' int2str(i)], 'position', [tempd(1), tempd(2), tempd(3), tempd(4)]);
	   end
	   	   	
	   % add back in the lines
       add_line(sav_gcb, 'In1/1', 'Differentiator1/1', 'autorouting', 'on');
	   add_line(sav_gcb, ['Differentiator' int2str(prev_stages) '/1'], 'Up Sample/1', 'autorouting', 'on');
	   add_line(sav_gcb, 'Up Sample/1', 'Integrator1/1', 'autorouting', 'on');
	   add_line(sav_gcb, ['Integrator' int2str(prev_stages) '/1'], 'Out1/1', 'autorouting', 'on');
	   for i= 2:prev_stages,
          add_line(sav_gcb, ['Integrator' int2str(i-1) '/1'], ['Integrator' int2str(i) '/1'], 'autorouting', 'on');
          add_line(sav_gcb, ['Differentiator' int2str(i-1) '/1'], ['Differentiator' int2str(i) '/1'], 'autorouting', 'on');
	   end
	   
	   %Set the Output bit width of Integrator stages
	   %Calculate the Interpolator Integrator Output Bit Growth
       for i= 1:prev_stages,
			 j = nstages+i;
	         set_param([sav_gcb '/Integrator' int2str(i)], 'output_bitwidth', ['ceil(log2(2^(2*stages-' int2str(j) ')*(rate_change*m)^(' int2str(j) '-stages)) + input_bitwidth)']);
	   end
		
   end
   
	
	if (nstages ~= prev_stages)
    
       % disconnect all the wires from all the blocks
       for i= 2:prev_stages,
	      delete_line(sav_gcb, ['Integrator' int2str(i-1) '/' int2str(1)], ['Integrator' int2str(i) '/' int2str(1)]);
	      delete_line(sav_gcb, ['Differentiator' int2str(i-1) '/' int2str(1)], ['Differentiator' int2str(i) '/' int2str(1)]);
       end

       % disconnect the last blocks in the two sections
       delete_line(sav_gcb, ['Differentiator' int2str(prev_stages) '/' int2str(1)], ['Up Sample/1']);
       delete_line(sav_gcb, ['Integrator' int2str(prev_stages) '/' int2str(1)], 'Out1/1');
       
	
	   % delete the line from the Up sampler to the Integrator1 for movement later
	   delete_line(sav_gcb, 'Up Sample/1', 'Integrator1/1'); 
	
	   % Remove all the blocks except the first one (as we always will have one)
       for i=2:prev_stages,
		  delete_block([sav_gcb '/Differentiator' int2str(i)]);
	      delete_block([sav_gcb '/Integrator' int2str(i)]);
       end
	
	   %Set the Output bit width of first Differentiator stage (other are set as copies of this block)
       set_param([sav_gcb '/Differentiator1'], 'output_bitwidth', '1 + input_bitwidth');
	   
	   % collect data on the position of existing blocks
	   pi = get_param([sav_gcb '/Integrator1'], 'position');
	   pd = get_param([sav_gcb '/Differentiator1'], 'position');
	   set_param([sav_gcb '/Integrator1'], 'position', [pd(1)+(nstages+1)*80, pi(2), pd(3)+(nstages+1)*80, pi(4)]);
	   pi = get_param([sav_gcb '/Integrator1'], 'position');
	
	   % move the current blocks to accomadate for new blocks to be added 
	   pus = get_param([sav_gcb '/Up Sample'], 'position');
	   set_param([sav_gcb '/Up Sample'], 'position', [pd(1)+(nstages)*80, pus(2), pd(3)+(nstages)*80, pus(4)]);
	
	   po = get_param([sav_gcb '/Out1'], 'position');
       set_param([sav_gcb '/Out1'], 'position', [pi(1)+(nstages+1)*80, po(2), pi(1)+(po(3)-po(1))+(nstages+1)*80, po(4)]);	
      
	
	   % add back in the line between the Up Sampler and the 1st Integrator1
	   add_line(sav_gcb, 'Up Sample/1', 'Integrator1/1', 'autorouting', 'on');
	   
	   % Only add blocks if more than one stage is required
	   if (nstages ~= 1)
		
	       % Add in a copy of the first block to make up the required number of stages
           for i=2:nstages,
               add_block([sav_gcb '/Integrator1'], [sav_gcb '/Integrator' int2str(i)], 'position', [pi(1)+(i-1)*80, pi(2), pi(3)+(i-1)*80, pi(4)]);
		       add_block([sav_gcb '/Differentiator1'], [sav_gcb '/Differentiator' int2str(i)], 'position', [pd(1)+(i-1)*80, pd(2), pd(3)+(i-1)*80, pd(4)], 'output_bitwidth', [int2str(i) '+ input_bitwidth']);
	       end
		
	       % Connect up the wires to each block use autorouting
           for i= 2:nstages,
 		       add_line(sav_gcb, ['Integrator' int2str(i-1) '/' int2str(1)], ['Integrator' int2str(i) '/' int2str(1)], 'autorouting', 'on');
	           add_line(sav_gcb, ['Differentiator' int2str(i-1) '/' int2str(1)], ['Differentiator' int2str(i) '/' int2str(1)], 'autorouting', 'on');
           end
	    end
	       % Connect the last blocks in the two sections
           add_line(sav_gcb, ['Differentiator' int2str(nstages) '/1'], ['Up Sample/1'], 'autorouting', 'on');
           add_line(sav_gcb, ['Integrator' int2str(nstages) '/1'], ['Out1/1'], 'autorouting', 'on');
		   
	     %Set the Output bit width of Integrator stages
	     %Calculate the Interpolator Integrator Output Bit Growth
          for i= 1:nstages,
			 j = nstages+i;
	         set_param([sav_gcb '/Integrator' int2str(i)], 'output_bitwidth', ['ceil(log2(2^(2*stages-' int2str(j) ')*(rate_change*m)^(' int2str(j) '-stages)) + input_bitwidth)']);
	      end
   end
	  
end


% Set the pipelining to ON or OFF on the differentiators
if (pipeline == 0)
	for i= 1:nstages
		set_param([sav_gcb '/Differentiator' int2str(i), '/AddSub'], 'latency', '0')
	end
else
	for i= 1:nstages
		set_param([sav_gcb '/Differentiator' int2str(i), '/AddSub'], 'latency' ,'1')
	end
end