% This program is to produce part results of paper "1. Yang, L.; Xu, Y.; Zhou, X.; Zhu, L.; Jiang, Q.; Sun, H.; Chen, G.; Wang, P.; Mertikas, S.P.; Fu, Y.; et al. Calibration of an Airborne Interferometric Radar Altimeter over the Qingdao Coast Sea, China. Remote Sensing 2020, 12, 1651, doi:10.3390/rs12101651."
% The main purpose is the simulation of ocean wave in one fixed point as
% the wavebuoy (time domain) and over one area as the air borne
% Interferometric radar altimeter (space domain). The space domain wave
% data will be output as Netcdf format.

% Leiyang@fio.org.cn

% First if the one-D wave simulation in time domain and could be seen as
% the wave buoy at one fixed location. The wave spectrum is P-M.

Vwind=4.09;              % wind speed at 4.09 m
% Vwind10=Vwind/1.085;
dw=0.01;                % the difference between successive frequencies
w=0.01:dw:4;            % angular frequencies
t=0:1:18000;         % simulation time
x=0;

N=length(t);
el=zeros(1,N);

S=waveSpectrum(Vwind,w); % generate the wave spectrum based on the input parameter.
figure (200);

% plot(w/2/pi,S*1e4*2*pi); % Be carefull the relationship between time frequency and angular frequency. It will affect the power specrum.
plot(w,S*1e4);
xlabel('frequency [rad/s]');
ylabel('wave spectrum [cm^2/s]');
grid on;
output=[1./(w'/2/pi),S']; % This is period 'T'.
save('psd_pm.txt','output','-ascii')

for i=1:N
    el(i)=waveGen(S,w,x,t(i)); % This is wave series in time domain.
end

disp("The SWH is:");
std(el)*4 % SWH

line_out = [t;el]';
save simu_wave_time_gnss.txt line_out -ascii

figure (1);subplot(2,1,1);
plot(t(1:500),el(1:500));
xlabel('time [s]');
ylabel('wave elevation [m]');
grid on;

%------------------
% wave in both x,y and time
clear;
Vwind=9;              % wind speed at 19.4 m
dw=0.2;                % the difference between successive frequencies
w=0.1:dw:3;            % angular frequencies
dphi=0.2;
phi=-pi:dphi:pi;

t=1:1:1;         % simulation time
x=-0:1:200;
y=0:1:200;
Nx=length(x);
Ny=length(y);

Nt=length(t);
el=zeros(Nx,Ny,Nt);

n=2;
S=waveSpectrum2d(Vwind,w,phi,n);

figure (200);
surf(w,phi,S');
xlabel('frequency [rad/s]');
ylabel('phi [rad]');
zlabel('spectrum [m/s^2]');
grid on;

for i=1:Nt
    for j=1:Nx
        for k=1:Ny
            el(j,k,i)=waveGen2d(S,w,phi,x(j),y(k),t(i));
        end
    end
end

figure (111);
surf(x,y,el(:,:,1)');shading interp ;
xlabel('x [m]');
ylabel('y [m]');
zlabel('wave elevation [m]');
grid on;

% output one track line of the 2-D wave
tmp=reshape(el(:,1,1),1,length(el));
figure (1);subplot(2,1,2); plot(tmp)
lati = linspace(0,length(tmp)*1,length(tmp))';
line_out = [lati,tmp'];
save simu_wave_space_new.txt line_out -ascii

%-----------------
% output grid 
nx=length(x);ny=length(y);
writegrid(x,y,el(:,:,1),'simu_wave.nc',nx,ny)

%----------------
% Please plot the 2-D Netcdf wave data using GMT shell in
% ../fig10_11/map.sh

