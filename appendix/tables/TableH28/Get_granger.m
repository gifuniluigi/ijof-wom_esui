%=========================================================================
%
%   Program to perform Granger causality tests on a 2-variable VAR
%   for 10 different textual variables.
%
%   For each textual variable, a VAR is estimated for:
%     (1) WTI (rwti) and (2) BRENT (rbrent).
%
%   The results (Wald test statistic and p-value) are stored in a 10x2x2 matrix:
%     results(j,:,1): results for textual variable j with WTI,
%     results(j,:,2): results for textual variable j with BRENT.
%
%=========================================================================
clear;
clc;

% Add path to functions
addpath('functions');

% Load oil price data
load Data;

% Cut data at December 2000 -> 2:228
rwti   = log(100 * OilPriceVariables(:, 1));  % Real oil price (WTI)
rbrent = log(100 * OilPriceVariables(:, 3));  % Real oil price (BRENT)
oilPrices = {rwti, rbrent};  % cell array for looping over oil price series

nText = 10;  % number of textual variables (SVBVAR1 to SVBVAR10)
nOil  = 2;   % two oil price variables

% Preallocate results: dimensions are [textual variable index, [wald, p_value], oil price index]
results = zeros(nText, 2, nOil);

% Set optimization options for fminunc
ops = optimset('LargeScale','off','Display','iter');

% Loop over each textual variable
for j = 1:nText
    % Construct the filename (e.g., 'SVBVAR1.mat', 'SVBVAR2.mat', etc.)
    filename = sprintf('All_SVBVAR%d.mat', j);
    load(filename); % This should load the variable "Text" and the initial OLS estimates "Brwti" and "Brbrent"
    
    % Loop over the two oil price variables
    for i = 1:nOil
        roil = oilPrices{i};
        y = [roil, Text];  % Construct VAR data: first column is oil price, second is text-based variable
        t = length(y);
        
        % Use the appropriate initial guess based on the oil price variable
        if i == 1
            theta0 = Brwti(:);  % For WTI
        else
            theta0 = Brbrent(:);  % For BRENT
        end
        
        % Estimate VAR(2) via maximum likelihood
        [theta1, ~, ~, ~, ~, H] = fminunc(@(b) neglog(b, y), theta0, ops);
        cov1 = (1/t) * inv(H);
        
        % Define the restriction for the Wald test (example: test that the third coefficient equals zero)
        r = zeros(1, 14);
        r(3) = 1.0;
        q = 0;
        
        % Compute the Wald test statistic and p-value
        wd = (r*theta1 - q)' * inv(r*cov1*r') * (r*theta1 - q);
        dof = size(r, 1);
        p_value = 1 - chi2cdf(wd, dof);
        
        % Store the results: first column = Wald test statistic, second column = p-value
        results(j, :, i) = [wd, p_value];
    end
end

% Save the results for later review
save('GrangerResults.mat', 'results');

Get_granger_latex;

% Remove the added functions path
rmpath('functions');