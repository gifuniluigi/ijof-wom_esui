%%% This file produces the results reported in Table H17, Panel A

clear; clc;

% Add path to functions
addpath('functions');

% Load data
% Load the same model without and with TOSI (e.g. cmb1 is without TOSI,
% cmb2 is with TOSI; cmb3 is without TOSI, cmb4 is with TOSI and so on...)
M1 = load('SVBVARcmb1.mat');
M2 = load('SVBVARcmb2.mat');

% ALPL = 0 for No-Tosi vs. Tosi comparison
% ALPL = 1 for RW vs. Tosi comparison

ALPL = 1;

if ALPL == 1

    % compute and display MSPEs
    LogDF(M1,M2);

elseif ALPL == 0

    M1.CRPS=M2.CRPS(:,:,4:6);
    M1.acrps=M2.acrps(:,4:6);
    M1.alpl=M2.alpl(:,:,4:6);
    M1.nfore=M2.nfore;
    M1.nmodel=3;
    
    M2.CRPS=M2.CRPS(:,:,1:3);
    M2.acrps=M2.acrps(:,1:3);
    M2.alpl=M2.alpl(:,:,1:3);
    M2.nfore=M2.nfore;
    M2.nmodel=3;
    
    % compute and display MSPEs
    LogDF(M1,M2);
end

% Results in the command window:
% 1 = blue cell in the manuscript
% 2 = red cell in the manuscript
% 3 = yellow cell in the manuscript

%close path
rmpath('functions');
