function [] = WindRoseGraph()
%Generates a WindRose Graph

Wtot=WindTotal(); % sum of positions and speeds of wind
His=NaN([6,sum(sum(Wtot))]); %creates a NaN Matrix of 6 rows(for velocity) and around 10000 columns for the position,
                             %initialising the windrose data 
Histemp=[]; %initialising Histemp array
for i=1:6 % Creates 6 arrays in a matrix that stores the number of speeds at a certain position, 
          %one for every speed between a certain angle,eg 0-30, adding the arrays to each subsequent array to format the windrose.

    for j=1:12
        Histemp=[Histemp ones(1,Wtot(i,j))*deg2rad(30*j)]; %creates a array of the length of instances and concatenates it onto each subsequent array
        
    end
    Histemp=[Histemp NaN(1,[length(His)-length(Histemp)])]; %creates length of longest array minus current one
    for k=1:length(Histemp)
    His(i,k)=Histemp(k);
    end
    Histemp(isnan(Histemp))=[];
end
His=His-deg2rad(30); %Aligns the angles with the windrose
i=6;
while i>0 %Creates 6 windrose plots with different velocities being shown as different colors
    if i==6
        Color=[1 0 0];
    elseif i==5
            Color=[0.5 0 0.5];
    elseif i==4
            Color=[0 0 1];
            
    elseif i==3
        Color=[0 0.8 0];
    elseif i==2
        Color=[0 1 0];
    else
        Color=[1 1 0.9];
        
        
    end
    
    TempPol=His(i,:);
    TempPol(isnan(TempPol))=[];
    polarhistogram(TempPol,12, 'FaceColor',Color); %Creates a polar histogram with 12 directions
    hold on
    i=i-1;
end
%Title specifications
title('Wind Rose and Wind Speed in m/s','Color',[0.5 0.5 0.5],'FontSize',12,'FontWeight','bold')
str=zeros(1,6);
for i=1:6
 str(i) = sum(Wtot(i,:)/sum(sum(Wtot)))*100;%Gives percentage of data point at certain speeds in respect to total Data
end

lgd=legend(['\color[rgb]{0.5 0.5 0.5} 15+     (' num2str(str(1)) ')%'],... %colors and displays the legend
   ['\color[rgb]{0.5 0.5 0.5} 12-15   (' num2str(str(2)) ')%'],...
   ['\color[rgb]{0.5 0.5 0.5} 9-12    (' num2str(str(3)) ')%'],...
   ['\color[rgb]{0.5 0.5 0.5} 6-9     (' num2str(str(3)) ')%'],...
   ['\color[rgb]{0.5 0.5 0.5} 3-6     (' num2str(str(5)) ')%'],...
   ['\color[rgb]{0.5 0.5 0.5} 0-3     (' num2str(str(6)) ')%']);
%figure specifications
rlim([0 (0.2*sum(sum(Wtot)))])%Sets the raidus limit to 20% of the total measurements for the year
rticks([(0.05*sum(sum(Wtot))) (0.1*sum(sum(Wtot))) (0.15*sum(sum(Wtot))) (0.2*sum(sum(Wtot)))]) %sets each respective radius tick
rticklabels({'5%','10%','15%','20%'})
thetaticks([0:30:360])%sets the number of ticks for the circumference
thetaticklabels({'0,360 (E)',30,60,'90 (N)',120,150,'180 (W)',210,240,'270 (S)',300,330}) %labels the circumferance
pax = gca;
pax.ThetaColor = [0.5 0.5 0.5]; %colors the ticks
pax.RColor = [0.5 0.5 0.5];
set(gcf,'color','w'); %sets background to white
lgd.Title.Color = [0.5 0.5 0.5]; %legend title color
title(lgd,{'Wind Speed (m/s)','Percentage of measurements'}) %legend title
legend boxoff % no box

end

