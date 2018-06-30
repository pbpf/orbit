function f=E2f(E,e)
cosf=(cos(E)-e)/(1-e*cos(E));
sinf=sqrt(1-e^2)*sin(E)/(1-e*cos(E));
f=atan2(sinf,cosf);
end