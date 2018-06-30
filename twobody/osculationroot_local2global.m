function transm=osculationroot_local2global(omg,i,w)
%% 功能：由密切轨道要素求 近心点轨道坐标系 到 惯性坐标系 的转换矩阵
%% 调用：transm=osculationroot_local2global(omg,i,w1);
%% 输入：
%       omg:升交点赤经
%         i:轨道倾角
%        w: 即w 近心点角距
%% 输出：
%    transm:转换矩阵 即 global_coordinate=local_coordinate*transmatrix;
%    即 同一矢量在近心点轨道坐标系 中的表示 xB与它在惯性坐标系中的表示xA 满足
%       xA=transm*xB;
%% 测试： 待完成 
transm=transm_Z(-omg)*transm_X(-i)*transm_Z(-w);
end

function trm=transm_Z(gamma)
%% 功能：生成ZYX坐标转换矩阵
%% 调用：trm=transm_Z(gamma)
%         subject to XA=trm*XB;
%         即对于 B系分别绕自身Z轴转动 gamma角得到的 A系
%         则同一矢量x,在A,B下的坐标满足：XA=trm*XB;
%%
trm=[cos(gamma),sin(gamma),0;-sin(gamma),cos(gamma),0;0,0,1;];
end

function trm=transm_Y(beta)
%% 功能：生成ZYX坐标转换矩阵
%% 调用：trm=transm_Y(beta)：
%         subject to XA=trm*XB;
%         即对于 B系分别绕自身Y轴转动 beta角得到的 A系
%         则同一矢量x,在A,B下的坐标满足：XA=trm*XB;
%%
trm=[cos(beta),0,-sin(beta);0,1,0;sin(beta),0,cos(beta);];
end

function trm=transm_X(alpha)
%% 功能：生成ZYX坐标转换矩阵
%% 调用：trm=transm(alpha,beta,gamma);
%         subject to XA=trm*XB;
%         即对于 B系分别绕自身X轴转动 alpha角得到的 A系
%         则同一矢量x,在A,B下的坐标满足：XA=trm*XB;
%%
trm=[1,0,0;0,cos(alpha),sin(alpha);0,-sin(alpha),cos(alpha);];
end