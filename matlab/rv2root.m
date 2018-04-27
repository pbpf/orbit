function [a,e,i,omg,w,f]=rv2root(rvec,vvec,mu)
%% 功能：由位置，速度计算经典轨道根数
%% 调用：[a,e,i,omg,w,f]=rv2root(rvec,vvec,mu);
%% 输入：
%     rvec:位置
%     vvec:速度
%     mu:地心万有引力常量
%% 输出：
%   a,e,i,omg,w,f：经典轨道根数
%% 测试：通过不严格测试
 hvec=cross(rvec,vvec);
 h=norm(hvec);
 evec=cross(vvec,hvec)/mu-rvec/norm(rvec);
 e=norm(evec);
 a=h^2/(mu*(1-e^2));
 i=acos(hvec(3)/h);
 omg=atan2(hvec(1),-hvec(2));%%%
 omg=fitinterval(omg,2*pi,0,2*pi);
 w=atan2(evec(3),(sin(i)*(evec(2)*sin(omg)+evec(1)*cos(omg))));%%%
 w=fitinterval(w,2*pi,0,2*pi);
 u=fitinterval(atan2(rvec(3),(sin(i)*(rvec(2)*sin(omg)+rvec(1)*cos(omg)))),2*pi,0,2*pi);%%%
 f=u-w;
 f=fitinterval(f,2*pi,0,2*pi)*180/pi;
 omg=omg*180/pi;
 w=w*180/pi;
 i=i*180/pi;
end