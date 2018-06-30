function vvec1=transferflatdv(vvec0,rvec0,beta)
%% 改变轨道面的变轨
%   ;Theta 变轨点到当地速度倾角，向远离地心为正
%   ;beta  轨道面转角
% 即速度绕rvec0 转动beta角
% v0=norm(vvec0);
% vvec1=vvec0*(v0+dv)/v0;%%乘以一个系数即可
Q=quater_axis(rvec0,beta);%%转动四元数
vvec1=Rotate_Q(vvec0, Q);
end