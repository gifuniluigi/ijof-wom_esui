
clear;clc

% Add path to dataset
addpath('Data');

matFiles=dir('*.mat'); %finds all the .mat files (struct)
[n,~]=size(matFiles);

ivar = 3; %oil price measures 

mspe1  = nan(246,n,ivar);
mspe3  = nan(246-2,n,ivar);
mspe6  = nan(246-5,n,ivar);
mspe12 = nan(246-11,n,ivar);
mspe24 = nan(246-23,n,ivar);


for i=1:n

    matFileName=matFiles(i).name;
    load(matFileName(1:end-4));

    for j=1:ivar

        mspe1(:,i,j) =msfe(:,1,j);          %1-month   ahead forecast
        mspe3(:,i,j) =msfe(1:end-2,3,j);    %3-month   ahead forecast
        mspe6(:,i,j) =msfe(1:end-5,6,j);    %6-month   ahead forecast
        mspe12(:,i,j)=msfe(1:end-11,12,j);  %12-month  ahead forecast
        mspe24(:,i,j)=msfe(1:end-23,24,j);  %24-month  ahead forecast

    end

end

save('mspe1','mspe1')
save('mspe3','mspe3')
save('mspe6','mspe6')
save('mspe12','mspe12')
save('mspe24','mspe24')

%close path
rmpath('Data');

