function [r1,v1,E]=rv2rv(rvec,vvec,dt,mu)
 [alpha,sgm0,r0,E0]=rv2_alpha_sgm_r02(rvec,vvec,mu);
 dM=sqrt(mu*alpha^3)*dt;
 dE=kepler_solver_ellipse2(dM,sgm0,alpha,r0);
[F,G,Ft,Gt]=alpha_sgm2FG2(alpha,sgm0,r0,mu,dE);
r1=F*rvec+G*vvec;
v1=Ft*rvec+Gt*vvec;
E=E0+dE;
end

function [alpha,sgm0,r0,E,M,e,f]=rv2_alpha_sgm_r02(r0vec,v0vec,mu)
%% 功能：根据活力公式 和 相关定义 求 alpha=1/a,sgm,r0,n
%% 调用：[alpha,sgm,r0,n]=rv2_alpha_sgm_r0(r0vec,v0vec,mu);
%% 输入：
% r0vec: 地心惯性系位置
% v0vec: 地心惯性系速度
% mu: 地球引力常数
%% 输出:
% alpha: 半长轴的倒数
% sgm: r0vec*v0vec/sqrt(mu)
% r0: norm(r0vec)
% n: 平均角速度
%% 测试: 已通过
% r0vec=[4330.155;6245.241;4387.607]*1000;
% v0vec=[-5670.051;1686.977;3524.511];
% mu=398600500000000;
% [a,s,r0,n]=rv2_alpha_sgm_r0(r0vec,v0vec,mu);
%%
r0=norm(r0vec);
alpha=2/r0-dot(v0vec,v0vec)/mu;
rr1=dot(r0vec,v0vec);
sgm0=rr1/sqrt(mu);
h=norm(cross(r0vec,v0vec));
p=h^2/mu;
e=sqrt(1-p*alpha);
ecosf=(p/r0-1);
esinf=rr1/h*(1+ecosf);
f=atan2(esinf,ecosf);
ecosE=(e^2+ecosf)/(1+ecosf);
esinE=sqrt(1-e^2)*esinf/(1+esinf);
E=atan2(esinE,ecosE);
E=fitinterval(E,2*pi,0,2*pi);
M=E-esinE;
% n=sqrt(mu*alpha^3);
end
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

function dE=kepler_solver_ellipse2(dM,sgm0,alpha,r0)
%% 功能：求解椭圆开普勒方程
%% 调用：E=kepler_solver_ellipse(M,e); % subject to: M>0 and 0<=e<1
%% 输入：75
%     M:平近点角
%     e:偏心率 [0,1)
%% 输出：
%       E:偏近点角
%% 测试：通过
%       E=kepler_solver_ellipse(pi/2,0.2);
%       E-0.2*sin(E)-pi/2;
eps=1e-17;
dE0=dM;
fx=dE0+sgm0*sqrt(alpha)*(1-cos(dE0))-(1-r0*alpha)*sin(dE0)-dM;
fdx=1-sgm0*sqrt(alpha)*sin(dE0)-(1-r0*alpha)*cos(dE0);
dE=dE0-fx/fdx;
for i=1:200
    if(abs(dE-dE0)<eps)
        break;
    else
        dE0=dE;
       fx=dE0+sgm0*sqrt(alpha)*(1-cos(dE0))-(1-r0*alpha)*sin(dE0)-dM;
       fdx=1-sgm0*sqrt(alpha)*sin(dE0)-(1-r0*alpha)*cos(dE0);
       dE=dE0-fx/fdx;
    end
end
end