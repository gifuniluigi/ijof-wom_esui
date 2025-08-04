function factors = PRF(X, Y)
    % Three-Pass Regression Filter (3PRF) adapted for a single response variable
    % Inputs:
    %   X - predictor matrix (N x T)
    %   Y - response vector (1 x T)
    %   num_factors - number of common factors to estimate
    % Output:
    %   factors - estimated common factors (num_factors x T)
    nfactor = 1;
    [N, T] = size(X);

    % Step 1: First Pass Regression
    % Regress each predictor on all other predictors
    Beta1 = zeros(N, N-1);
    X_hat = zeros(N, T);
    for i = 1:N
        Xi = X;
        Xi(i, :) = []; % Exclude the ith predictor
        yi = X(i, :)'; % Response is the ith predictor
        Beta1(i, :) = Xi' \ yi;
        X_hat(i, :) = (Beta1(i, :) * Xi)';
    end

    % Step 2: Common Component Extraction
    % Perform SVD on X_hat to extract the common factors
    [U, S, V] = svd(X_hat, 'econ');
    F_hat = V(:, 1:nfactor)'; % Extract the first num_factors right singular vectors

    % Step 3: Second Pass Regression
    % Regress the single response variable on the common components
    Beta2 = F_hat' \ Y';

    % Step 4: Constructing the Common Factors
    factors = (Beta2' * F_hat);
    factors = factors';

end