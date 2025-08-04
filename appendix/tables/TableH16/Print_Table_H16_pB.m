%%% This file produces the results reported in Table H16, Panel B

clear; clc;

% Add path to functions
addpath('functions');

% Load data
% Load the same model without and with TOSI (e.g. cmb1 is without TOSI,
% cmb2 is with TOSI; cmb3 is without TOSI, cmb4 is with TOSI and so on...)

load SVBVARcmb1

load SVBVARcmb2

% CRPS = 0 for No-Tosi vs. Tosi comparison
% CRPS = 1 for RW vs. Tosi comparison
CRPS = 1; 

% Number of datasets
numFiles = 14;

% Store results
Table_DF = zeros(numFiles, 15); % Assuming 5 time horizons for 3 oil price measures
Table_DM = zeros(numFiles, 15); % Assuming 5 time horizons for 3 oil price measures

for i = 1:numFiles

    % Load data
    % After saving the results from the previous file, the name and the order 
    % of .mat files has been changed to reflect the one reported in the appendix
    filename = sprintf('SVBVARcmb%d.mat', i);
    M = load(filename);

    if CRPS == 0

        M1 = load('SVBVARcmb0');
        M1.CRPS=M1.CRPS(:,:,1:3);
        M1.acrps=M1.acrps(:,1:3);
        M1.alpl=M1.alpl(:,:,1:3);
        M1.nmodel=3;

        Table_DF(i,1:3)=round(M.acrps(1,1:3),3);
        Table_DF(i,4:6)=round(M.acrps(3,1:3),3);
        Table_DF(i,7:9)=round(M.acrps(6,1:3),3);
        Table_DF(i,10:12)=round(M.acrps(12,1:3),3);
        Table_DF(i,13:15)=round(M.acrps(24,1:3),3);

        Table_DM(i,1)=test_DM(M1.CRPS(:,1,1), M.CRPS(:,1,1),1,0);
        Table_DM(i,2)=test_DM(M1.CRPS(:,1,2), M.CRPS(:,1,2),1,0);
        Table_DM(i,3)=test_DM(M1.CRPS(:,1,3), M.CRPS(:,1,3),1,0);

        Table_DM(i,4)=test_DM(M1.CRPS(1:end-2,3,1), M.CRPS(1:end-2,3,1),1,0);
        Table_DM(i,5)=test_DM(M1.CRPS(1:end-2,3,2), M.CRPS(1:end-2,3,2),1,0);
        Table_DM(i,6)=test_DM(M1.CRPS(1:end-2,3,3), M.CRPS(1:end-2,3,3),1,0);

        Table_DM(i,7)=test_DM(M1.CRPS(1:end-5,6,1), M.CRPS(1:end-5,5,1),1,0);
        Table_DM(i,8)=test_DM(M1.CRPS(1:end-5,6,2), M.CRPS(1:end-5,5,2),1,0);
        Table_DM(i,9)=test_DM(M1.CRPS(1:end-5,6,3), M.CRPS(1:end-5,5,3),1,0);

        Table_DM(i,10)=test_DM(M1.CRPS(1:end-11,12,1), M.CRPS(1:end-11,12,1),1,0);
        Table_DM(i,11)=test_DM(M1.CRPS(1:end-11,12,2), M.CRPS(1:end-11,12,2),1,0);
        Table_DM(i,12)=test_DM(M1.CRPS(1:end-11,12,3), M.CRPS(1:end-11,12,3),1,0);

        Table_DM(i,13)=test_DM(M1.CRPS(1:end-23,24,1), M.CRPS(1:end-23,24,1),1,0);
        Table_DM(i,14)=test_DM(M1.CRPS(1:end-23,24,2), M.CRPS(1:end-23,24,2),1,0);
        Table_DM(i,15)=test_DM(M1.CRPS(1:end-23,24,3), M.CRPS(1:end-23,24,3),1,0);

    elseif  CRPS == 1

        Table_DF(i,1:3)=round(M.acrps(1,1:3),3);
        Table_DF(i,4:6)=round(M.acrps(3,1:3),3);
        Table_DF(i,7:9)=round(M.acrps(6,1:3),3);
        Table_DF(i,10:12)=round(M.acrps(12,1:3),3);
        Table_DF(i,13:15)=round(M.acrps(24,1:3),3);

        Table_DM(i,1)=test_DM(M.CRPS(:,1,4), M.CRPS(:,1,1),1,0);
        Table_DM(i,2)=test_DM(M.CRPS(:,1,5), M.CRPS(:,1,2),1,0);
        Table_DM(i,3)=test_DM(M.CRPS(:,1,6), M.CRPS(:,1,3),1,0);

        Table_DM(i,4)=test_DM(M.CRPS(1:end-2,3,4), M.CRPS(1:end-2,3,1),1,0);
        Table_DM(i,5)=test_DM(M.CRPS(1:end-2,3,5), M.CRPS(1:end-2,3,2),1,0);
        Table_DM(i,6)=test_DM(M.CRPS(1:end-2,3,6), M.CRPS(1:end-2,3,3),1,0);

        Table_DM(i,7)=test_DM(M.CRPS(1:end-5,6,4), M.CRPS(1:end-5,5,1),1,0);
        Table_DM(i,8)=test_DM(M.CRPS(1:end-5,6,5), M.CRPS(1:end-5,5,2),1,0);
        Table_DM(i,9)=test_DM(M.CRPS(1:end-5,6,6), M.CRPS(1:end-5,5,3),1,0);

        Table_DM(i,10)=test_DM(M.CRPS(1:end-11,12,4), M.CRPS(1:end-11,12,1),1,0);
        Table_DM(i,11)=test_DM(M.CRPS(1:end-11,12,5), M.CRPS(1:end-11,12,2),1,0);
        Table_DM(i,12)=test_DM(M.CRPS(1:end-11,12,6), M.CRPS(1:end-11,12,3),1,0);

        Table_DM(i,13)=test_DM(M.CRPS(1:end-23,24,4), M.CRPS(1:end-23,24,1),1,0);
        Table_DM(i,14)=test_DM(M.CRPS(1:end-23,24,5), M.CRPS(1:end-23,24,2),1,0);
        Table_DM(i,15)=test_DM(M.CRPS(1:end-23,24,6), M.CRPS(1:end-23,24,3),1,0);

    end

    Table_DM(~(Table_DM == 1 | Table_DM == 2 | Table_DM == 3)) = 0;

end

print_CRPS;

%close path
rmpath('functions');
