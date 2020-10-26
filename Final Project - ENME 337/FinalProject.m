%Final Project
clear;clc;close all;
%reading data
w_turbinehubheight=95;
n_blades=3;
% Loading data and transposing for easier indexing
radius=load('radius.dat');
radius=radius';
chord=load('chord.dat');
chord=chord';
twist=load('twist.dat');
twist=twist';
liftdrag=load('NACA64.dat');
liftdrag=liftdrag';
omega=load('omega.dat'); %converting to rad/s
omega=((omega)/60*2*pi)';
a_density=1.23;
ac=0.2;
cutin=3;
cutoff=25;
nom_power=5*10^6;
tolerance=10^(-6);
pop_regina=214631;

%How this works is that we loop through each speed until the cutoff speed
%in the outer loop, and in the inner loop we are looping through every
%radius value and calculating for the power for each specific radius value.
%We then get the total power for the current speed, and then loop until we
%get the total power for every speed.
%Preallocation for speed
power=zeros(1,cutoff);
%Outer speed loop
for V=1:cutoff
    Pt=zeros(1,length(radius));
    %Inner radius loop
    for i=1:length(radius)
        %Step 1: Initializing a and a' initially to 0 for both.
        a=0;
        aprime=0;
        while true %Loops until convergence.
            %Setting old and and oldaprime as the previous a and aprime
            %values for tolerance checking
            olda=a;
            oldaprime=aprime;
            %Step 2, computing the flow angle phi at the specified speed,
            %rotational speed in rad/s, and radius.
            phi=atand(((1-a)*V)/((1+aprime)*omega(V)*radius(i)));
            %Step 3, calculating local angle of attack at the specified
            %radius
            angleofattack=phi-twist(i);
            %Step 4, using the given airfoil profile and interpolation to
            %interpolate values for the lift and drag coefficients from our angle of
            %attack value
            lift=interp1(liftdrag(1,:),liftdrag(2,:),angleofattack);
            drag=interp1(liftdrag(1,:),liftdrag(3,:),angleofattack);
            %Step 5, computing normalized force Cn and Ct
            Cn=lift*cosd(phi)+drag*sind(phi);
            Ct=lift*sind(phi)-drag*cosd(phi);
            %Step 6, calculating solidity, K, a, and aprime
            solidity=chord(i)*n_blades/(2*pi*radius(i));
            K=(4*(sind(phi))^2)/(solidity*Cn);
            a=1/(K+1);
            aprime=1/((4*sind(phi)*cosd(phi)/(solidity*Ct))-1);
            %Step 7, applying Galuert Correction
            if a>ac
                a=0.5*(2+K*(1-2*ac)-sqrt((K*(1-2*ac)+2)^2+4*(K*ac^2-1)));
            end
            %Step 8, comparing old a to the new a calculated, as well as
            %the old a prime to the new a prime calculated. If a and a' has
            %changed more than a certain tolerance 1e-6 it loops again,
            %otherwise it breaks out of the loop iteration process.
            if ~(abs(a-olda)> tolerance && abs(aprime-oldaprime)> tolerance)
                break
            end
        end
        %Step 9, calculating the local tangential load at a specific
        %segment of the blade corresponding to the specific radius used; we
        %calculate for vrelsquared exactly using the triangle with vrel as
        %the hypotenuse as the estimate is a little off for most
        %calculations. We also couldve just used the estimate to calculate
        %for vrelsquared.
        vrelsquared=(V*(1-a))^2+(omega(V)*radius(i)*(1+aprime))^2;
        %vrelsquared=((V*(1-a))/(sind(phi)))^2; %The estimate code here
        Pt(i)=0.5*Ct*a_density*vrelsquared*chord(i);
    end
    %Step 10, now we know the tangential force per length (Pt(i)) for each segment
    %at a specific radius r(i) for a certain speed. Assume a linear variation
    %between ri and ri+1
    %Preallocation for speed, length radius-1
    Ai=zeros(1,length(radius)-1);
    Bi=zeros(1,length(radius)-1);
    %Step 11, finding for Ai(j) and Bi(j) by looping through and calculating each
    %element. length radius-1 as we are using i+1 indexes
    for j=1:(length(radius)-1)
        Ai(j)=(Pt(j+1)-Pt(j))/(radius(j+1)-radius(j));
        Bi(j)=(radius(j+1)*Pt(j)-Pt(j+1)*radius(j))/(radius(j+1)-radius(j));
    end
    Mi=zeros(1,length(radius)-1);
    %Loops through and solves for each value of Mi(j) (The shaft torque between a radius j and
    %the next radius j+1) using Ai(j) and Bi(j) as well as radius j+1 and j values.
    for j=1:(length(radius)-1)
        Mi(j)=1/3*Ai(j)*((radius(j+1))^3-(radius(j))^3)+1/2*Bi(j)*((radius(j+1))^2-(radius(j))^2);
    end
    %Step 12, finding the total torque by summing up all the contributions
    %between the radiuses Mi(j) and multiplying by number of blades.
    Mtot=sum(Mi)*n_blades;
    %Step 13, calculating for total power of the rotor at a certain speed
    %by multiplying total shaft at that specific speed with the rotational speed
    %in rad/s at that specific speed
    power(V)=omega(V)*Mtot;
end
%Loops to see if power for any specific speed exceeds the nominal power.
%If any does, sets the power for that wind speed equal to the nominal
%power.
for i=1:length(power)
    if power(i) > (nom_power)
        power(i)=nom_power;
    end
end

%Step 14, computes produced energy for one year in Wh for a turbine, then
%estimates how many turbines would be needed to power a city
yearlyenergyproduced2017=yearenergycalculator(power); %Total energy produced for 2017 in Wh for 1 turbine
yearenergyneeded=16.5*10^6*pop_regina; %needed energy to power the entire city
numberturbines=round(yearenergyneeded/yearlyenergyproduced2017); %finding number of turbines needed.
fprintf('Each turbine produces %f Wh of energy per year.\n', yearlyenergyproduced2017);
fprintf('For Regina, a city with a population of %i, assuming a per-capita electricity consumption of 16.5 MWh,\n', pop_regina);
fprintf('the yearly energy needed to power the city would be an estimated value of %f Wh.\n',yearenergyneeded)
fprintf('Therefore, by dividing, we get a total of %i turbines that are needed to power Regina.',numberturbines)

%Rotor Power as a function of wind speed plot
plot(0:cutoff, [0 power]) 
line([cutoff cutoff],[0 5*10^6]) %Plotting constant line
line(cutoff:30, zeros(1,6)) %Zero power line
title('Rotor Power as a function of Wind Speed at Hub Height, 95m','fontsize',9)
xlabel('Wind Speed, m/s')
ylabel('Power, W')
ylim([0,10*10^6])
xticks([0 3 5 10 15 20 25 30])
text(cutin-1.3,-950000,'Cut In')
text(cutoff-1.3,-950000,'Cut Off')

figure(2);
geometryofblade(chord,twist,radius);

figure(3);
V0_95jan=data('eng-hourly-01012017-01312017.csv'); %Initialization of Data where velocity in km/h is converted into m/s
V0_95feb=data('eng-hourly-02012017-02282017.csv');
V0_95mar=data('eng-hourly-03012017-03312017.csv');
V0_95apr=data('eng-hourly-04012017-04302017.csv');
V0_95may=data('eng-hourly-05012017-05312017.csv');
V0_95june=data('eng-hourly-06012017-06302017.csv');
V0_95july=data('eng-hourly-07012017-07312017.csv');
V0_95aug=data('eng-hourly-08012017-08312017.csv');
V0_95sep=data('eng-hourly-09012017-09302017.csv');
V0_95oct=data('eng-hourly-10012017-10312017.csv');
V0_95nov=data('eng-hourly-11012017-11302017.csv');
V0_95dec=data('eng-hourly-12012017-12312017.csv');

tsjan= relativedistributionwind2(V0_95jan); %pass m/s windspeed data into function relativedistributionwind2
tsfeb= relativedistributionwind2(V0_95feb);
tsmar= relativedistributionwind2(V0_95mar);
tsapril= relativedistributionwind2(V0_95apr);
tsmay= relativedistributionwind2(V0_95may);
tsjune= relativedistributionwind2(V0_95june);
tsjuly= relativedistributionwind2(V0_95july);
tsaug= relativedistributionwind2(V0_95aug);
tssep= relativedistributionwind2(V0_95sep);
tsoct= relativedistributionwind2(V0_95oct);
tsnov= relativedistributionwind2(V0_95nov);
tsdec= relativedistributionwind2(V0_95dec);

powerdis=[0 power 0]; %adds a value of 0 to start and end to represent the power provided by windspeeds out of the range, at 0 m/s and 26 m/s
powerdis=powerdis./1000000; %since values are in the hundred thousands, converts values into MW by dividing by 1000000

tsjan2= relativedistributionwind(V0_95jan); %passes m/s windspeed data into function relativedistributionwind
tsfeb2= relativedistributionwind(V0_95feb);
tsmar2= relativedistributionwind(V0_95mar);
tsapril2= relativedistributionwind(V0_95apr);
tsmay2= relativedistributionwind(V0_95may);
tsjune2= relativedistributionwind(V0_95june);
tsjuly2= relativedistributionwind(V0_95july);
tsaug2= relativedistributionwind(V0_95aug);
tssep2= relativedistributionwind(V0_95sep);
tsoct2= relativedistributionwind(V0_95oct);
tsnov2= relativedistributionwind(V0_95nov);
tsdec2= relativedistributionwind(V0_95dec);

prjan=powertotal(powerdis, tsjan2); %passes powerdis with values of power respective to specific wind speed (0-26 m/s) and passes relative distribution of windspeed from 0-26 m/s
prfeb=powertotal(powerdis, tsfeb2);
prmar=powertotal(powerdis, tsmar2);
prapril=powertotal(powerdis, tsapril2);
prmay=powertotal(powerdis, tsmay2);
prjune=powertotal(powerdis, tsjune2);
prjuly=powertotal(powerdis, tsjuly2);
praug=powertotal(powerdis, tsaug2);
prsep=powertotal(powerdis, tssep2);
proct=powertotal(powerdis, tsoct2);
prnov=powertotal(powerdis, tsnov2);
prdec=powertotal(powerdis, tsdec2);

pr0_5=[prjan(1) prfeb(1) prmar(1) prapril(1) prmay(1) prjune(1) prjuly(1) praug(1) prsep(1) proct(1) prnov(1) prdec(1)]; %adds values of 0-5 m/s for each month (jan-dec) and creates an array with values
pr6_10=[prjan(2) prfeb(2) prmar(2) prapril(2) prmay(2) prjune(2) prjuly(2) praug(2) prsep(2) proct(2) prnov(2) prdec(2)];%same process as above, but for 6-10 m/s
pr11_15= [prjan(3) prfeb(3) prmar(3) prapril(3) prmay(3) prjune(3) prjuly(3) praug(3) prsep(3) proct(3) prnov(3) prdec(3)];
pr16_20= [prjan(4) prfeb(4) prmar(4) prapril(4) prmay(4) prjune(4) prjuly(4) praug(4) prsep(4) proct(4) prnov(4) prdec(4)];
pr21_26= [prjan(5) prfeb(5) prmar(5) prapril(5) prmay(5) prjune(5) prjuly(5) praug(5) prsep(5) proct(5) prnov(5) prdec(5)];

yyy=[tsjan; tsfeb; tsmar;tsapril;tsmay;tsjune;tsjuly; tsaug;tssep;tsoct;tsnov; tsdec]; %creates a vector with values of relative distribution 
%for specific ranges (0-5 m/s, 6-10 m/s, 11-15 m/s, 16-20 m/s, and 21-26
%m/s) for each specific month
H=bar(yyy, 'Barwidth', 0.6); %plots a bar graph, using month (12 values) as xaxis and
%plotting values of occurences for each range of windspeed in y axis
xticklabels({'January','Febuary','March','April','May','June','July','August','September','October','November','December'});
%xticklabels puts labels on 12 values representing each specific month
ylim([0, 450]); %new limit from 0-450 to scale for better representation of bar values
xlabel('Month of the Year'); %adds xlabel for which month it is
ylabel({'Number of Reoccurences of windspeed ranges, V_{0} (m/s)','*Represented by Bar Graph'}); %ylabel to represent relative distribution 
%has a space in betwen, and explains that the Bar graph represents this
title('Bar Graph of Relative Distribution of wind speed, V_{0} (m/s) and Produced Energy (MJ) at certain wind speed ranges for each month' );
yyaxis right %creates a new axis of y on right to represent energy (MJ)
ylabel({'Produced Energy (MJ) at certain wind speed ranges for respective month','*Represented by Line Graph'});
%the lines plotted represent the produced energy 
monthsyear=[1:12]; %creates a vector representing the months from January to December
%the energy produced (MJ) is the same magnitude as power produced (MW)
%since measurements are taken hourly!
line(monthsyear, pr0_5,'color',[0 0.4470 0.7410],'LineWidth',2,'Marker', '*') %line graph representing power value for windspeeds 0-5 m/s in each month
line(monthsyear, pr6_10,'color',[0.8500 0.3250 0.0980],'LineWidth',2,'Marker', '*')%line graph representing power value for windspeeds 6-10 m/s in each month
line(monthsyear, pr11_15,'color',[0.9290 0.6940 0.1250],'LineWidth',2,'Marker', '*') %line graph representing power value for windspeeds 11-15 m/s in each month
line(monthsyear, pr16_20,'color',[0.4940 0.1840 0.5560],'LineWidth',2,'Marker', '*')%line graph representing power value for windspeeds 16-20 m/s in each month
line(monthsyear, pr21_26,'color',[0.4660 0.6740 0.1880],'LineWidth',2,'Marker', '*')%line graph representing power value for windspeeds 21-26 m/s in each month
ylim([0, 900]); %new lim to scale graph better
legend(H, {'0-5 m/s' , '6-10 m/s', '11-15 m/s', '16-20 m/s', '21-26 m/s'}, 'Location', 'eastoutside');
%adds legend to have colors represent specific wind ranges, puts legend
%outside the plot on the east

figure(4);
WindRoseGraph();



