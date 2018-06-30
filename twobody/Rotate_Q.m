function v_q = Rotate_Q( v, q )
% 功能：将矢量 v按四元数 q旋转得到v_q
%       v_q = q 。v 。q* = [q] * [q*] * v
% 输入：
%       v是初始向量；
%       q是旋转四元数
% 输出：
%       v_q是旋转后得到的四元数
q0    =    q(1);                    %
q1    =    q(2);                    %
q2    =    q(3);                    %
q3    =    q(4);                    %

p0    =    q(1);                    %求q的共轭四元数p
p1    =   -q(2);                    %
p2    =   -q(3);                    %
p3    =   -q(4);                    %得到q的共轭四元数p

    v_pre     =   [ 0, v(1),v(2),v(3) ]';
    M_Q_bn    =   [ q0, -q1, -q2, -q3;
                    q1,  q0, -q3,  q2;
                    q2,  q3,  q0, -q1;
                    q3, -q2,  q1,  q0];
                
M_Q_bn_star   =   [ p0, -p1, -p2, -p3;
                    p1,  p0,  p3, -p2;
                    p2, -p3,  p0,  p1;
                    p3,  p2, -p1,  p0];

    v_q4      =   M_Q_bn * (M_Q_bn_star * v_pre);
     
    v_q       =   [v_q4(2); v_q4(3); v_q4(4)];
end