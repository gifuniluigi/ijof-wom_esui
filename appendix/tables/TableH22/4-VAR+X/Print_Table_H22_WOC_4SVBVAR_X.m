%%% This file produces the results reported in Table H22, 4-SVBVARX

clear; clc;

% Add path to functions
addpath('functions');

% Load results: 4SVBVAR_X1 refers to results obtained using Ucount.
%               4SVBVAR_X2 refers to results obtained using Boolean
%               and so on...see "Get_Table" file for the name of all text series
load 4SVBVAR_X1

% compute and display MSPEs
T=print_MSPE(msfe);

% compute and display Diebold-Mariano test
print_dmpval(msfe,nmodel,nfore)

% latex tabel
printLatex(T)

%close path
rmpath('functions');