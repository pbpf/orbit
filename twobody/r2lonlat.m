function [lambda,phi]=r2lonlat(rvec)
rvec=rvec/norm(rvec);
z=rvec(3);
x=rvec(1);
y=rvec(2);
phi=asin(z);
lambda=atan2(y,x);
end