%%% This file estimates the results reported in Tables E2 & E3, 5-VAR

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

load Data                                    % Sample period: 1982.01 - 2021.06

qoil=lagn(100*log(oil_variables(:,1)),1);    % World oil production growth (in growth rates)
WIP=lagn(100*log(oil_variables(:,2)),1);     % World industrial production (in growth rates)
oecd_inv=oil_variables(2:end,3);             % Proxy for global crude oil inventories, in changes

rwti=log(100*OilPriceVariables(2:end,1));     % Real oil price (nominal WTI deflated by US CPI, log)
rrac=log(100*OilPriceVariables(2:end,2));     % Real oil price (nominal RAC for oil imports deflated by US CPI, log)
rbrent=log(100*OilPriceVariables(2:end,3));   % Real oil price (nominal BRENT deflated by US CPI, log)

rp=[rwti rrac rbrent];   % Matrix of oil prices
YY=[qoil WIP oecd_inv];  % Fixed Matrix
t = size(YY,1);          % t time series observations
r = size(YY,2)+2;        % number of variables in VAR
ivar=3;                  % number of oil price measures
iprice=4;                % column of oil price in VAR

load SentVar             % Sample period: 1982.01 - 2021.06
Sentiment = SentVar(2:end,1);   

% Coulmn 1: Scount
% Column 2: Dictionary: Financial Stability (Correa et al.[2017])
% Column 3: Dictionary: Financial Liability (Loughran and McDonald[2011])
% Column 4: Dictionary: Afinn (Nielsen[2011])
% Column 5: Dictionary: Harvard-IV (Tetlock[2007])
% Column 6: Dictionary: VADER (Hutto and Gilbert[2014])
% Column 7: SeTFMTX
% Column 8: SeTFIDF
% Column 9: BERT
% Column 10: Opinion Sentiment (Hu and Liu [2014])

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
    % Estimate VAR-OLS + rwti
    [beta_OLS,intercept,sigmaf] = ols_var(YF,r,nlag);
    y_fore(irep-t0+1,:,:,:,1) = fore_VAR(YF,intercept,beta_OLS,sigmaf,r,nlag,nfore,ndraws);
    clear YF
    
%%% Crude Oil Refinery Acquisition Costs (Imported)
    YF = [Y rrac(1:irep,1) X];
    % Estimate VAR-OLS + rrac
    [beta_OLS,intercept,sigmaf] = ols_var(YF,r,nlag);
    y_fore(irep-t0+1,:,:,:,2) = fore_VAR(YF,intercept,beta_OLS,sigmaf,r,nlag,nfore,ndraws);
    clear YF
    
%%% Real spot price Brent
    YF = [Y rbrent(1:irep,1) X];
    % Estimate VAR-OLS + rbrent
    [beta_OLS,intercept,sigmaf] = ols_var(YF,r,nlag);
    y_fore(irep-t0+1,:,:,:,3) = fore_VAR(YF,intercept,beta_OLS,sigmaf,r,nlag,nfore,ndraws);
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

% Close path
rmpath('functions');

% ------------------| SAVE RESULTS |---------------------
% Save results in .mat file
clear y_fore;
modname = '5VAR1'; % add 1 (e.g., 5VAR1) if results are obtained using Scount;
                   % add 2 (e.g., 5VAR2) if results are obtained using Dictionary: Financial Stability (Correa et al.[2017])
                   % and so on...
save(sprintf('%s.mat',modname),'msfe','nfore','nmodel','Sentiment');