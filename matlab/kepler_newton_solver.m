function X=kepler_newton_solver(alpha,sgm0,r0,dt,mu,err)
%% 功能： 牛顿迭代 解广义开普勒方程
%% 调用：X=kepler_newton_solver(alpha,sgm0,r0,dt,mu,err);
%% 输入：
%      alpha: 半长轴的倒数
%      sgm0: r0vec*v0vec/sqrt(mu)
%      r: norm(r0vec)
%      dt: 时间间隔
%      mu: 地球引力常数
%      err:要求的误差
%% 输出：
%       X：普适变量
%% 测试：通过
%% 注意：调用了可能不收敛的计算 alphaX2u
X0=sqrt(mu)*dt/r0;%选取初值
u=alphaX2u(alpha,X0,err/10);
U0=(1-alpha*u)/(1+alpha*u^2);
U1=2*u/(1+alpha*u^2);
U2=2*u^2/(1+alpha*u^2);
U3=(X0-U1)/alpha;
X1=X0-(r0*U1+sgm0*U2+U3-sqrt(mu)*dt)/(r0*U0+sgm0*U1+U2);
for i=1:100
    if(abs(X1-X0)<err)
        break;
    else
        X0=X1;
        u=alphaX2u(alpha,X0,err/10);
        U0=(1-alpha*u)/(1+alpha*u^2);
        U1=2*u/(1+alpha*u^2);
        U2=2*u^2/(1+alpha*u^2);
        U3=(X0-U1)/alpha;
        X1=X0-(r0*U1+sgm0*U2+U3-sqrt(mu)*dt)/(r0*U0+sgm0*U1+U2);
    end
end
X=X1;
end