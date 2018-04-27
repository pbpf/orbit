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
