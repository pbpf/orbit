function transm=osculationroot_local2global(omg,i,w1)
%% 功能：由密切轨道要素求 近心点轨道坐标系 到 惯性坐标系 的转换矩阵
%% 调用：transm=osculationroot_local2global(omg,i,w1);
%% 输入：
%       omg:升交点黄经
%         i:轨道倾角
%        w1: 即omg+w 近心点黄经
%% 输出：
%    transm:转换矩阵 即 global_coordinate=local_coordinate*transmatrix;
%    即 同一矢量在近心点轨道坐标系 中的表示 xB与它在惯性坐标系中的表示xA 满足
%       xA=transm*xB;
%% 测试： 待完成 
w=w1-omg;
transm=transm_Z(-omg)*transm_X(-i)*transm_Z(-w);
end
