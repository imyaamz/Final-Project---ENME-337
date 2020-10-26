function power =powertotal (x,y) %function takes vectors x=power of each velocity of windspeed (0-26 m/s) and y=relative distribution of windspeed values 0-26 m/s for specific month,
%outputs vector with total power between ranges 0-5 m/s, 6-10 m/s, 11-15 m/s, 16-20 m/s, 21-26 m/s
powermonth=x.*y; %multiplies x by y to get total power of each windspeed (0-26 m/s)
power0_5month=powermonth(1)+powermonth(2)+powermonth(3)+powermonth(4)+powermonth(5)+powermonth(6); %adding power totals of 0-5 m/s in order to get the total power from range 0-5m/s windspeed
power6_10month=powermonth(7)+powermonth(8)+powermonth(9)+powermonth(10)+powermonth(11); %same process as above, but finding total power for 6-10 m/s
power11_15month=powermonth(12)+powermonth(13)+powermonth(14)+powermonth(15)+powermonth(16); %total power for 11-15 m/s
power16_20month=powermonth(17)+powermonth(18)+powermonth(19)+powermonth(20)+powermonth(21); %total power for 16-20 m/s
power21_26month=powermonth(22)+powermonth(23)+powermonth(24)+powermonth(25)+powermonth(26)+powermonth(27); %total power for 21-26 m/s
power=[power0_5month power6_10month power11_15month power16_20month power21_26month]; %makes a vector containing total power for specific windspeed ranges,
%where first column is 0-5 m/s power, 2nd column 6-10 m/s power, and so on 

end
