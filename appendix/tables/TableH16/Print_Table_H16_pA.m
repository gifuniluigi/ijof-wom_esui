%%% This file produces the results reported in Table H16, Panel A

clear; clc;

% Add path to functions
addpath('functions');

% ALPL = 0 for No-Tosi vs. Tosi comparison
% ALPL = 1 for RW vs. Tosi comparison
ALPL = 0;

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

    if ALPL == 0
        
        M1 = load('SVBVARcmb0');
        M1.CRPS=M1.CRPS(:,:,1:3);
        M1.acrps=M1.acrps(:,1:3);
        M1.alpl=M1.alpl(:,:,1:3);
        M1.nmodel=3;

        M2.CRPS=M.CRPS(:,:,4:6);
        M2.acrps=M.acrps(:,4:6);
        M2.alpl=M.alpl(:,:,4:6);
        M2.nfore=M.nfore;
        M2.nmodel=3;

        % compute and display MSPEs
        [Table_df, Table_dm] = LogDF(M1,M2);

    elseif ALPL == 1

        M1.CRPS=M.CRPS(:,:,4:6);
        M1.acrps=M.acrps(:,4:6);
        M1.alpl=M.alpl(:,:,4:6);
        M1.nfore=M.nfore;
        M1.nmodel=3;

        M2.CRPS=M.CRPS(:,:,1:3);
        M2.acrps=M.acrps(:,1:3);
        M2.alpl=M.alpl(:,:,1:3);
        M2.nfore=M.nfore;
        M2.nmodel=3;

        % compute and display MSPEs
        [Table_df, Table_dm] = LogDF(M1,M2);
    end

    % Store the result in TableDF_all
    Table_DF(i, :) = Table_df;
    Table_DM(i, :) = Table_dm;
end

print_ALPL;

% Close path
rmpath('functions');
