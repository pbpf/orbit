function [as,ds]=rv2measure(r,v,Rs,DTs)
%% 由rv反计算赤经赤纬 批量
n=size(DTs,1);
as=zeros(n,1);
ds=zeros(n,1);
for k=1:n
[as(k),ds(k)]=rv2LatLong(r,v,DTs(k),Rs(:,k));
end
end