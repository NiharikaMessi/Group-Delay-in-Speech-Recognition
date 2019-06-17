%% Modified Group Delay Process. 

%Extractiong of signal from audio file .
[y,Fs]=audioread('C:\Users\dell\Desktop\Win\s1.wav');
x_channel=y(:,1);
m=size(x_channel,1);
F11=x_channel;
F1=F11';

%Computing x(n) and x'(n) (Derivative signal). 

for i=1:m
    F1d(i)=i*F1(i);
end

%Adding Noise 
% %Adding Noise to the siganl . 
% N1=awgn(F1,10);
% N2=awgn(F1d,10);
% F1=F1+N1;
% F1d=F1d+N2;

%Computing the FFT of signal and its derivatives .

X=fft(F1);
Y=fft(F1d);


X_mag=abs(X);
Y_mag=abs(Y);

X_im=imag(X);
Y_im=imag(Y);


%Extracting the real and imaginary parts.
Xr=real(X);
Yr=real(Y);

Xi=imag(X);
Yi=imag(Y);

%Defining the group delay . 
gamma=0.7;
magsq=(X_mag.*X_mag);
smag=smooth(magsq,30);
smagt=smag';
sgm=power(magsq,gamma);
sgma=sgm';

Gpd=(Xr.*Yr+ Xi.*Yi)./magsq;
Ngd=(Xr.*Yr+ Xi.*Yi);
SGpd=(Xr.*Yr+ Xi.*Yi)./smagt;
PSgpd=(Xr.*Yr+ Xi.*Yi)./smagt;
alpha=0.7;
mgpd=power(abs(PSgpd),1-alpha);
FinalPgd=PSgpd.*mgpd;

%%Gpd=smooth(Gpd);

%Plotting 
figure
subplot(5,1,1)
plot(F1)
title('Speech Signal Time Domain ');


subplot(5,1,2)
plot(abs(fft(F1)))
title('FFT of Speech Signal F1');

subplot(5,1,3)
plot(SGpd)
title('Smoothened Group Delay Signal');

subplot(5,1,4)
plot(power(abs(Ngd),0.5))
title('NGD Signal');

subplot(5,1,5)
plot(FinalPgd)
title('Smoothed & Gamma * Alpha powered Group Delay Signal');

