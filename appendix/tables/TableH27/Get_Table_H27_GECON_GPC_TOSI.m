%%% This file estimates the results reported in Table H27, GECON & GPC and TOSI

clear; 
clc;

seednumber=140778;
rand('seed',seednumber);
randn('seed',seednumber);

% Add path to functions
addpath('functions');

%-------------------------------USER INPUT--------------------------------------
nlag   = 12;        % number of lags 
nfore  = 24;        % forecast horizon
ndraws = 4000;      % number of predictive draws
%-------------------------------LOAD DATA---------------------------------------

load DataCG                                  % Sample period: 1982.01 - 2021.06

WOC=lagn(100*log(oil_variables(:,1)),1);     % World oil consumption growth (in growth rates)
GECON=oil_variables(2:end,2);                % GECON index from Baumeister et al. (2020)
oecd_inv=oil_variables(2:end,3);             % Proxy for global crude oil inventories, in changes

rwti=log(100*OilPriceVariables(2:end,1));    % Real oil price (nominal WTI deflated by US CPI, log)
rrac=log(100*OilPriceVariables(2:end,2));    % Real oil price (nominal RAC for oil imports deflated by US CPI, log)
rbrent=log(100*OilPriceVariables(2:end,3));  % Real oil price (nominal BRENT deflated by US CPI, log)

rp=[rwti rrac rbrent];   % Matrix of oil prices
YY=[WOC GECON oecd_inv]; % Fixed Matrix
t = size(YY,1);          % t time series observations
r = size(YY,2)+2;        % number of variables in VAR
ivar=3;                  % number of oil price measures
iprice=4;                % column of oil price in VAR

load BertFtTr               % Sample period: 1982.01 - 2021.06
load VaderFtTr              % Sample period: 1982.01 - 2021.06

bstvar = [BertFtTr VaderFtTr];

Sentiment = standardize(bstvar);
[~,Sentiment,~,~] = PCA(Sentiment,1);

% =========================| PRIORS |======================================
prior.a = 10;             % Intercept (V_prior)
prior.b = 0.05;           % Own AR coefficients (lambda)
prior.c = .5;             % Coefficients of other variables (theta)
prior.d = 10;             % Covariance parameters
prior.e = [0 0 0 0.99 0.99];   % Prior means on the VAR part (delta)
%======================= Recursive forecasting exercise ===================

t0=227;      % 2000.12
nmodel = 6;
y_fore = nan(t-t0,r,nfore,ndraws,nmodel);
msfe = nan(t-t0,nfore,nmodel);

for irep = t0:t-1
    disp(['Iteration n° ' num2str(irep-t0+1) '/' num2str(t-1-t0+1)]);
    Y = YY(1:irep,:); 
    yrp = rp(1:irep,:); 
    X = Sentiment(1:irep,1);
    
%%% Real spot price West Texas Intermediate
    YF = [Y rwti(1:irep,1) X];
    % Estimate BVAR-OLS with rwti + Txt
    y_fore(irep-t0+1,:,:,:,1) = BVARMINN_CCM(YF,nlag,prior.e,prior.b,prior.c,prior.a,nfore,ndraws);
    clear YF
    
%%% Real spot price RAC
    YF = [Y rrac(1:irep,1) X];
    % Estimate BVAR-OLS with rrac + Txt
    y_fore(irep-t0+1,:,:,:,2) = BVARMINN_CCM(YF,nlag,prior.e,prior.b,prior.c,prior.a,nfore,ndraws);
    clear YF
     
%%% Real spot price Brent
    YF = [Y rbrent(1:irep,1) X];    
    % Estimate BVAR-OLS with rbrent + Txt
    y_fore(irep-t0+1,:,:,:,3) = BVARMINN_CCM(YF,nlag,prior.e,prior.b,prior.c,prior.a,nfore,ndraws);
    clear YF
     
%%% Get RW forecast
    for i=1:ivar
        for ihor = 1:nfore
            y_fore(irep-t0+1,iprice,ihor,:,ivar+i) = yrp(end,i);
        end
    end
    
%%% MSPEs 
    for ihor = 1:nfore
        if irep<=t-ihor
            fore_m = zeros(ndraws,nmodel);
            y_eval = exp(rp(irep+ihor,1:ivar));
            for imodel = 1:nmodel               
                fore_m(:,imodel) = exp( squeeze(y_fore(irep-t0+1,iprice,ihor,:,imodel)) );
            end
            
            % MSPEs
            for j=1:ivar
                for imodel = j:3:nmodel
                    msfe(irep-t0+1,ihor,imodel) = ( y_eval(1,j) - mean(fore_m(:,imodel)) ).^2;
                end
            end
        end
    end
   
end

%close path
rmpath('functions'); 

% ------------------| SAVE RESULTS |---------------------
% Save results in .mat file
clear y_fore;
modname = 'SVBVAR_GECON_GPC_TOSI';
save(sprintf('%s.mat',modname),'msfe','nfore','nmodel');