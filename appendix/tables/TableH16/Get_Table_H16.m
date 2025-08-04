%%% This file estimates the results reported in Table H16

clear;
clc;

seednumber=140778;
rand('seed',seednumber);
randn('seed',seednumber);

% Add path to functions
addpath('functions');

%-------------------------------USER INPUT---------------------------------
nlag   = 12;        % number of lags
nfore  = 24;        % forecast horizon
ndraws = 2000;      % number of predictive draws
comb = 14;          % number of VARs to estimate
%-------------------------------LOAD DATA----------------------------------

load Data                                    % Sample period: 1982.01 - 2021.06

qoil=lagn(100*log(oil_variables(:,1)),1);    % World oil production growth (in growth rates)
WIP=lagn(100*log(oil_variables(:,2)),1);     % World industrial production (in growth rates)
oecd_inv=oil_variables(2:end,3);             % Proxy for global crude oil inventories, in changes

rwti=log(100*OilPriceVariables(2:end,1));    % Real oil price (nominal WTI deflated by US CPI, log)
rrac=log(100*OilPriceVariables(2:end,2));    % Real oil price (nominal RAC for oil imports deflated by US CPI, log)
rbrent=log(100*OilPriceVariables(2:end,3));  % Real oil price (nominal BRENT deflated by US CPI, log)

load TextData                                 % Sample period: 1982.02 - 2021.06                                  % Sample period: 1982.02 - 2021.06

% Coulmn 1: Scount
% Coulmn 2: Ucount
% Column 3: Boolean
% Column 4: Dictionary: Financial Stability (Correa et al.[2017])
% Column 5: Dictionary: Financial Liability (Loughran and McDonald[2011])
% Column 6: Dictionary: Afinn (Nielsen[2011])
% Column 7: Dictionary: Harvard-IV (Tetlock[2007])
% Column 8: SeTFMTX
% Column 9: UnTFMTX
% Column 10: SeTFIDF
% Column 11: UnTFIDF
% Column 12: Dictionary: VADER (Hutto and Gilbert[2014])
% Column 13: Opinion Sentiment (Hu and Liu [2014])
% Column 14: BERT                     4 = Uncertainty TF-IDF

rp = [rwti rrac rbrent];         % Matrix of oil prices
YY = [qoil WIP oecd_inv];        % Fixed Matrix
t = size(YY,1);                  % t time series observations
ivar = 3;                        % number of oil price measures
k = 5;                           % VAR size
iprice = 4;                      % column of oil price in VAR

for model = 1:comb
    disp(['Model ' num2str(model) '/' num2str(comb)]);

    % =========================| PRIORS |==================================
    prior.a = 10;                % Intercept
    prior.b = 0.05;              % Own AR coefficients
    prior.c = .5;                % Coefficients of other variables
    prior.d = 10;                % Covariance parameters
    prior.e = [0 0 0 0.99 0.99]; % Prior means on the VAR part
    %==================== Recursive forecasting exercise ==================

    t0=227;      %2000.12
    nmodel = 6;
    d_fore = nan(t-t0,k,nfore,ndraws,nmodel);
    p_fore = nan(t-t0,nfore,ndraws,nmodel);
    obs    = nan(t-t0,nfore,nmodel);
    alpl   = nan(t-t0,nfore,nmodel);
    CRPS   = nan(t-t0,nfore,nmodel);
    acrps  = nan(nfore,nmodel);
    text   = TextData(2:end,model);

    for irep = t0:t-1
        disp(['Iteration n° ' num2str(irep-t0+1) '/' num2str(t-1-t0+1)]);

        yrp = rp(1:irep,:);

        %%% Real spot price West Texas Intermediate
        YFrwti = [YY rwti text];
        % Estimate BVAR-OLS with rwti + Txt
        [Pai_rwti, SIGMA_rwti, X_FORE_rwti] = BVARMINN_CCM(YFrwti(1:irep,:),nlag,prior.e,prior.b,prior.c,prior.a,ndraws);

        %%% Real spot price RAC
        YFrrac = [YY rrac text];
        % Estimate BVAR-OLS with rrac + Txt
        [Pai_rrac, SIGMA_rrac, X_FORE_rrac] = BVARMINN_CCM(YFrrac(1:irep,:),nlag,prior.e,prior.b,prior.c,prior.a,ndraws);

        %%% Real spot price Brent
        YFrbrent = [YY rbrent text];
        % Estimate BVAR-OLS with rrac + Txt
        [Pai_rbrent, SIGMA_rbrent, X_FORE_rbrent] = BVARMINN_CCM(YFrbrent(1:irep,:),nlag,prior.e,prior.b,prior.c,prior.a,ndraws);

        % -------| Density Prediction
        YF = cat(4, YFrwti, YFrrac, YFrbrent);
        Pai_all = cat(4, Pai_rwti, Pai_rrac, Pai_rbrent);
        SIGMA_all = cat(4,SIGMA_rwti, SIGMA_rrac, SIGMA_rbrent);
        X_FORE_all = cat(4, X_FORE_rwti, X_FORE_rrac, X_FORE_rrac);

        N = size(YF,2);

        for p = 1:ivar
            for m = 1:ndraws
                B = squeeze(Pai_all(m,:,:,p)); SIGMA = squeeze(SIGMA_all(m,:,:,p));

                if N==1, B=B'; end

                % Matrices in companion form
                By = [B(2:end,:)'; eye(N*(nlag-1)) , zeros(N*(nlag-1),N)];
                Sy = zeros(N*nlag,N*nlag);
                Sy(1:N,1:N) = SIGMA;
                miu = zeros(N*nlag,1);
                miu(1:N,:) = B(1,:)';

                % Now do prediction using standard formulas (see Lutkepohl, 2005)
                VAR_MEAN = 0;
                VAR_VAR = 0;

                BB = speye(N*nlag);

                for ihor = 1:nfore % not very efficient, By^(ii-1) can be defined once
                    if irep<=t-ihor
                        VAR_MEAN =  VAR_MEAN + BB*miu;
                        FORECASTS = VAR_MEAN + (BB*By)*X_FORE_all(:,:,p)';
                        v = 4;
                        F = FORECASTS(v,1);
                        p_fore(irep-t0+1,ihor,m,p) = F;
                        YFF = [YFrwti(:,v) YFrrac(:,v) YFrbrent(:,v)];
                        obs(irep-t0+1,ihor,p:ivar:nmodel) = YFF(irep+ihor,p);
                        VAR_VAR = VAR_VAR + BB*Sy*BB';
                        dS = diag(VAR_VAR(1:N,1:N))';
                        lden = -.5*log(2*pi*dS) - .5*(YF(irep+ihor,:,p)-FORECASTS(1:N)').^2./dS;
                        d_fore(irep-t0+1,:,ihor,m,p) = lden;
                        BB = BB*By;
                    end
                end
            end
        end

        %%% Get RW forecast
        for i=1:ivar
            for ihor = 1:nfore
                if irep<=t-ihor
                    d_fore(irep-t0+1,iprice,ihor,:,ivar+i) = yrp(end,i);
                    p_fore(irep-t0+1,ihor,:,ivar+i) = yrp(end,i);
                    err=rp(irep+ihor,i)-yrp(end,i);
                    S = err'*err;
                    SIGMA = S/(size(yrp,1)-1);
                    d_fore(irep-t0+1,iprice,ihor,:,ivar+i) = -.5*log(2*pi*SIGMA) - .5*(err).^2./SIGMA;
                end
            end
        end

        %%% ALPLs
        for ihor = 1:nfore
            if irep<=t-ihor
                for imodel = 1:nmodel
                    tmpmax = max(d_fore(irep-t0+1,iprice,ihor,:,imodel));
                    alpl(irep-t0+1,ihor,imodel) = log(mean(exp(d_fore(irep-t0+1,iprice,ihor,:,imodel)-tmpmax)))+tmpmax;
                end
            end
        end

    end
    
    %%% ACRPs
    for imodel = 1:nmodel
        j=0;
        for ihor = 1:nfore
            for i = 1:(t-t0)
                CRPS(i,ihor,imodel) = pscrps_withAdj(squeeze(p_fore(i,ihor,:,imodel))',squeeze(obs(i,ihor,imodel)));
            end
            acrps(ihor,imodel) = mean(squeeze(CRPS(1:end-j,ihor,imodel)),1);
            j=j+1;
        end
    end

    % ------------------| SAVE RESULTS |---------------------
    % Save results in .mat file
    % clear d_fore;
    % Results of no-text-based SVBVAR(12) are saved as SVBVARcmb0
    modname = 'SVBVARcmb';
    save(sprintf('%s%01d.mat',modname,model),'alpl','CRPS','acrps','nfore','nmodel');
end

%close path
rmpath('functions');