%%% This file produces the results reported in Table G11, proxy SV-BVAR 

clear; clc;

% Add path to functions
addpath('functions');

% Load results. Only 4SVBVARp6, 4SVBVARp9 and 4SVBVARp10 are dispalyed in
% the appendix. The other results refer to the remaining text indices.
load 4SVBVARp6


% compute and display MSPEs
T=print_MSPE(msfe);

% compute and display Diebold-Mariano test
print_dmpval(msfe,nmodel,nfore)

% latex tabel
printLatex(T)

%close path
rmpath('functions');