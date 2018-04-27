function [rvec,vvec,t]=improved_laplace_solver(B,H,we,ae,ee,mu,data_m,choose,eps)
%% 功能： 改进拉普拉斯法求卫星的位置和速度
%% 调用： [rvec,vvec,t]=improved_laplace_solver(B,H,we,ae,ee,mu,data_m,choose,err)：
%% 输入：
%     B：测站的大地纬度
%     H：测站高程
%     we:地球自转角速度
%     ae：地球半长轴
%     ee:偏心率
%     mu:地球引力常量
%     data_m(不少于3行)：    第一列 时间
%                           第二列 当地恒星时
%                           第三列 赤纬
%                           第四列 赤经
%     choose： 选定时刻在data_m的行数 (1<choose<n)
%% 输出:
%           rvec:选定时刻的位置
%           vvec:选定时刻的速度
%           t:选定时刻
%% 测试: 通过  收敛稍慢 对于不同的选定点 alpha 基本稳定
%% 拉普拉斯法求初值
%w=0.1;
[rvec0,vvec0,t]=laplace_solver(B,H,we,ae,ee,mu,data_m(choose-1:choose+1,:));
X0=[rvec0;vvec0];
n=size(data_m,1);%data_m 行数
%% 计算方向余弦和测站坐标、FG 初值
Rs=zeros(3,n);
RHOs=zeros(3,n);
B1s=zeros(n,1);
B2s=zeros(n,1);
% disp(1/alpha0-a);
%% 建立测站坐标，方向余弦，F,G的初值
for i=1:n
    Rs(:,i)=BHs2R(B,H,data_m(i,2),ae,ee);
    RHOs(:,i)=alpha_delta2directional_cosine(data_m(i,4),data_m(i,3));%方向余弦
    B1s(i,:)=RHOs(2,i)*Rs(1,i)-RHOs(1,i)*Rs(2,i);
    B2s(i,:)=RHOs(3,i)*Rs(2,i)-RHOs(2,i)*Rs(3,i);
end
Bs=[B1s;B2s];
DTs=data_m(:,1)-t;
X1=improved_laplace_repeat(n,X0,RHOs,Bs,DTs,1);
X1=0.5*X1+0.5*X0;
%% 判断最终解的收敛性
maxstep=10000;
for k=1:maxstep
  %   disp(norm(X1-X0));
  %   disp(norm(X1));
    if(norm(X1-X0)<eps)
        rvec=X1(1:3,:);
        vvec=X1(4:6,:);
        break;
    else
        X0=X1;
        X1=improved_laplace_repeat(n,X0,RHOs,Bs,DTs,0);
        X1=X1*0.5+0.5*X0;
%         disp(X0);
%         disp(X1);
%          fprintf('ang %5.10f\n',acos(dot(X0,X1)/(norm(X0)*norm(X1)))*180/pi);
% %          X1=X1-2*(X1-X0);
%          disp(X1-X0);
    end
end
if(norm(X1-X0)>eps)
%% 出错提示
     error('imporved_laplace_solver:exceed_max_loop',...
       'Error:exceed_max_loop: \n The solver try its best but can not find required answer.\n Required err<=%s \n at the last loop err=%s , you may should try a bigger one.',eps,norm(X1-X0));
end
end
