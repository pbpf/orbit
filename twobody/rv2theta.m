function theta=rv2theta(rvec,vvec)
ang=acos(dot(rvec,vvec)/(norm(rvec)*norm(vvec)));
theta=ang-pi/2;
end