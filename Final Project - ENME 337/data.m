function V = data(x) %reads the data of x=windspeed data for specific month, and passes V which reads
%the file for the wind speed data in km/h and converts it all into m/s
data=xlsread( x, 'N17:N760'); %reads specific column for wind speed data in km/h
V_15=data./3.6; %converts data into m/s
V=0;
H=15; h=95; %height values where H=15 m given and h=96 m hub height which is where we need the windspeed values to be at
V=V_15.*(h/H)^(1/7); %wind distribution equation along the height
V=V'; %transpose column into row vector
V=round(V); %round values to the nearest integer
end
