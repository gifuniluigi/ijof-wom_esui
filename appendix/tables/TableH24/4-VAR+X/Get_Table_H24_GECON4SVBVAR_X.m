%%% This file estimates the results reported in Table H24, 4-SVBVARX

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

load DataPG                                  % Sample period: 1982.01 - 2021.06

qoil=lagn(100*log(oil_variables(:,1)),1);    % World oil production growth (in growth rates)
GECON=oil_variables(2:end,2);                % GECON index from Baumeister et al. (2020)
oecd_inv=oil_variables(2:end,3);             % Proxy for global crude oil inventories, in changes

rwti=log(100*OilPriceVariables(2:end,1));    % Real oil price (nominal WTI deflated by US CPI, log)
rrac=log(100*OilPriceVariables(2:end,2));    % Real oil price (nominal RAC for oil imports deflated by US CPI, log)
rbrent=log(100*OilPriceVariables(2:end,3));  % Real oil price (nominal BRENT deflated by US CPI, log)

rp=[rwti rrac rbrent];   % Matrix of oil prices
YY=[qoil GECON oecd_inv];% Fixed Matrix
t = size(YY,1);          % t time series observations
r = size(YY,2)+1;        % number of variables in VAR
ivar=3;                  % number of oil price measures
iprice=4;                % column of oil price in VAR

load UncVar              % Sample period: 1982.2 - 2021.06
Uncertainty = UncVar(2:end,1);

% Coulmn 1: Ucount
% Column 2: Boolean
% Column 3: UnTFMTX
% Column 4: UnTFIDF

% =========================| PRIORS |======================================
prior.a = 10;             % Intercept (V_prior)
prior.b = 0.05;           % Own AR coefficients (lambda)
prior.c = .5;             % Coefficients of other variables (theta)
prior.d = 10;             % Covariance parameters
prior.e = [0 0 0 0.99];   % Prior means on the VAR part (delta)
%======================= Recursive forecasting exercise ===================

t0=227;      % 2000.12
nmodel = 6;
y_fore = nan(t-t0,r,nfore,ndraws,nmodel);
msfe = nan(t-t0,nfore,nmodel);

for irep = t0:t-1
    disp(['Iteration n° ' num2str(irep-t0+1) '/' num2str(t-1-t0+1)]);
    Y = YY(1:irep,:); 
    yrp = rp(1:irep,:);    
    X = normalize(Uncertainty(1:irep,1));
    
%%% Real spot price West Texas Intermediate
    YF = [Y rwti(1:irep,1)];
    % Estimate BVAR-OLS with rwti + Txt
    y_fore(irep-t0+1,:,:,:,1) = BVARMINN_CCM(YF,X,nlag,prior.e,prior.b,prior.c,prior.a,nfore,ndraws);
    clear YF
    
%%% Real spot price RAC
    YF = [Y rrac(1:irep,1)];
    % Estimate BVAR-OLS with rrac + Txt
    y_fore(irep-t0+1,:,:,:,2) = BVARMINN_CCM(YF,X,nlag,prior.e,prior.b,prior.c,prior.a,nfore,ndraws);
    clear YF
     
%%% Real spot price Brent
    YF = [Y rbrent(1:irep,1)];    
    % Estimate BVAR-OLS with rbrent + Txt
    y_fore(irep-t0+1,:,:,:,3) = BVARMINN_CCM(YF,X,nlag,prior.e,prior.b,prior.c,prior.a,nfore,ndraws);
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
modname = '4SVBVAR_X1'; % add _X1 (e.g., 4SVBVAR_X1) if results are obtained using Ucount;
                        % add _X2 (e.g., 4SVBVAR_X2) if results are obtained using Boolean
                        % and so on...
save(sprintf('%s.mat',modname),'msfe','nfore','nmodel','Uncertainty');