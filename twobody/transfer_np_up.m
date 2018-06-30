function dv=transfer_np_up(v0,f0,p0,p1,mu)
%%    提升近地点
a20=f0+p0;
a21=f0+p1;
eg0=a2energy(a20/2,mu);
eg1=a2energy(a21/2,mu);
denergy=eg1-eg0;%动能改变
v1=sqrt(v0^2+2*denergy);
dv=v1-v0;
end