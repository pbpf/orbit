function Q=quater_axis(axis,ang)
%% 产生绕轴（右手）转动4元数
half=ang/2;
shalf=sin(half);
axis=axis/norm(axis);
Q=[cos(half);shalf*axis];
end