%%% This file produces the results reported in Table H21, 5-SVBVAR

clear; clc;

% Add path to functions
addpath('functions');

% Load results: 5SVBVAR1 refers to results obtained using Scount.
%               5SVBVAR2 refers to results obtained using Dictionary: Financial Stability (Correa et al.[2017])
%               and so on...see "Get_Table" file for the name of all text series
load 5SVBVAR10

% compute and display MSPEs
T=print_MSPE(msfe);

% compute and display Diebold-Mariano test
print_dmpval(msfe,nmodel,nfore)

% latex tabel
printLatex(T);

%close path
rmpath('functions');