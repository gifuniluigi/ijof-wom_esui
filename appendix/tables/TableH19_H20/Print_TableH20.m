%%% This file produces the results reported in Table in the Appendix

clear; clc;

% Add path to functions
addpath('functions');

% Number of datasets
numFiles = 14;

% Store results
Table_DF = zeros(numFiles, 10); % Assuming 5 time horizons for 2 oil price measures
Table_DM = zeros(numFiles, 10); % Assuming 5 time horizons for 2 oil price measures

for i = 1:numFiles

    % Load data
    % After saving the results from the previous file, the name and the order
    % of .mat files has been changed to reflect the one reported in the appendix
    filename = sprintf('5SVBVAR%d.mat', i);
    M = load(filename);
    
    % Results of models with no text
    M_NoText = load('SVBVAR0');
    M_NoText.msfe   = M_NoText.msfe(:,:,[1 3]);
    M_NoText.acrps  = M_NoText.nfore;
    M_NoText.nmodel = 2;

    % Results of random walk models
    M_rw.msfe   = M.msfe(:,:,[4 6]);
    M_rw.nfore  = M.nfore;
    M_rw.nmodel = 2;

    % Results of text-based models
    M.msfe=M.msfe(:,:,[1 3]);
    M.nfore=M.nfore;
    M.nmodel=2;

    % compute MSPEs
    MSPE=print_MSPE(cat(3,M.msfe, M_NoText.msfe));

    % compute Diebold-Mariano test
    DM_vs_rw = print_dmpval(cat(3,M.msfe, M_NoText.msfe),M.nmodel+M_NoText.nmodel,M.nfore);

    % Store the result in TableDF_all
    Table_DF(i, :) = MSPE;
    Table_DM(i, :) = DM_vs_rw;
end

print_MSPE_TableH20;

% Close path
rmpath('functions');
