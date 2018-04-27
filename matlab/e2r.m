function [rvec,vvec]=e2r(a,e,E,n)
%% 功能 由偏近点角计算位置和速度（近心点轨道坐标系）
%% 调用：rvec=e2r(a,e,E,n);
%% 输入：
%       a: 半长轴
%       e: 偏心率
%       E: 偏近点角
%       n:平均角速度
%% 输出：
%       rvec:位置矢量（近心点轨道坐标系）
%       vvec:速度矢量（近心点轨道坐标系）
b=a*sqrt(1-e^2);
x=a*cos(E)-a*e;
y=b*sin(E);%% 近心点轨道坐标系
rvec=[x;y;0];
vvec=[-a*sin(E)*n/(1-e*cos(E));b*cos(E)*n/(1-e*cos(E));0];
end