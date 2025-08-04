%%% This file estimates the results reported in Tables G9 & G10

clear;
clc;

seednumber=140778;
rand('seed',seednumber);
randn('seed',seednumber);

% Add path to functions
addpath('functions');

%-------------------------------USER INPUT---------------------------------
nlag   = 12;        % number of lags
nfore  = 1;         % forecast horizon
ndraws = 4000;      % number of predictive draws
nmodel = 4;         % number of oil price forecasts (wti and brent for each model)
ivar   = 2;                    % number of oil price measures
%-------------------------------LOAD DATA----------------------------------

% Start and end date of Covid, Russia-Ukraine war and Israel-Hamas war
events_datetime = [
    datetime(2020,1,1), datetime(2022,2,1), datetime(2023,8,1);
    datetime(2021,12,1), datetime(2023,7,1), datetime(2023,12,1)
    ];

% =========================| PRIORS |==================================
prior.a = 10;          % Intercept
prior.b = 0.05;        % Own AR coefficients
prior.c = .5;          % Coefficients of other variables
prior.d = 10;          % Covariance parameters
prior.e = [0.99 0.99]; % Prior means on the VAR part for oil and text
%==================== Recursive forecasting exercise ==================

% List of general index files
genFiles = {
    'OVX_uncertainty.xlsx',...
    'BakerWurgler_sentiment.xlsx', ...
    'GlobalEPU_uncertainty.xlsx', ...
    'BEX_sentiment.xlsx', ...
    'OPU_uncertainty.xlsx'
    };

nFiles = numel(genFiles);

% Read TOSI data
TOSI_tbl = readtable('TOSI.xlsx', 'Sheet', 1);

% Make column 1 datetime
TOSI_tbl.Date = datetime(TOSI_tbl{:,1});

% Read TOSI data
OilP_tbl = readtable('OilPrices.xlsx', 'Sheet', 1);

% Make column 1 datetime
OilP_tbl.Date = datetime(OilP_tbl{:,1});

% Preallocate cell array and arrays for storing results
alignedData = cell(nFiles, 3);         %includes datasets aligned according to the event
t0_vals = zeros(nFiles, 3);            %includes the last training point of the code

% Generates the dataset needed
DataAlign;

% Size of the datasets storage
[rows_cell, cols_cell] = size(alignedData);

for col = 1:cols_cell
    for row = 1:rows_cell
        
        disp(['Model ' num2str(row) ',' num2str(col)]);

        % Select the dataset
        dataset = alignedData{row, col};
        
        % Set the size
        t = size(dataset, 1);
        
        % Make dataset array
        dataset = dataset{:,1:end};     % overall dataset
        
        rwti   = log(100*dataset(1:end,1));  % Real oil price (nominal WTI deflated by US CPI, log)
        rbrent = log(100*dataset(1:end,2));  % Real oil price (nominal BRENT deflated by US CPI, log)

        rp=[rwti rbrent];       % Matrix of oil prices

        t0 = t0_vals(row, col); %train model up to before the event
        y_fore = nan(t-t0,size(prior.e,2),nfore,ndraws,nmodel);
        msfe = nan(t-t0,nfore,nmodel);

        for irep = t0:t-1

            disp(['Iteration n° ' num2str(irep-t0+1) '/' num2str(t-1-t0+1)]);

            Ywti   = rwti(1:irep,1);
            Ybrent = rbrent(1:irep,1);
            TOSI   = dataset(1:irep,3);
            GenIdx = dataset(1:irep,4);

            %%% Real spot price West Texas Intermediate and TOSI
            YF = [Ywti TOSI];
            % Estimate BVAR-OLS with rwti + Txt
            y_fore(irep-t0+1,:,:,:,1) = BVARMINN_CCM(YF,nlag,prior.e,prior.b,prior.c,prior.a,nfore,ndraws);
            clear YF

            %%% Real spot price Brent and TOSI
            YF = [Ybrent TOSI];
            % Estimate BVAR-OLS with rrac + Txt
            y_fore(irep-t0+1,:,:,:,2) = BVARMINN_CCM(YF,nlag,prior.e,prior.b,prior.c,prior.a,nfore,ndraws);
            clear YF

            %%% Real spot price West Texas Intermediate and general index
            YF = [Ywti GenIdx];
            % Estimate BVAR-OLS with rwti + Txt
            y_fore(irep-t0+1,:,:,:,3) = BVARMINN_CCM(YF,nlag,prior.e,prior.b,prior.c,prior.a,nfore,ndraws);
            clear YF

            %%% Real spot price Brent and general index
            YF = [Ybrent GenIdx];
            % Estimate BVAR-OLS with rrac + Txt
            y_fore(irep-t0+1,:,:,:,4) = BVARMINN_CCM(YF,nlag,prior.e,prior.b,prior.c,prior.a,nfore,ndraws);
            clear YF

            %%% MSPEs
            for ihor = 1:nfore
                if irep<=t-ihor
                    fore_m = zeros(ndraws,nmodel);
                    y_eval = exp(rp(irep+ihor,1:ivar));
                    for imodel = 1:nmodel
                        fore_m(:,imodel) = exp( squeeze(y_fore(irep-t0+1,1,ihor,:,imodel)) );
                    end

                    % MSPEs
                    for j=1:ivar
                        for imodel = j:ivar:nmodel
                            msfe(irep-t0+1,ihor,imodel) = ( y_eval(1,j) - mean(fore_m(:,imodel)) ).^2;
                        end
                    end
                end
            end

        end

        % ------------------| SAVE RESULTS |---------------------
        % Save results in .mat file
        clear y_fore;
        modname = 'SVBVARcmb';
        filename = sprintf('%s_row%d_col%d.mat', modname, row, col);
        save(filename, 'msfe', 'nfore', 'nmodel');

        % Clear variables
        clear y_fore msfe;

    end
end

%close path
rmpath('functions');