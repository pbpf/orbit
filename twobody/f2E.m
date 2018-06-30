function E=f2E(f,e)
cosE=(e+cos(f))/(1+e*cos(f));
sinE=sqrt(1-e^2)*sin(f)/(1+e*cos(f));
E=atan2(sinE,cosE);