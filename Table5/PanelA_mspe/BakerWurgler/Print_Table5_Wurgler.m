%%% This file produces the results reported in Table 5, Baker and Wurgler (BW)

clear; clc;

% Add path to functions
addpath('functions');

load 5SVBVAR_BakerWurgler

% compute and display MSPEs
T=print_MSPE(msfe);

% compute and display Diebold-Mariano test
print_dmpval(msfe,nmodel,nfore)

% latex tabel
printLatex(T)

%close path
rmpath('functions');