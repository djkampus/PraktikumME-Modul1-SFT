%persiapan
Fs=1;%sampling frequency
T=1/Fs;%sampling period
t=(0:L-1)*T;
f1=10000;
f2=11000;
N=1000;%jumlah deret impuls
n=(0:N-1);
L=200;%signal lenght(time observation)
P=2*sin(2*pi*0.2*t);%sinewave generator
P_fft=fft(P);%fourier transform(automatic module)
P_fft_magnitude=abs(P_fft)./L;
%m(t)=[];%sinyal informasi
%c(t)=[];%sinyal carrier
theta1=(2*pi*f1)/Fs;
theta2=(2*pi*f2)/Fs;
%persiapan
%USB Filter
%usb_left=(theta2/pi)*sinc((theta2(n-0.5*N)/pi));
%usb_right=(theta1/pi)*sinc((theta1(n-0.5*N)/pi));
%h(n)=usb_left-usb_right;
%USB Filter
%Amplifier1
%Amplifier1
%Transmission line
cable_lenght=20e3;
attenuation=1/100;%atenuasi kabel yang dipakai(dB/m)
cable_loss=attenuation*cable_lenght;
gamma=1;%belum siap refrection coef
gamma_db=10*log10(1/1-(abs(gamma)^2));
total_loss_line=10^((-1)*(cable_loss+gamma_db)/10);
%Transmission line
%Amplifier2
%Amplifier2