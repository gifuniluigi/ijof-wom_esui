%%% This file estimates the results reported in Table H28

clear; clc;

seednumber=140778;
rand('seed',seednumber);
randn('seed',seednumber);

% Add path to functions
addpath('functions');

%-------------------------------USER INPUT--------------------------------------
nlag   = 3;        % number of lags
nfore  = 24;        % forecast horizon
ndraws = 4000;      % number of predictive draws
%-------------------------------LOAD DATA---------------------------------------

load Data                                    % Sample period: 1982.01 - 2021.06

% Cut data at December 2000 (in-sample period) -> 1:228

rwti=log(100*OilPriceVariables(1:228,1));     % Real oil price (nominal WTI deflated by US CPI, log)
rbrent=log(100*OilPriceVariables(1:228,3));   % Real oil price (nominal BRENT deflated by US CPI, log)

rp=[rwti rbrent];   % Matrix of oil prices
t = size(rp,1);     % t time series observations
r = 2;              % number of variables in VAR

% load SentVar             % Sample period: 1982.01 - 2021.06
% SentVar = SentVar(1:228,:);

load SentVar
SentVar = SentVar(1:228,:);

% Coulmn 1: Sentiment Count
% Column 2: Dictionary: Financial Stability (Correa et al.[2017])
% Column 3: Dictionary: Financial Liability (Loughran and McDonald[2011])
% Column 4: Dictionary: Afinn (Nielsen[2011])
% Column 5: Dictionary: Harvard-IV (Tetlock[2007])
% Column 6: Sentiment TFM
% Column 7: Sentiment TF-IDF
% Column 8: Dictionary: VADER (Hutto and Gilbert[2014])
% Column 9: Opinion Sentiment (Hu and Liu [2014])
% Column 10: BERT

% =========================| PRIORS |======================================
prior.a = 10;          % Intercept
prior.b = 0.05;        % Own AR coefficients
prior.c = .5;          % Coefficients of other variables
prior.d = 10;          % Covariance parameters
prior.e = [0.99 0.99]; % Prior means on the VAR part for oil and text
%======================= Recursive forecasting exercise ===================

for indicator = 1:10
    disp(['Indicator n° ' num2str(indicator) '/' num2str(10)]);

    Text = TextVar(:, indicator);

    %%% Real spot price West Texas Intermediate
    YF = [rwti Text];
    % Estimate BVAR-OLS with rwti + Txt
    [Brwti, SIGMArwti] = BVARMINN_CCM(YF,nlag,prior.e,prior.b,prior.c,prior.a);
    clear YF

    %%% Real spot price Brent
    YF = [rbrent Text];
    % Estimate BVAR-OLS with rbrent + Txt
    [Brbrent, SIGMArbrent] = BVARMINN_CCM(YF,nlag,prior.e,prior.b,prior.c,prior.a);
    clear YF

    % ------------------| SAVE RESULTS |---------------------
    modname = sprintf('SVBVAR%d', indicator);
    save(sprintf('%s.mat', modname), 'Brwti', 'SIGMArwti', 'Brbrent','SIGMArbrent', 'Text');

end

%close path
rmpath('functions');