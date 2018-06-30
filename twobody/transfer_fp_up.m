function dv=transfer_fp_up(v0,p0,f0,f1,mu)
%%    提升远地点
%   ;v0 近地点速度
%   ;p0 近地点距离
%   ;f0 远地点距离
%   ;f1 变轨后的远地点距离
%   ;mu 中心引力常数
a20=p0+f0;
a21=p0+f1;
eg0=a2energy(a20/2,mu);
eg1=a2energy(a21/2,mu);
denergy=eg1-eg0;%动能改变
v1=sqrt(v0^2+2*denergy);
dv=v1-v0;
end