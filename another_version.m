%Isyarat Informasi
%clear variables
%close all;
P = 25;
fs = 200;
fm = 5;
t = (0:1/fs:1-1/fs);
mt = P*sin(2*pi*fm*t);
L = length(mt);
P_fft_single = fftshift(fft(mt));
P_fft_single = P_fft_single(L/2+1:end);
P_fft_single = abs(2*P_fft_single)./L;
df = fs/L;
f = -fs/2:df:fs/2-df;
f = f(L/2+1:end);
%axis_single=(0:L/2)*(fs/L);
figure();
plot(t, mt);
title('Info Signal - Time Domain');
xlabel('time (s)')
ylabel('amplitude (Watt)')
figure();
plot(f, P_fft_single);
xlim([0, 100])
title('Info Signal - Freq Domain');
xlabel('freq (MHz)')
ylabel('Magnitude (Watt)')

%Isyarat Carrier
fc = 50;
ct = sin(2*pi*fc*t);
xas = fftshift(fft(ct));
xas=xas((0.5*L)+1:end);
xas = abs(2*xas)./L;
df = fs/L;
f = -fs/2:df:fs/2-df;
f = f(L/2+1:end)';
figure();
plot(t, ct);
title('Carrier Signal - Time Domain');
xlabel('time (s)')
ylabel('amplitude (Watt)')
figure();
plot(f, xas);
title('Carrier Signal - Freq Domain');
xlabel('freq (MHz)')
ylabel('Magnitude (Watt)')
modulated = mt.*ct;
mk = fftshift(fft(modulated));
mk = abs(2*mk)./L;
df = fs/L;
f = (-L/2:L/2-1)*(fs/L);
figure();
plot(t, modulated);
title('Modulated Signal - Time Domain');
xlabel('Time (s)');
ylabel('Amplitude');
figure();
plot(f, mk);
title('Modulated Signal - Frequency Domain');
xlabel('Freq (MHz)');
ylabel('Magnitude');
xlim([0, 100])

%USB Filter
f1 = 52;
f2 = 100;
theta1 = (2*pi*f1)/fs;
theta2 = (2*pi*f2)/fs;
N = 1000;
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
