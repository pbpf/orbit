function x=lambert_solver(lambda,Ut)
%% 功能：求解兰伯特问题
%% 调用：x=lambert_solver(lambda,Ut);
%% 输入：
%      lambda: +-sqrt((s-c)/s) in which s , c subject to c=sqrt(r1^2+r2^2-2*r1*r2*cos(f));s=(r1+r2+c)/2;
%      Ut:归一化飞行时间
%% 输出：
%       x:解兰伯特问题的中间参量 alpha=2*(1-x^2)/s 是半长轴的倒数.
% disp(df);
% disp(r1);
% disp(r2);
x0=2;
err=1e-10;

%Ut=sqrt(mu/am^3)*Dt;
% disp('ut');
% disp(Ut);
% disp(lambda);
%% 迭代
y0=sqrt(1-lambda^2*(1-x0^2));
eta0=y0-lambda*x0;
z0=0.5*(1-lambda-x0*eta0);
Q0=4/3*hypergeom_slocal(z0);%%pass
Ut0=eta0^3*Q0+4*eta0*lambda;
q0=0.5*(1-x0);
%% 微分:
% ydx=lambda^2*x0/y0;
eatdx=-lambda*eta0/y0;
zdx=-0.5*eta0^2/y0;
Qdx=(2+(3*q0-3/2)*Q0)/(q0*(1-q0))*zdx;
%% 更新
Utdx=eta0^3*Qdx+(3*eta0^2*Q0+4*lambda)*eatdx;
leftp=-1;
%% 寻找右点
if(Ut0>Ut)
        while(Ut0>Ut)
            leftp=x0;
            x0=x0*2;
            y0=sqrt(1-lambda^2*(1-x0^2));
            eta0=y0-lambda*x0;
            z0=0.5*(1-lambda-x0*eta0);
            Q0=4/3*hypergeom_slocal(z0);%%pass
            Ut0=eta0^3*Q0+4*eta0*lambda;
        end
        rightp=x0;
        x0=leftp;
else
       rightp=x0;
end

%% 二分法（也可以用弦截法）控制牛顿迭代
 for i=1:50
     %fprintf('x=%5.20f,u-t=%5.20f,udx=%5.2f,\n',x0,Ut0-Ut,Utdx);
     if(abs(Ut0-Ut)<err)
         break;
     else
         x1=x0-(Ut0-Ut)/Utdx;
         if(x1<leftp || x1>rightp)
             x1=(rightp+leftp)/2;
         end
         x0=x1;
         y0=sqrt(1-lambda^2*(1-x0^2));
         eta0=y0-lambda*x0;
         z0=0.5*(1-lambda-x0*eta0);
         Q0=4/3*hypergeom_slocal(z0);
         q0=0.5*(1-x0);
         %% 微分:
         % ydx=lambda^2*x0/y0;
         eatdx=-lambda*eta0/y0;
         zdx=-0.5*eta0^2/y0;
         Qdx=(2+(3*q0-3/2)*Q0)/(q0*(1-q0))*zdx;
         %% 更新
         Ut0=eta0^3*Q0+4*eta0*lambda;
         Utdx=eta0^3*Qdx+(3*eta0^2*Q0+4*lambda)*eatdx;
         if(Ut0>Ut)
             leftp=x0;
         else
             rightp=x0;
         end
     end
 end
%  if(abs(Ut0-Ut)>err)
%      for i=1:20
%         %fprintf('error,%5.20f,left=%5.25f,rightp=%5.25f,mid=%10.20f\n',lambda,leftp,rightp,(leftp+rightp)/2);
%          x0=(leftp+rightp)/2;
%          y0=sqrt(1-lambda^2*(1-x0^2));
%          eta0=y0-lambda*x0;
%          z0=0.5*(1-lambda-x0*eta0);
%          Q0=4/3*hypergeom_slocal(z0);
%          Ut0=eta0^3*Q0+4*eta0*lambda;
%          if(abs(leftp-rightp)<err)
%              break;
%          elseif(Ut0-Ut>0)
%              leftp=x0;
%          else
%              rightp=x0;
%          end
%      end
%     % error('error,%5.20f,left=%5.20f,rightp=%5.10f,err=%10.20f',lambda,leftp,rightp,abs(Ut0-Ut));
%  end
 x=x0;
end