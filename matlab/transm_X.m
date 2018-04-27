function trm=transm_X(alpha)
%% 功能：生成ZYX坐标转换矩阵
%% 调用：trm=transm(alpha,beta,gamma);
%         subject to XA=trm*XB;
%         即对于 B系分别绕自身X轴转动 alpha角得到的 A系
%         则同一矢量x,在A,B下的坐标满足：XA=trm*XB;
%%
trm=[1,0,0;0,cos(alpha),sin(alpha);0,-sin(alpha),cos(alpha);];
end