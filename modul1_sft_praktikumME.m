%persiapan signal generation sinyal inf0 8 Mhz power 15W
f_work=8e6;
t_work=1/(2*f_work);%sampling period?
L=100;%time observation?
power=15;%daya pemancar
t=(0:L-1)*t_work;%time vector
si=power*sin(2*pi*f_work*t);%sine wave generator
si_fft=fft(si);
si_fft_magnitude=abs(si_fft)./t;
%plotting 1
figure(1);
plot(t,si_fft)
title('Time Domain')
xlabel('Time in sec')
ylabel('Amplitude(V or A)')

%persiapan signal generator
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
cable2_loss=attenuation2*cable2_lenght;
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