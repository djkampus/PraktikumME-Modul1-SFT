%persiapan
m(t)=[];%sinyal informasi
c(t)=[];%sinyal carrier
theta1=(2*pi*f1)/sampling_freq;
theta2=(2*pi*f2)/sampling_freq;
N=1;%jumlah deret impuls
%persiapan
%USB Filter
usb_left=(theta2/pi)*sinc((theta2(n-0.5*N)/pi));
usb_right=(theta1/pi)*sinc((theta1(n-0.5*N)/pi));
h(n)=usb_left-usb_right;
%USB Filter
%Amplifier1
%Amplifier1
%Transmission line
attenuation=1;%atenuasi kabel yang dipakai
cable_loss=attenuation*cable_lenght;
gamma=1;%belum siap refrection coef
gamma_db=10*log10*(1/1-(abs(gamma)^2));
total_loss_line(10^((cable_loss+gamma_db)/10);
%Transmission line
%Amplifier2
%Amplifier2