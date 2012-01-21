dec_rate = 3;

xCIC_input0 = xCIC_input.signals.values;
xCIC_result = xCIC.signals.values;
npCIC_input0 = npCIC_input.signals.values;
npCIC_result = npCIC.signals.values;
% myCIC_in0 = myCIC_input.signals.values;
% myCIC_in1 = myCIC_input1.signals.values;
% myCIC_in2 = myCIC_input2.signals.values;
% myCIC_in3 = myCIC_input3.signals.values;
% myCIC_in = zeros(1,length(myCIC_in0)*4);
% for i =1:length(myCIC_in0)
%     myCIC_in(4*(i-1)+1) = myCIC_in0(i);
%     myCIC_in(4*(i-1)+2) = myCIC_in1(i);
%     myCIC_in(4*(i-1)+3) = myCIC_in2(i);
%     myCIC_in(4*(i-1)+4) = myCIC_in3(i);
% end
% myCIC_in = transpose(myCIC_in);
% myCIC_result = myCIC.signals.values;
% myCIC1_result = myCIC1.signals.values;

xCIC_input_spec = 2*abs(fft(xCIC_input0(1:dec_rate:end)));
xCIC_result_spec = 2*abs(fft(xCIC_result));
xCIC_response  = xCIC_result_spec./xCIC_input_spec;
span = 25; % Size of the averaging window
window = ones(span,1)/span; 
xCIC_response_smoothed = convn(xCIC_response,window,'same');
%semilogy(xCIC_response_smoothed);
   %%semilogy(npCIC_response,'r');



%hold on;
npCIC_input_spec = 2*abs(fft(npCIC_input0(1:dec_rate:end)));
npCIC_result_spec = 2*abs(fft(npCIC_result));
npCIC_response  = npCIC_result_spec./npCIC_input_spec;
npCIC_response_smoothed = convn(npCIC_response,window,'same');
%semilogy(npCIC_response_smoothed,'r');
    %%semilogy(npCIC_response,'r');



% hold on;
% myCIC_input_spec = 2*abs(fft(myCIC_in(1:dec_rate:end)));
%  myCIC_input_spec = myCIC_input_spec(1:end-1);
% myCIC_result_spec = 2*abs(fft(myCIC_result));
% myCIC_response  = myCIC_result_spec./myCIC_input_spec;
% myCIC_response_smoothed = convn(myCIC_response,window,'same');
% %semilogy(myCIC_response_smoothed,'g');
%     %%semilogy(npCIC_response,'r');


% hold on;
% myCIC1_input_spec = 2*abs(fft(xCIC_input0(1:dec_rate:end)));
% 
% myCIC1_result_spec = 2*abs(fft(myCIC1_result));
% myCIC1_response  = myCIC1_result_spec./myCIC1_input_spec;
% myCIC1_response_smoothed = convn(myCIC1_response,window,'same');
% %semilogy(myCIC1_response_smoothed,'k');
%    %%semilogy(npCIC_response,'r');
% 



figure(1)
semilogy(npCIC_response_smoothed,'k');
hold on;
semilogy(xCIC_response_smoothed);

figure(2)
semilogy(xCIC_response_smoothed);
hold on;
semilogy(npCIC_response_smoothed,'g');







% %some crazy test
% hold on;
% crzCIC_input_spec = 2*abs(fft(myCIC_in(1:dec_rate:end)));
% crzCIC_input_spec = crzCIC_input_spec(1:end-1);
% crzCIC_result_spec = 2*abs(fft(xCIC_result));
% crzCIC_response  = crzCIC_result_spec./crzCIC_input_spec;
% crzCIC_response_smoothed = convn(crzCIC_response,window,'same');
% semilogy(crzCIC_response_smoothed,'r');
% %semilogy(npCIC_response,'r');