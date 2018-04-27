function X1=improved_laplace_repeat(n,X0,RHOs,Bs,DTs,c)
%% 改进拉普拉斯法的一次迭代
%% RHOs 是方向余弦
%% Bs 是方程右边
rvec0=X0(1:3,:);
vvec0=X0(4:6,:);
A1s=zeros(n,6);
A2s=zeros(n,6);
[alpha0,sgm0,r0]=rv2_alpha_sgm_r0(rvec0,vvec0,1);
for i=1:n
    dt=DTs(i);
    roui=RHOs(:,i);
    [F0,G0]=alpha_sgm2FG(alpha0,sgm0,r0,dt,1,1e-14);
    A1s(i,:)=[F0*roui(2),-F0*roui(1),0,G0*roui(2),-G0*roui(1),0];
    A2s(i,:)=[0,F0*roui(3),-F0*roui(2),0,G0*roui(3),-G0*roui(2)];
end
As=[A1s;A2s];
AS=As.'*As;
BS=As.'*Bs;
X1=(AS+eye(6)*c)\(BS+c*X0);
end