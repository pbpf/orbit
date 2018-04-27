function s=hypergeom_slocal(z)
%% 功能： 计算超几何函数 F(3,1;5/2;z)
%% 测试：pass
%       hypergeom([3,1],5/2,0.7)-hypergeom_slocal(0.7);
err=1e-10;
d0=1;
u0=1;
s0=1;
y1=6/5;
y2=-2/35;
d1=1/(1-y1*z*d0);
u1=u0*(d1-1);
% disp(s0+u1);
d2=1/(1-y2*z*d1);
u2=u1*(d2-1);
s2=s0+u1+u2;
% disp(s2);
for n=3:2:103
%     disp(s2);
    if(abs(u2)<err)
        break;
    else
        d0=d2;
        s0=s2;
        u0=u2;
        y1=(n+2)*(n+5)/((2*n+1)*(2*n+3));
        n1=n+1;
        y2=n1*(n1-3)/((2*n1+1)*(2*n1+3));
        d1=1/(1-y1*z*d0);
        u1=u0*(d1-1);
        d2=1/(1-y2*z*d1);
        u2=u1*(d2-1);
        s2=s0+u1+u2;
    end
end
s=s2;
end
        