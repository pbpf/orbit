function vvec1=transferdv(vvec0,dv)
%% 平行变轨
v0=norm(vvec0);
vvec1=vvec0*(v0+dv)/v0;%%乘以一个系数即可
end