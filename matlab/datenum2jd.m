function jd=datenum2jd(num)
%% 功能: 将日期数值转换为儒略日
   datevec1=datevec(num);
   jd=juliandate(datevec1);
end