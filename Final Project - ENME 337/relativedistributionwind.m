function [totalsum] = relativedistributionwind (x) %passes vector x=windspeed data (0-26 m/s) for specific month 
%returns totalsum where it is an array with values of the number of
%occurences of specific wind speed from 0-26 m/s 
totalsum=zeros(1, 27); %Create between 1:27 as there are still occurences of 0 m/s and 26 m/s, where 26 m/s is the cutoff as it is the max windspeed of all total months
%Must count occurences of 0 m/s and 26 m/s to take into account for the relative
%distribution of windspeed each month! Even if it is the cutoff, it still
%occurs!
for i=1:length(x) %loops through 1 to length of windspeed data, to check every value of windspeed data in the vector
      for j=0:26 %creates a second loop to go through each case of wind speed value for 0-26 m/s. Create this loop because doing switch x(i), case (0), case (2), case(3), case(4), case(5) would be very inefficient and annoying
    switch x(i) %for the value of windspeed in that specific row, either 0 m/s, 1 m/s, 2 m/s, etc to 26 m/s
            case(j) %if case is 0 m/s, 1 m/d, 2 m/s set by the for j=0:26
                totalsum(j+1)=totalsum(j+1)+1; %adds 1 to the count for first array representing 0 m/s.. repeats for 1-26 m/s
        end
    end
end

    