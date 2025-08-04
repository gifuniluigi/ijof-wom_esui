%%% This file produces the results reported in Table 6, TOSI

clear; clc;

% Add path to functions
addpath('functions');

% Load data
load SVBVAR_GCOP_WIP

% compute and display MSPEs
T=print_MSPE(msfe);

% compute and display Diebold-Mariano test
print_dmpval(msfe,nmodel,nfore)

% latex tabel
printLatex(T)

%close path
rmpath('functions');