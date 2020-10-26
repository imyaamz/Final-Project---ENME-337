function [Wtot] = WindTotal()
% Reads the wind speed and The wind direction data from the files.
Wjan=(WRD('eng-hourly-01012017-01312017.csv'))';
Wfeb=(WRD('eng-hourly-02012017-02282017.csv'))';
Wmar=(WRD('eng-hourly-03012017-03312017.csv'))';
Wapr=(WRD('eng-hourly-04012017-04302017.csv'))';
Wmay=(WRD('eng-hourly-05012017-05312017.csv'))';
Wjune=(WRD('eng-hourly-06012017-06302017.csv'))';
Wjuly=(WRD('eng-hourly-07012017-07312017.csv'))';
Waug=(WRD('eng-hourly-08012017-08312017.csv'))';
Wsep=(WRD('eng-hourly-09012017-09302017.csv'))';
Woct=(WRD('eng-hourly-10012017-10312017.csv'))';
Wnov=(WRD('eng-hourly-11012017-11302017.csv'))';
Wdec=(WRD('eng-hourly-12012017-12312017.csv'))';
% sums them for the full year into one Matrix
Wtot=Wjan+Wfeb+Wmar+Wapr+Wmay+Wjune+Wjuly+Waug+Wsep+Woct+Wnov+Wdec;
end

