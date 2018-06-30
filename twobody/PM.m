function [dv,dt]=PM(N,phi,a,mu)
n0=a2n(a,mu);%%标准周期
T1=(2*pi-(phi/N))/n0;
a1=T2a(T1,mu);
dt=T1*N;
eg=a2energy(a,mu);
v0=r2v(a,eg,mu);
dv=transfer_np_up(v0,a,a,2*a1-a,mu);
end