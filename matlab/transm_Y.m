function trm=transm_Y(beta)
%% 功能：生成ZYX坐标转换矩阵
%% 调用：trm=transm_Y(beta)：
%         subject to XA=trm*XB;
%         即对于 B系分别绕自身Y轴转动 beta角得到的 A系
%         则同一矢量x,在A,B下的坐标满足：XA=trm*XB;
%%
trm=[cos(beta),0,-sin(beta);0,1,0;sin(beta),0,cos(beta);];
end