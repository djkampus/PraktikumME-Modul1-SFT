f_work=5e6;
fs = 2*f_work; % Sampling frequency (samples per second) 
 dt = 1/fs; % seconds per sample 
 StopTime = 10; % seconds 
 t = (0:dt:StopTime)'; % seconds 
 F = f_work; % Sine wave frequency (hertz) 
 data = sin(2*pi*F*t);
 plot(t,data)
 %%For one cycle get time period
 T = 1/F ;
 % time step for one time period 
 tt = 0:dt:T+dt ;
 d = sin(2*pi*F*tt) ;
 plot(tt,d) ;