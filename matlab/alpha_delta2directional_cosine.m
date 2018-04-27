function dcvec=alpha_delta2directional_cosine(alpha,delta)
%% 功能： 由赤经,赤纬求方向余弦
%% 调用： dcvec=alpha_delta2directional_cosine(alpha,delta);
%% 输入：
%       alpha:赤经
%       delta:赤纬
%% 输出：
%       dcvec=[x;y;z] 三个方向余弦
%% 测试：已通过
%         命令: norm(alpha_delta2directional_cosine(pi/3,pi/4));
%         结果: 1
%%
dcvec=[cos(delta)*cos(alpha);cos(delta)*sin(alpha);sin(delta)];
end