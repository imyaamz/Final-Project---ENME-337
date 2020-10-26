function yearlyenergyproduced = yearenergycalculator(power)
%Calls monthenergycalculator for every month, returns total energy produced
%in the year.
jan=monthenergycalculator(xlsread('eng-hourly-01012017-01312017.csv','N17:N760'),power);
feb=monthenergycalculator(xlsread('eng-hourly-02012017-02282017.csv','N17:N688'),power);
mar=monthenergycalculator(xlsread('eng-hourly-03012017-03312017.csv','N17:N760'),power);
apr=monthenergycalculator(xlsread('eng-hourly-04012017-04302017.csv','N17:N736'),power);
may=monthenergycalculator(xlsread('eng-hourly-05012017-05312017.csv','N17:N760'),power);
jun=monthenergycalculator(xlsread('eng-hourly-06012017-06302017.csv','N17:N736'),power);
jul=monthenergycalculator(xlsread('eng-hourly-07012017-07312017.csv','N17:N760'),power);
aug=monthenergycalculator(xlsread('eng-hourly-08012017-08312017.csv','N17:N760'),power);
sept=monthenergycalculator(xlsread('eng-hourly-09012017-09302017.csv','N17:N736'),power);
oct=monthenergycalculator(xlsread('eng-hourly-10012017-10312017.csv','N17:N760'),power);
nov=monthenergycalculator(xlsread('eng-hourly-11012017-11302017.csv','N17:N736'),power);
dec=monthenergycalculator(xlsread('eng-hourly-12012017-12312017.csv','N17:N760'),power);
yearlyenergyproduced=jan+feb+mar+apr+may+jun+jul+aug+sept+oct+nov+dec;
end

