function E=kepler_solver_ellipse(M,e)
%% 功能：求解椭圆开普勒方程
%% 调用：E=kepler_solver_ellipse(M,e); subject to: M>0 and 0<=e<1
%% 输入：
%     M:平近点角
%     e:偏心率 [0,1)
%% 输出：
%       E:偏近点角
%% 测试：pass
%       E=kepler_solver_ellipse(pi/2,0.2);
%       E-0.2*sin(E)-pi/2;
err=1;
E0=M;
E=E0-(E0-e*sin(E0)-M)/(1-e*cos(E0));
for i=1:100
    if(abs(E-E0)<err)
        break;
    else
        E0=E;
        E=E0-(E0-e*sin(E0)-M)/(1-e*cos(E0));
    end
end
end
