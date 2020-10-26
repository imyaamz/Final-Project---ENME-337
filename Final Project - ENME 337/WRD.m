function [M] = WRD(x)

    data=xlsread( x, 'N17:N760'); %pulls the data for the wind speed
    A=(xlsread( x, 'L17:L760'))'; %pulls the data for the wind direction
    V_15=data./3.6; %converts to m/s
    H=15; h=95;
    V=(V_15.*(h/H)^(1/7))'; %at hub height
    A(isnan(A))=[]; %removes unadmissable values from angles
    V(isnan(V))=[]; %removes unadmissable values from speed
    M=zeros(12,6); %initial matrix
    
    for i=1:length(A) % determines the direction and speed of each measured data
    
    if A(i)>0 && A(i)<=3 % checks if the position is between 0 and 30 degrees
        if V(i)>=0 && V(i)<3 %checks if the speed is between 0 and 3 m/s
            M(1,1)=M(1,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(1,2)=M(1,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(1,3)=M(1,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(1,4)=M(1,4)+1;
        end
        if V(i)>=12 && V(i)<15
            M(1,5)=M(1,5)+1;
        end
        if V(i)>=15
            M(1,6)=M(1,6)+1;
        end
    end
    if A(i)>3 && A(i)<=6
        if V(i)>=0 && V(i)<3
            M(2,1)=M(2,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(2,2)=M(2,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(2,3)=M(2,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(2,4)=M(2,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(2,5)=M(2,5)+1;
        end
         if V(i)>=15
            M(2,6)=M(2,6)+1;
        end
    end
    if A(i)>6 && A(i)<=9
        if V(i)>=0 && V(i)<3
            M(3,1)=M(3,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(3,2)=M(3,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(3,3)=M(3,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(3,4)=M(3,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(3,5)=M(3,5)+1;
        end
         if V(i)>=15
            M(3,6)=M(3,6)+1;
        end
    end
    if A(i)>9 && A(i)<=12
        if V(i)>=0 && V(i)<3
            M(4,1)=M(4,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(4,2)=M(4,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(4,3)=M(4,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(4,4)=M(4,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(4,5)=M(4,5)+1;
        end
         if V(i)>=15
            M(4,6)=M(4,6)+1;
        end
        
    end
    
    if A(i)>12 && A(i)<=15
        if V(i)>=0 && V(i)<3
            M(5,1)=M(5,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(5,2)=M(5,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(5,3)=M(5,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(5,4)=M(5,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(5,5)=M(5,5)+1;
        end
         if V(i)>=15
            M(5,6)=M(5,6)+1;
        end
    end
    
    
    if A(i)>15 && A(i)<=18
        if V(i)>=0 && V(i)<3
            M(6,1)=M(6,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(6,2)=M(6,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(6,3)=M(6,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(6,4)=M(6,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(6,5)=M(6,5)+1;
        end
         if V(i)>=15
            M(6,6)=M(6,6)+1;
        end
    end
    if A(i)>18 && A(i)<=21
        if V(i)>=0 && V(i)<3
            M(7,1)=M(7,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(7,2)=M(7,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(7,3)=M(7,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(7,4)=M(7,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(7,5)=M(7,5)+1;
        end
         if V(i)>=15
            M(7,6)=M(7,6)+1;
        end
    end
    if A(i)>21 && A(i)<=24
        if V(i)>=0 && V(i)<3
            M(8,1)=M(8,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(8,2)=M(8,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(8,3)=M(8,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(8,4)=M(8,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(8,5)=M(8,5)+1;
        end
         if V(i)>=15
            M(8,6)=M(8,6)+1;
        end
    end
    if A(i)>24 && A(i)<=27
        if V(i)>=0 && V(i)<3
            M(9,1)=M(9,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(9,2)=M(9,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(9,3)=M(9,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(9,4)=M(9,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(9,5)=M(9,5)+1;
        end
         if V(i)>=15
            M(9,6)=M(9,6)+1;
        end
    end
    if A(i)>27 && A(i)<=30
        if V(i)>=0 && V(i)<3
            M(10,1)=M(10,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(10,2)=M(10,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(10,3)=M(10,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(10,4)=M(10,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(10,5)=M(10,5)+1;
        end
         if V(i)>=15
            M(10,6)=M(10,6)+1;
        end
    end
    if A(i)>30 && A(i)<=33
        if V(i)>=0 && V(i)<3
            M(11,1)=M(11,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(11,2)=M(11,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(11,3)=M(11,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(11,4)=M(11,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(11,5)=M(11,5)+1;
        end
         if V(i)>=15
            M(11,6)=M(11,6)+1;
        end
    end
    if A(i)>30 && A(i)<=36
        if V(i)>=0 && V(i)<3
            M(12,1)=M(12,1)+1;
        end
        if V(i)>=3 && V(i)<6
            M(12,2)=M(12,2)+1;
        end
        if V(i)>=6 && V(i)<9
            M(12,3)=M(12,3)+1;
        end
        if V(i)>=9 && V(i)<12
            M(12,4)=M(12,4)+1;
        end
        if V(i)>=12  && V(i)<15
            M(12,5)=M(12,5)+1;
        end
         if V(i)>=15
            M(12,6)=M(12,6)+1;
        end
    end
    
    
    end
    
    
    
end
