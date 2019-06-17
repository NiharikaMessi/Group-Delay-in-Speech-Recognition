%% Test LPC Final 

%Extracting the signal 

[y,Fs]=audioread('C:\Users\dell\Desktop\Win\s1.wav');
x_channel=y(:,1);
m=size(x_channel,1);


%Copy of the signal.
F=x_channel;

% %Adding Noise to the siganl . 
% N=awgn(F,10);
% F1=F+N;

%Performing LP Analysis
F1_lpc=lpc(F1,12);

%Writing in terms of denominator 
G=1./fft(F1_lpc,512);

%Arguments in radians.
ffreq =atan2(imag(G), real(G));

%Derivative of the vector.
est=-1*diff(ffreq);
est(end+1)=est(end);

%Plotting the signals. 
figure
subplot(2,1,1)
plot(abs(fft(F1)),'g')
legend('Signal')
subplot(2,1,2)
hold on
plot(abs(G)/max(abs(G)),'r')
plot(est/max(est),'b')
legend('LP Spectra - TF (H(z) ','Estimated Spectra LP Analysis');


