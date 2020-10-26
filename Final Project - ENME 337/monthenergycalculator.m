function energyformonth = monthenergycalculator(hourlywinddata,power)
%Returns energy for the month specified using the hourly data for the month
%and power for each wind speed value.
w_turbinehubheight=95;
cutin=3;
cutoff=25;

hourlywinddata=hourlywinddata/3.6; %convert to m/s from km/h
%Using power law to get speed at hub height from speed at 15m data,
%rounding to nearest integer, and transposing for easier indexing
hourlywinddata=round(hourlywinddata*(w_turbinehubheight/15)^(1/7))';
energyhourly=zeros(1,length(hourlywinddata));
for i=1:length(hourlywinddata) %loops through each hourly value of wind speed and assigns energy produced between each measurement
    if hourlywinddata(i)<cutin||hourlywinddata(i)>cutoff || isnan(hourlywinddata(i))
        %checking if speed at a certain time was less than the cutin or more than cutoff speed or not included
        energyhourly(i)=0; %energy is set to 0 as power is 0
    else
        energyhourly(i)=power(hourlywinddata(i));%the energy in Wh for a certain time is set to be the power for the speed at the time, and as
        %the measurements are hourly no unit manipulations have to be done
        %as it is already in Wh. We assume that between each measurement
        %the power stays relatively constant.
    end
end
energyformonth=sum(energyhourly); %total energy in Wh for the month that 1 turbine produces.
end

