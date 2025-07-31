% ========================================================================
%
%   Algorithm to estimate the FVAR model of Stock and Watson
%
% ========================================================================

function s = SW(y)

% Standardize the data
y  = zscore(y);
[~ , n] = size( y );         % Number of dependent variables
k = 1;                       % Number of factors (chosen to be 3 here)

lam = zeros( n,k );
gam = zeros( n,n );

lamnew = lam;
gamnew = gam;

maxiter = 100;       % Maximum number of iterations
tol     = 1e-3;      % Convergence criterion

% Estimate F-VAR parameters using the Stock-Watson algorithm

iter = 1;

while iter <= maxiter
    
    % Principal component analysis
    [ va,ve ] = eigs(corrcoef( y ) );
    s         = y*va(:,1:k);

    % Regressions on measurement equations
    for i = 1:n
        ylag = trimr(y(:,i),0,1);
        b    =  [ trimr(s,1,0) ylag ]\trimr(y(:,i),1,0);
        lam(i,:) = b(1:k)';
        gam(i,i) = b(k+1)';
        y(:,i)   = y(:,i) - gam(i,i)*( [0.0 ; ylag]);
    end

    % Check for convergence
    if sqrt(sum(vec(lam-lamnew).^2)) < tol && sqrt(sum(vec(gam-gamnew).^2)) < tol
        break
    else
        lamnew = lam;
        gamnew = gam;
    end
    iter = iter+1;
end

%=========================================================================
% Returns a matrix (or vector) stripped of the specified rows
%
%   Inputs:
%             x  = input matrix (or vector) (n x k)
%             rb = first n1 rows to strip
%             re = last  n2 rows to strip
%
%  Mimics the Gauss routine.
%=========================================================================
    function z = trimr(x,rb,re)


        l = length(x);
        if (rb+re) >= l
            error('Attempting to trim too much');
        end

        z = x(rb+1:l-re,:);

    end

%=========================================================================
%
% Column stack a matrix for agree with GAUSS vec command
%
%=========================================================================
    function y = vec(x)

        a = numel(x) ;
        y = reshape( x,[a,1] );

    end
end