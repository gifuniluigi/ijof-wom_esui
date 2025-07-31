%%% This file estimates the results reported in Table 4

clear; 
clc;

seednumber=140778;
rand('seed',seednumber);
randn('seed',seednumber);

% Add path to functions
addpath('functions');

%-------------------------------USER INPUT--------------------------------------
nlag   = 12;            % number of lags 
nfore  = 24;            % forecast horizon
ndraws = 4000;          % number of predictive draws
comb   = 'FtTrVader';   % combination newspapers
%-------------------------------LOAD DATA---------------------------------------

load Data                                    % Sample period: 1982.01 - 2021.06

qoil=lagn(100*log(oil_variables(:,1)),1);    % World oil production growth (in growth rates)
WIP=lagn(100*log(oil_variables(:,2)),1);     % World industrial production (in growth rates)
oecd_inv=oil_variables(2:end,3);             % Proxy for global crude oil inventories, in changes

rwti=log(100*OilPriceVariables(2:end,1));    % Real oil price (nominal WTI deflated by US CPI, log)
rrac=log(100*OilPriceVariables(2:end,2));    % Real oil price (nominal RAC for oil imports deflated by US CPI, log)
rbrent=log(100*OilPriceVariables(2:end,3));  % Real oil price (nominal BRENT deflated by US CPI, log)

rp=[rwti rrac rbrent];   % Matrix of oil prices
YY=[qoil WIP oecd_inv];  % Fixed Matrix
t = size(YY,1);          % t time series observations
r = size(YY,2)+2;        % number of variables in VAR
ivar=3;                  % number of oil price measures
iprice=4;                % column of oil price in VAR

load SentVar             % Sample period: 1982.01 - 2021.06
Sentiment = SentVar(2:end,1);

% Column 1: Vader (FtTr)
% Column 2: Vader (FtInd)
% Column 3: Vader (FtTrInd)
% Column 4: Opinion Sentiment (FtTr)
% Column 5: Opinion Sentiment (FtInd)
% Column 6: Opinion Sentiment (FtTrInd)
% Column 7: Bert (FtTr)
% Column 8: Bert (FtInd)
% Column 9: Bert (FtTrInd)



% =========================| PRIORS |======================================
prior.a = 10;             % Intercept
prior.b = 0.05;           % Own AR coefficients
prior.c = .5;             % Coefficients of other variables
prior.d = 10;             % Covariance parameters
prior.e = [0 0 0 0.99 0.99];   % Prior means on the VAR part
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
modname = '5SVBVAR';
save(sprintf('%s%s.mat',modname,comb),'msfe','nfore','nmodel','Sentiment');