Fs = 1/mean(diff(t));                                               % Sampling Frequency
L = numel(t);                                                       % Signal Length
Fn = Fs/2;                                                          % Nyquist Frequency
Wp = 0.05/Fn;                                                       % Passband Frequency (Normalised)
Ws = 0.06/Fn;                                                       % Stopband Frequency (Normalised)
Rp =  1;                                                            % Passband Ripple
Rs = 60;                                                            % Passband Ripple (Attenuation)
[n,Wp] = ellipord(Wp,Ws,Rp,Rs);                                     % Elliptic Order Calculation
[z,p,k] = ellip(n,Rp,Rs,Wp,'low');                                  % Elliptic Filter Design: Zero-Pole-Gain 
[sos,g] = zp2sos(z,p,k);                                            % Second-Order Section For Stability

figure
freqz(sos, 2^16, Fs)                                                % Filter Bode Plot

signal_filt = filtfilt(sos, g, signal);                             % Filter Signal