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
%Isyarat Carrier
%sanity check
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

%USB Filter

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


%Transmission line rg-59 55Mhz Coded as Cable1
%zin=33 2.5k/10m pakai 5km
cable1_lenght=5e3;%spec b dengan 20km kabel
attenuation1=6.4/100;%atenuasi kabel yang dipakai(dB/m)
cable1_loss=attenuation1*cable1_lenght;
gamma1=abs((33-50)/(33+50));%almost 1:5
gamma1_db=10*log10(1/1-(abs(gamma1)^2));
total_loss_line1=10^((-1)*(cable1_loss+gamma1_db)/10);
%Transmission line

%Transmission line rg-6 55Mhz coded as cable2
%zin=30 5k/10m pakai 5km
cable2_lenght=5e3;%spec b dengan 20km kabel
attenuation2=5.25/100;%atenuasi kabel yang dipakai(dB/m)
cable2_loss=attenuation2*cable2_lenght;
gamma2=abs((30-50)/(30+50));%1:4
gamma2_db=10*log10(1/1-(abs(gamma2)^2));
total_loss_line2=10^((-1)*(cable2_loss+gamma2_db)/10);
%Transmission line

%Transmission line Rg-11 55Mhz coded as cable 3
%zin=25 8k/10m pakai 10km
cable3_lenght=10e3;%spec b dengan 20km kabel
attenuation3=3.18/100;%atenuasi kabel yang dipakai(dB/m)
cable3_loss=attenuation3*cable3_lenght;
gamma3=abs((25-50)/(25+50));%1:3
gamma3_db=10*log10(1/1-(abs(gamma3)^2));
total_loss_line3=10^((-1)*(cable3_loss+gamma3_db)/10);
%Transmission line
transmission_loss=total_loss_line1+total_loss_line2+total_loss_line3;

%proses SSB
[b,a]=butter(2,(1/60),'high');
signal_ssb=filter(b,a,modulated);
ssb_fft = fftshift(fft(signal_ssb));
ssb_fft = abs(2*ssb_fft)./L;
%plot modulasi ssb
figure
plot(t,signal_ssb)
title('SSB Modulated - Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
figure();
plot(f,ssb_fft);
title('SSB Modulated-Freq');
xlabel('Freq');
ylabel('Magnitude');
xlim([0,100])


%proses transmisi
transmission=transmission_loss*signal_ssb;
capture=transmission.*carrier;

capture_fft = fftshift(fft(capture));
capture_fft = abs(2*capture_fft)./L;
%plot transmisi ssb
figure
plot(t,capture)
title('received - Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
figure();
plot(f,capture_fft);
title('received-Freq');
xlabel('Freq');
ylabel('Magnitude');
xlim([0,100])

%demod process

[b,a]=butter(2,(1/50),'low');
demod_res=filter(b,a,capture);

demod_fft = fftshift(fft(demod_res));
demod_fft = abs(2*demod_fft)./L;
%plot transmisi ssb
figure
plot(t,demod_res)
title('recovered - Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
figure();
plot(f,demod_fft);
title('recovered-Freq');
xlabel('Freq');
ylabel('Magnitude');
xlim([0,100])