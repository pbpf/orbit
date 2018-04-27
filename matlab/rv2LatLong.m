function [al1,drt1]=rv2LatLong(r,v,dt,Ri)
%% 由rv反计算赤经赤纬
 [alpha,sgm0,r0]=rv2_alpha_sgm_r0(r,v,1);
 [F,G]=alpha_sgm2FG(alpha,sgm0,r0,dt,1,1e-15);
 r1=F*r+G*v;
 rou=r1-Ri;
 rou=rou/norm(rou);
 drt1=asin(rou(3));
 al1=fitinterval(atan2(rou(2)/cos(drt1),rou(1)/cos(drt1)),2*pi,0,2*pi);
end