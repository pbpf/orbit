function trm=transm_Z(gamma)
%% 功能：生成ZYX坐标转换矩阵
%% 调用：trm=transm_Z(gamma)
%         subject to XA=trm*XB;
%         即对于 B系分别绕自身Z轴转动 gamma角得到的 A系
%         则同一矢量x,在A,B下的坐标满足：XA=trm*XB;
%%
trm=[cos(gamma),sin(gamma),0;-sin(gamma),cos(gamma),0;0,0,1;];
end