function [rvec,vvec,t]=gauss_solver(B,H,ae,ee,mu,data_m,err)
%% 功能: 高斯法求卫星的位置和速度
%% 调用: [rvec,vvec,t]=gauss_solver(B,H,ae,ee,mu,data_m,err);
%% 输入:
%     B：测站的大地纬度
%     H：测站高程
%     ae：地球半长轴
%     ee:偏心率
%     mu:地球引力常量
%     data_m(不少于3行)：    第一列 时间
%                           第二列 当地恒星时
%                           第三列 赤纬
%                           第四列 赤经
%                 err:   要求的误差
%% 输出：
%        rvec:卫星的位置
%        vvec:卫星的速度
%% 测试：通过 
%         命令: laplace_solver_test;
%
%% 时间间隔 pass
 w=0.7;
t1=data_m(1,1)-data_m(2,1);
t3=data_m(3,1)-data_m(2,1);
t=t3-t1;
% disp(t1);
% disp(t3);
%% 方向余弦 pass
rou10vec=alpha_delta2directional_cosine(data_m(1,4),data_m(1,3));
rou20vec=alpha_delta2directional_cosine(data_m(2,4),data_m(2,3));
rou30vec=alpha_delta2directional_cosine(data_m(3,4),data_m(3,3));
%% R 矩阵
R1vec=BHs2R(B,H,data_m(1,2),ae,ee);
R2vec=BHs2R(B,H,data_m(2,2),ae,ee);
R3vec=BHs2R(B,H,data_m(3,2),ae,ee);
R=[R1vec,R2vec,R3vec];
% disp(R2vec/ae);
%% rou0矩阵
rou0=[rou10vec,rou20vec,rou30vec];
D=rou0\R;
A=(D(2,1)*t3-D(2,2)*t-D(2,3)*t1)/t;
B=(D(2,1)*t3*(t^2-t3^2)-D(2,3)*t1*(t^2-t1^2))/(6*t);
a=-(A^2+2*A*dot(R2vec,rou20vec)+norm(R2vec)^2);
b=-2*mu*B*(A+dot(R2vec,rou20vec));
c=-mu^2*B^2;
%% 关于r2的方程 r2^8+A1*r2^6+B1*r2^3+C1=0;
f = @(r2) r2^8+a*r2^6+b*r2^3+c;
r2=fzero(f,ae);
%r21=newton_solver(f,f1,ae);
% disp(r2/ae);
% disp(r21);
% disp(f(r2));
%% c
u2=mu/r2^3;
F1=1-mu*t1^2/(2*r2^3);
F3=1-mu*t3^2/(2*r2^3);
G1=t1-mu*t1^3/(6*r2^3);
G3=t3-mu*t3^3/(6*r2^3);
c1=t3/t*(1+1/6*u2*(t^2-t3^3));
c3=-t1/t*(1+1/6*u2*(t^2-t1^2));
rou1=-D(1,1)+D(1,2)/c1-c3*D(1,3)/c1;
rou2=c1*D(2,1)-D(2,2)+c3*D(2,3);
rou3=-c1/c3*D(3,1)+D(3,2)/c3-D(3,3);
r1vec=rou1*rou10vec+R1vec;
r2vec=rou2*rou20vec+R2vec;
r3vec=rou3*rou30vec+R3vec;
v2vec=(F1*r3vec-F3*r1vec)/(F1*G3-F3*G1);
 [alpha0,sgm0,r0]=rv2_alpha_sgm_r0(r2vec,v2vec,mu);
 [F12,G12]=alpha_sgm2FG(alpha0,sgm0,r0,t1,mu,1e-17);
 [F32,G32]=alpha_sgm2FG(alpha0,sgm0,r0,t3,mu,1e-17);
 F1=w*F1+(1-w)*F12;
 F3=w*F3+(1-w)*F32;
G1=w*G1+(1-w)*G12;
G3=w*G3+(1-w)*G32;
c1=G3/(F1*G3-F3*G1);
c3=-G1/(F1*G3-F3*G1);
rou12=-D(1,1)+D(1,2)/c1-c3*D(1,3)/c1;
rou22=c1*D(2,1)-D(2,2)+c3*D(2,3);
rou32=-c1/c3*D(3,1)+D(3,2)/c3-D(3,3);
for i=1:500
    if(abs(rou22-rou2)<err)
        break;
    else
        rou1=rou12;
        rou2=rou22;
        rou3=rou32;
        r1vec=rou1*rou10vec+R1vec;
        r2vec=rou2*rou20vec+R2vec;
        r3vec=rou3*rou30vec+R3vec;
        v2vec=(F1*r3vec-F3*r1vec)/(F1*G3-F3*G1);
        [alpha0,sgm0,r0]=rv2_alpha_sgm_r0(r2vec,v2vec,mu);
        [F12,G12]=alpha_sgm2FG(alpha0,sgm0,r0,t1,mu,1e-17);
        [F32,G32]=alpha_sgm2FG(alpha0,sgm0,r0,t3,mu,1e-17);
        F1=w*F1+(1-w)*F12;
        F3=w*F3+(1-w)*F32;
        G1=w*G1+(1-w)*G12;
        G3=w*G3+(1-w)*G32;
        c1=G3/(F1*G3-F3*G1);
        c3=-G1/(F1*G3-F3*G1);
        rou12=-D(1,1)+D(1,2)/c1-c3*D(1,3)/c1;
        rou22=c1*D(2,1)-D(2,2)+c3*D(2,3);
        rou32=-c1/c3*D(3,1)+D(3,2)/c3-D(3,3);
    end
end
t=data_m(2,1);
rvec=r2vec;
vvec=v2vec;
end