function u=alphaX2u(alpha,X,err)
%% 功能： 由 alpha，X 求变量u
%% 调用： u=alphaX2u(alpha,X,err);% 要求 0<Y<2.46740110027,Y=alpha*(0.5*X)^2
%% 输入：
%      alpha: 半长轴的倒数
%         X:    普适变量
%        err:   误差要求
%%  输出：
%       u：参量，由一个连分数定义
%%  测试：已通过 
%%  注意：该连分数有收敛范围 Y=alpha*(0.5*X)^2 太大会导致不收敛
tmp1=alpha*(0.5*X)^2;
dr0=1.0;
u0=0.5*X;
s0=u0;
b0=1;
b1=3;
dr1=1/(1-tmp1*dr0/(b0*b1));
u1=u0*(dr1-1);
s1=s0+u1;
for i=1:100
    if(abs(u1)<err)
        break;
    else
        dr0=dr1;
        b0=b1;
        u0=u1;
        s0=s1;
        b1=b1+2;
        dr1=1/(1-tmp1*dr0/(b0*b1));
        u1=u0*(dr1-1);
        s1=s0+u1;
    end
end
if(abs(u1)<err)
    u=s1;
else
     error('alphaX2u:input_unexpected',...
       'Error:input_out_of_convergence_domain: \n  alpha*(0.5*X)^2 may be too big now it=%s, try a small one', alpha*(0.5*X)^2)
end
end