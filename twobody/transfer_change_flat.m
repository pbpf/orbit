function dv=transfer_change_flat(v0,Theta,beta)
%% 改变轨道面的变轨
%   ;v0 变轨点速度
%   ;Theta 变轨点到当地速度倾角，向远离地心为正
%   ;beta  轨道面转角
dv=2*v0*cos(Theta)*sin(beta/2);
end