function [F,G]=alpha_sgm2FG(alpha,sgm0,r,dt,mu,err)
%% 功能：由alpha，sgm0，r,dt计算 拉格朗日系数F，G
%% 调用：[F,G]=alpha_sgm2FG(alpha,sgm0,r,dt,mu,err);
%% 输入：
%      alpha: 半长轴的倒数
%      sgm0: r0vec*v0vec/sqrt(mu)
%      r: norm(r0vec)
%      dt: 时间间隔
%      mu: 地球引力常数
%      err:要求的误差
%% 输出：
%     拉格朗日系数 F,G
%% 测试:通过
%% 迭代 解广义开普勒方程 
X=kepler_newton_solver(alpha,sgm0,r,dt,mu,err/10);
%% 由连分数计算参数u
u=alphaX2u(alpha,X,err/10);
%% 计算普适函数的值
U1=2*u/(1+alpha*u^2);
U2=2*u^2/(1+alpha*u^2);
%% 计算拉格朗日系数 F,G
F=1-U2/r;
G=r*U1/sqrt(mu)+sgm0*U2/sqrt(mu);
end