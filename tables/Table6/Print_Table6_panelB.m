%%% This file produces the results reported in Table 6, panel B

clear; clc;

% Add path to functions
addpath('functions');

% Load data
% Load the same model without and with TOSI (e.g. cmb1 is without TOSI,
% cmb2 is with TOSI; cmb3 is without TOSI, cmb4 is with TOSI and so on...)

load SVBVARcmb1
CRPS_NoTosi = CRPS;

load SVBVARcmb2

MSPE=zeros(1,10);

MSPE(1,1:2)=round(acrps(1,[1 3]),3);
MSPE(1,3:4)=round(acrps(3,[1 3]),3);
MSPE(1,5:6)=round(acrps(6,[1 3]),3);
MSPE(1,7:8)=round(acrps(12,[1 3]),3);
MSPE(1,9:10)=round(acrps(24,[1 3]),3);

MSPE

% P-value random walk comparison
Pvalue_RW=zeros(1,10);
Pvalue_RW(1,1)=test_DM(CRPS(:,1,4), CRPS(:,1,1),1,0);
Pvalue_RW(1,2)=test_DM(CRPS(:,1,6), CRPS(:,1,3),1,0);

Pvalue_RW(1,3)=test_DM(CRPS(1:end-2,3,4), CRPS(1:end-2,3,1),1,0);
Pvalue_RW(1,4)=test_DM(CRPS(1:end-2,3,6), CRPS(1:end-2,3,3),1,0);

Pvalue_RW(1,5)=test_DM(CRPS(1:end-5,6,4), CRPS(1:end-5,5,1),1,0);
Pvalue_RW(1,6)=test_DM(CRPS(1:end-5,6,6), CRPS(1:end-5,5,3),1,0);

Pvalue_RW(1,7)=test_DM(CRPS(1:end-11,12,4), CRPS(1:end-11,12,1),1,0);
Pvalue_RW(1,8)=test_DM(CRPS(1:end-11,12,6), CRPS(1:end-11,12,3),1,0);

Pvalue_RW(1,9)=test_DM(CRPS(1:end-23,24,4), CRPS(1:end-23,24,1),1,0);
Pvalue_RW(1,10)=test_DM(CRPS(1:end-23,24,6), CRPS(1:end-23,24,3),1,0);

Pvalue_RW

% P-value No-Tosi comparison
Pvalue_NoTOSI=zeros(1,10);
Pvalue_NoTOSI(1,1)=test_DM(CRPS_NoTosi(:,1,1), CRPS(:,1,1),1,1);
Pvalue_NoTOSI(1,2)=test_DM(CRPS_NoTosi(:,1,3), CRPS(:,1,3),1,1);

Pvalue_NoTOSI(1,3)=test_DM(CRPS_NoTosi(1:end-2,3,1), CRPS(1:end-2,3,1),1,1);
Pvalue_NoTOSI(1,4)=test_DM(CRPS_NoTosi(1:end-2,3,3), CRPS(1:end-2,3,3),1,1);

Pvalue_NoTOSI(1,5)=test_DM(CRPS_NoTosi(1:end-5,6,1), CRPS(1:end-5,6,1),1,1);
Pvalue_NoTOSI(1,6)=test_DM(CRPS_NoTosi(1:end-5,6,3), CRPS(1:end-5,6,3),1,1);

Pvalue_NoTOSI(1,7)=test_DM(CRPS_NoTosi(1:end-11,12,4), CRPS(1:end-11,12,1),1,1);
Pvalue_NoTOSI(1,8)=test_DM(CRPS_NoTosi(1:end-11,12,6), CRPS(1:end-11,12,3),1,1);

Pvalue_NoTOSI(1,9)=test_DM(CRPS_NoTosi(1:end-23,24,4), CRPS(1:end-23,24,1),1,1);
Pvalue_NoTOSI(1,10)=test_DM(CRPS_NoTosi(1:end-23,24,6), CRPS(1:end-23,24,3),1,1);

Pvalue_NoTOSI

%close path
rmpath('functions');
