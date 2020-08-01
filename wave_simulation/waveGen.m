function [el] = waveGen(S,w,x,t)
% S is the wave spectrum
% w is the list of angular frequencies, for example: w=0.01:0.01:4.
% x is the location of wave from the origin
% t is the current time

persistent Ph                  % random angle phase should be 
if isempty(Ph)                 % defined only one time
    N=length(w);
    Ph=rand(1,N)*2*pi;         % random angle phases   
end

dw=w(2)-w(1);
g=9.81;
k=w.^2./g;
A=sqrt(2*S*dw);       % magnitude of wave

el=sum(A.*sin(w.* t-k.*x+Ph));
% el=A(i)*sin(w(i)*t-k(i)*x+Ph);

end