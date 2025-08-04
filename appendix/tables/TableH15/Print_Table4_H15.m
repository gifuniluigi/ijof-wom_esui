%%% This file produces the results reported in Table H15

clear; clc;

% Add path to functions
addpath('functions');

load 5SVBVARFtTrVader

% compute and display MSPEs
T=print_MSPE(msfe);

% compute and display Diebold-Mariano test
print_dmpval(msfe,nmodel,nfore)

% latex tabel
printLatex(T)

%close path
rmpath('functions');