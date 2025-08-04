%%% This file produces the results reported in Table H14

clear; clc;

% Add path to functions
addpath('functions');

% Load results: 4SVBVAR_X1 refers to results obtained using Scount.
%               4SVBVAR_X2 refers to results obtained using Dictionary: Financial Stability (Correa et al.[2017])
%               and so on...see "Get_Table" file for the name of all text series
%               4SVBVAR refers to results obtained through no-text data
load 4SVBVAR_X1

% compute and display MSPEs
T=print_MSPE(msfe);

% compute and display Diebold-Mariano test
print_dmpval(msfe,nmodel,nfore)

% latex tabel
printLatex(T);

%close path
rmpath('functions');