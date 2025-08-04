%%% This file produces the results reported in Tables E2 & E3, 5-VAR

clear; clc;

% Add path to functions
addpath('functions');

% Load results: 5VAR1 refers to results obtained using Scount.
%               5VAR2 refers to results obtained using Dictionary: Financial Stability (Correa et al.[2017])
%               and so on...see "Get_Table" file for the name of all text series
load 5VAR1

% compute and display MSPEs
T=print_MSPE(msfe);

% compute and display Diebold-Mariano test
print_dmpval(msfe,nmodel,nfore)

% latex tabel
printLatex(T)

%close path
rmpath('functions');