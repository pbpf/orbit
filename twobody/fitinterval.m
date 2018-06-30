function x=fitinterval(x0,step,minx,maxx)
%% 功能：将反三角函数的值变换到合适的区间
  if(x0>=maxx)
      %disp('do');
      n=ceil((x0-maxx)/step);
      x=x0-n*step;
  elseif(x0<minx)
     % disp('do');
      n=ceil((minx-x0)/step);
      x=x0+n*step;
  else
      x=x0;
  end
end