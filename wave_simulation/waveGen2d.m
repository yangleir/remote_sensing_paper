function [el] = waveGen2d(S,w,phi,x,y,t)
% S is the wave spectrum
% w is the list of angular frequencies, for example: w=0.01:0.01:4.
% phi is the wave propagation angle relative to the x-axis
% x, y are the location of wave from the origin
% t is the current time

persistent Ph                  % random angle phase should be 
if isempty(Ph)                 % defined only one time
    M=length(w);
    N=length(phi);
    Ph=rand(M,N)*2*pi;         % random angle phases   
end

dw=w(2)-w(1);
dphi=phi(2)-phi(1);
g=9.81;
k=w.^2./g;
A=sqrt(2*S*dw*dphi);             % magnitude of wave
el=0;
% A=sqrt(2*S*dw);    
for i=1:length(w)
   el=el+sum(A(i,:).*sin(w(i)*t+k(i)*(x*cos(phi)+y*sin(phi))+Ph(i,:)));
%    disp (i)
%    el=el+sum(A(i,:).*sin(w(i)*t+k(i)*(x*1+y*0)+Ph(i,:)));
end
end