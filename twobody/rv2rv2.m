function rv=rv2rv2(rv1,dt,mu)
[r1,v1]=rv2rv(rv1(1:3),rv1(4:6),dt,mu);
rv=[r1;v1];
end