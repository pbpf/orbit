function Utdx=dtfuncdx(x0,lambda)
y0=sqrt(1-lambda^2*(1-x0^2));
eta0=y0-lambda*x0;
z0=0.5*(1-lambda-x0*eta0);
Q0=4/3*hypergeom_slocal(z0);%%pass
q0=0.5*(1-x0);
eatdx=-lambda*eta0/y0;
zdx=-0.5*eta0^2/y0;
Qdx=(2+(3*q0-3/2)*Q0)/(q0*(1-q0))*zdx;
%% ¸üÐÂ
Utdx=(eta0^3*Qdx+(3*eta0^2*Q0+4*lambda)*eatdx);
end