%%% This file produces the results reported in Tables F5 & F6, 5-BVAR

clear; clc;

% Add path to functions
addpath('functions');

% Load results: 5BVAR1 refers to results obtained using Scount.
%               5BVAR2 refers to results obtained using Dictionary: Financial Stability (Correa et al.[2017])
%               and so on...see "Get_Table" file for the name of all text series
load 5BVAR1

% compute and display MSPEs
T=print_MSPE(msfe);

% compute and display Diebold-Mariano test
print_dmpval(msfe,nmodel,nfore)

% latex tabel
printLatex(T);

%close path
rmpath('functions');