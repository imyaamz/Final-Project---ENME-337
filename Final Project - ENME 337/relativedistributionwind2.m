   function [totalsum] = relativedistributionwind2 (x) %x=vector with respective windspeed data for each month (0-26 m/s)
totalsum=zeros(1, 5); %creates an array of 5, first column representing 0-5 m/s, second 6-10 m/s, third 11-15 m/s, fourth 16-20 m/s, fifth 21-26 m/s
for i=1:length(x) %loops through 1 to length of windspeed data, to check every value of windspeed data in the vector
    for j=0:5 %adds for 0-5 m/s
        switch x(i)
            case j
                totalsum(1)=totalsum(1)+1; %adds count to first column representing 0-5 m/s
        end
    end
    for j=6:10 %adds for 6-10 m/s
        switch x(i)
            case j
                totalsum(2)=totalsum(2)+1; %adds count to second column representing 6-10 m/s
        end
    end
    for j=11:15 %adds for 11-15 m/s
        switch x(i)
            case j
                totalsum(3)=totalsum(3)+1; %adds count to third column representing 11-15 m/s
        end
    end
    for j=16:20 %adds value for 16-20 m/s
        switch x(i)
            case j
                totalsum(4)=totalsum(4)+1; %adds count to fourth column representing 16-20 m/s
        end
    end
    for j=21:26 %adds value for 21-26 m/s
        switch x(i)
            case j
                totalsum(5)=totalsum(5)+1; %adds count to fifth column representing 21-26 m/s
        end
    end
end
   end
  