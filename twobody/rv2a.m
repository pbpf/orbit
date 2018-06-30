function a=rv2a(r,v,mu)
eg=rv2energy(r,v,mu);
a=energy2a(eg,mu);
end