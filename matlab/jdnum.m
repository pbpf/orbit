function num=jdnum(jd)
%% 功能：将儒略日转换为数值 用于matlab画图
%% 调用：jdnum(jd)
%% 输入
%    jd: 儒略日
%% 输出
%   num 数值
[year,month,day]=JDToDate(jd);
num=datanum(year,month,day);
end