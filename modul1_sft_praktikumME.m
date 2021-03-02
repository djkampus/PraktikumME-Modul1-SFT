%persiapan signal generation sinyal info 8 Mhz
f_message=8;
fs=1000;%untuk frekuensi sampling
t = (0:1/fs:1-1/fs);
message=sin(2*pi*f_message.*t);
%%%plottingan time domain
figure(1)
plot (t,message)
title('message in Time Domain');
xlabel('time')
ylabel('Amplitude')
%%%plot

%ubah message menjadi frequency domain
L = length(message);%cari jumlah entri dari sinyal untuk fft proses
P_fft_single = fftshift(fft(message));%sinyal yang ingin di fft-kan
P_fft_single = P_fft_single(L/2+1:end);
P_fft_single = abs(2*P_fft_single)./L;
df = fs/L;
f = -fs/2:df:fs/2-df;
f = f(L/2+1:end)';
figure(2)
plot(f, P_fft_single);
xlim([0, 100])
title('Message Signal - Freq Domain');
xlabel('freq (MHz)')
ylabel('Magnitude (Watt)')
%persiapan signal info generator

%sinyal carrier dengan 55MHz 15watt sinus
f_carrier = 55;%sinyal carrier
power=15;
carrier = power.*sin(2*pi*f_carrier*t);
carrier_fft = fftshift(fft(carrier));
carrier_fft=carrier_fft((0.5*L)+1:end);
carrier_fft = abs(2*carrier_fft)./L;
df = fs/L;
f = -fs/2:df:fs/2-df;
f = f(L/2+1:end)';
figure();
plot(t, carrier);
title('Carrier Signal - Time Domain');
xlabel('time (s)')
ylabel('amplitude (Watt)')
figure();
plot(f, carrier_fft);
title('Carrier Signal - Freq Domain');
xlabel('freq (MHz)')
ylabel('Magnitude (Watt)')

%modulasi sinyal
modulated = message.*carrier;
modulated_fft = fftshift(fft(modulated));
modulated_fft = abs(2*modulated_fft)./L;
df = fs/L;
f = (-L/2:L/2-1)*(fs/L);
figure();
plot(t, modulated);
title('Modulated Signal - Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
figure();
plot(f, modulated_fft);
title('Modulated Signal - Frequency Domain');
xlabel('Freq (MHz)');
ylabel('Magnitude');
xlim([0, 100])

%hilbert algorith

h_message=imag(hilbert(message));
h_carrier=imag(hilbert(carrier));
ssb_upper=(message.*carrier)-(h_message.*h_carrier);
ssb_upper_fft = fftshift(fft(ssb_upper));
ssb_upper_fft = abs(2*ssb_upper_fft)./L;
plot(t,ssb_upper)
title('SSB Signal - Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
figure();
plot(f, ssb_upper_fft);
title('SSB Signal - Frequency Domain');
xlabel('Freq (MHz)');
ylabel('Magnitude');
xlim([0, 100])


%demodulasi ssb
%tangkap sinyal dan tambahkan carrier signal
capture=ssb_upper.*carrier;
capt_filter=lowpass(capture,50);

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

%usb filter

f1 = 52;
f2 = 100;
theta1 = (2*pi*f1)/fs;
theta2 = (2*pi*f2)/fs;
N = 10000;
n = (0:1:N-1);
hn = ((theta2/pi) .* sinc(((theta2).*(n-0.5*N))/pi) - (theta1/pi) .* sinc(((theta1).*(n-0.5*N))/pi));
hn = abs(fft(hn));
hn = hn(1:(0.5*N)+1);
axis_single=(0:N/2)*(fs/N);
figure();
plot(axis_single,hn);
title('USB Filter');
xlabel('frequency');
ylabel('filter gain');
xlim([0,100])

%low pass filter (ternyata buat aja f1=0)

f1_lp = 0;
f2_lp = 60;
theta1 = (2*pi*f1_lp)/fs;
theta2 = (2*pi*f2_lp)/fs;
N = 10000;
n = (0:1:N-1);
hn = ((theta2/pi) .* sinc(((theta2).*(n-0.5*N))/pi) - (theta1/pi) .* sinc(((theta1).*(n-0.5*N))/pi));
hn = abs(fft(hn));
hn = hn(1:(0.5*N)+1);
axis_single=(0:N/2)*(fs/N);
figure();
plot(axis_single,hn);
title('Lowpass Filter');
xlabel('frequency');
ylabel('filter gain');
xlim([0,100])

