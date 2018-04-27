function [r1,v1,E]=rv2rv(rvec,vvec,dt,mu)
 [alpha,sgm0,r0,E0]=rv2_alpha_sgm_r02(rvec,vvec,mu);
 dM=sqrt(mu*alpha^3)*dt;
 dE=kepler_solver_ellipse2(dM,sgm0,alpha,r0);
[F,G,Ft,Gt]=alpha_sgm2FG2(alpha,sgm0,r0,mu,dE);
r1=F*rvec+G*vvec;
v1=Ft*rvec+Gt*vvec;
E=E0+dE;
end