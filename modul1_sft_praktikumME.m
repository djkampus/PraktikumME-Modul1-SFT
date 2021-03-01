%persiapan signal generation
f_work=8e6;%frekuensi isyarat informasi
%f_carrier=55e6;%frekuensi carrier
power=15;%power kerja
Fs=2*f_work;%sampling frequency
T=1/Fs;%sampling period
L=200;%signal lenght(time observation)
t=(0:L-1)*T;%time vector
N=1000;%jumlah deret impuls
n=(0:N-1);
P=power.*sin(2*pi*f_work.*t);%sinewave generator
P_fft=fft(P);%fourier transform(automatic module)
P_fft_magnitude=abs(P_fft)./L;
figure(1)
plot(t,P)
%persiapan
%signal carrier
%signal carrier
%USB Filter
%f1=10000;
%f2=11000;
%theta1=(2*pi*f1)/Fs;
%theta2=(2*pi*f2)/Fs;
%usb_left=(theta2/pi)*sinc((theta2(n-0.5*N)/pi));
%usb_right=(theta1/pi)*sinc((theta1(n-0.5*N)/pi));
%h(n)=usb_left-usb_right;
%USB Filter
%Amplifier1
%Amplifier1
%Transmission line rg-59 55Mhz Coded as Cable1
cable1_lenght=20e3;%spec b dengan 20km kabel
attenuation1=6.4/100;%atenuasi kabel yang dipakai(dB/m)
cable1_loss=attenuation1*cable1_lenght;
gamma1=1;%belum siap refrection coef
gamma1_db=10*log10(1/1-(abs(gamma1)^2));
total_loss_line1=10^((-1)*(cable1_loss+gamma1_db)/10);
%Transmission line

%Transmission line rg-6 55Mhz coded as cable2
cable2_lenght=20e3;%spec b dengan 20km kabel
attenuation2=5.25/100;%atenuasi kabel yang dipakai(dB/m)
cable2_loss=attenuation*cable2_lenght;
gamma2=1;%belum siap refrection coef
gamma2_db=10*log10(1/1-(abs(gamma2)^2));
total_loss_line2=10^((-1)*(cable2_loss+gamma2_db)/10);
%Transmission line

%Transmission line Rg-11 55Mhz coded as cable 3
cable3_lenght=20e3;%spec b dengan 20km kabel
attenuation3=1/100;%atenuasi kabel yang dipakai(dB/m)
cable3_loss=attenuation3*cable3_lenght;
gamma3=1;%belum siap refrection coef
gamma3_db=10*log10(1/1-(abs(gamma3)^2));
total_loss_line3=10^((-1)*(cable3_loss+gamma3_db)/10);
%Transmission line

%lowpass filter
%lowpass filter
%Amplifier2
%Amplifier2