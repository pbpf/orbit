function [F,G,Ft,Gt]=alpha_sgm2FG2(alpha,sgm0,r0,mu,dE)
%% 迭代 解 方程 
%% 测试 :pass
% disp('sgm=');
%  disp(sgm);%% -724.222867215414 near
a=1/alpha;
r=a+(r0-a)*cos(dE)+sgm0*sqrt(a)*sin(dE);
F=1-(a/r0)*(1-cos(dE));
G=a*sgm0/sqrt(mu)*(1-cos(dE))+r0*sqrt(a/mu)*sin(dE);
%r=r0+sgm0*U1+(1-alpha*r0)*U2;
Ft=-sqrt(mu*a)/(r*r0)*sin(dE);
Gt=1-a/r*(1-cos(dE));
end