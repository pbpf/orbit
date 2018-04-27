function [year,month,day,fday]=JDToDate(jd)
%% 功能 将儒略日转换为 UTC日期
% Calculate the UTC according to the given JulianDay jd.
w=floor(jd)+0.5;   %standard OTC started from 0
fday=jd-w;
if fday<0.0 
    fday=fday+1.0;
    w=w-1.0;
end
sumDay=w-1721116.5;
w=0;
year=floor(sumDay/365.25); %one julian year equals 365.25OTC
year1=0;
while year1~=year
    year1=year;
    if jd>=2299160.5
        w=-floor(year/100)+floor(year/400)+2;
        year=floor((sumDay-w)/365.25);
    end
end
sumDay=sumDay-w;
w=sumDay;
%new sum days
sumDay=sumDay-floor(365.25*year);
if sumDay==0
    year=year-1;
    sumDay=w-floor(365.25*year);
end
sumDay=sumDay+122;
month=floor(sumDay/30.6)-1;
day=sumDay-floor(30.6*(month+1));
if day==0
    month=month-1;
    day=sumDay-floor(30.6*(month+1));
end
w=day+fday;
day=floor(w);
fday=w-day;
if month>12
    month=month-12;
    year=year+1;
end
end