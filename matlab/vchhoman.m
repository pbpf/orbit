function vch=vchhoman(r1,r2,mu)
 dv1=sqrt(mu/r1)*(sqrt(2*r2/(r1+r2))-1);
 dv2=sqrt(mu/r2)*(1-sqrt(2*r1/(r1+r2)));
 vch=dv1+dv2;
end
 