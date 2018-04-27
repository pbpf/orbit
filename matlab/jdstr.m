function str=jdstr(jd)
%% 将儒略日转换为 日期 字符串 ISO-8601
[year,month,day]=JDToDate(jd);
str = sprintf('%d-%d-%d',year,month,day);
end