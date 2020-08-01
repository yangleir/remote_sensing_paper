function [S] = waveSpectrum2d(Vwind,w,phi,n)
% Vwind is the wind speed at height 19.4 m
% w is the list of angular frequencies, for example: w=0.01:0.01:4.
% phi is the wave propagation angle list relative to the x-axis, e.g., phi=-pi:0.01:pi
% n: n=2 or n=4

g=9.81;
A=8.1e-3*g^2;
B=0.74*(g/Vwind)^4;
S0=A*w.^(-5).*exp(-B./(w.^4));

if(n~=2 && n~=4)
   error('n must be 2 or 4');
end
if(n==2)
   An=2/pi;
elseif(n==4)
   An=8/(3*pi);
end
f=An*cos(phi).^n.*(abs(phi) < pi/2);
if(iscolumn(S0)==0)
   S0=S0';
end
if(isrow(f)==0)
   f=f';
end
S=kron(S0,f);
end