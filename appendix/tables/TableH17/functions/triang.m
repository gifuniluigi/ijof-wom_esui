function PAI=triang(Y,X,N,K,T,invA_,sqrt_ht,iV,iVb_prior)
% =========================================================================
% Performs a draw from the conditional posterior of the VAR conditional
% mean coefficients by using the triangular algorithm. The
% triangularization achieves computation gains of order N^2 where N is the
% number of variables in the VAR. Carriero, Clark and Marcellino (2015),
% Large Vector Autoregressions with stochastic volatility and flexible
% priors. 
%
% The model is:
%
%     Y(t) = Pai(L)Y(t-1) + v(t); Y(t) is Nx1; t=1,...,T, L=1,...,p.
%     v(t) = inv(A)*(LAMBDA(t)^0.5)*e(t); e(t) ~ N(0,I);
%                _                                         _
%               |    1          0       0       ...      0  |
%               |  A(2,1)       1       0       ...      0  |
%      A =      |  A(3,1)     A(3,2)    1       ...      0  |
%               |   ...        ...     ...      ...     ... |
%               |_ A(N,1)      ...     ...   A(N,N-1)    1 _|
%
%     Lambda(t)^0.5 = diag[sqrt_h(1,t)  , .... , sqrt_h(N,t)];
%
% INPUTS
% Data and pointers:
% Y     = (TxN) matrix of data appearing on the LHS of the VAR
% X     = (TxK) matrix of data appearing on the RHS of the VAR
% N     = scalar, #of variables in VAR 
% K     = scalar, #of regressors (=N*p+1)  
% T     = scalar, #of observations
% The matrix X needs to be ordered as: [1, y(t-1), y(t-2),..., y(t-p)]
% 
% Error variance stuff:
% invA_   = (NxN) inverse of lower triangular covariance matrix A
% sqrt_ht = (TxN) time series of diagonal elements of volatility matrix 
% For a homosckedastic system, with Sigma the error variance, one can
% perform the LDL decomposition (command [L,D]=LDL(Sigma)) and set inv_A=L
% and sqrt_ht=repmat(sqrt(diag(D)'),T,1). 
%
% Priors:
% iV          = (NKxNK) precision matrix for VAR coefficients 
% iVB_prior   = (NKx1) (prior precision)*(prior mean)
% Note 1:iV is the inverse of the prior matrix and iVB_prior is the product
% of iV and the prior mean vector, which both need to be computed only once,
% before the start of the main MCMC loop.
% Note 2:in this code, iV is assumed block-diagonal. This implies that the
% prior is independent across equations. This includes most of the priors 
% usually considered, including the Minnesota one.  To use a non-block
% diagonal iV one needs to modify the code using the recursions illustrated 
% in equations (37) and (38).  
%
% OUTPUT
% One draw from (PAI|A,Lambda,data)
% PAI=[Pai(0), Pai(1), ..., Pai(p)].
% =========================================================================
PAI=zeros(K,N);
for j=1:N
    
    % iteratively compute previous equation residuals and rescale the data.
    % *** This is the sub-loop giving O(N^2) computational gains *** 
    Yr= Y(:,j);  
    if j==1; resid=zeros(T,N);
    else for l=1:j-1; Yr= Yr-invA_(j,l)*(sqrt_ht(:,l).*resid(:,l)); end
    end
    Yr= Yr./sqrt_ht(:,j); Xr= X./repmat(sqrt_ht(:,j),1,K);
    
    % index to select equation j coefficients from general specification
    index=K*(j-1)+1:(K*(j-1)+K);
    
    % perform the draw of PAI(equation j)|Pai(equations 1,...,j-1) 
    %tic;
    V_post = (iV(index,index) + Xr'*Xr)\eye(K); % equation 33
    b_post = V_post*(iVb_prior(index) + Xr'*Yr); % equation 32
    pai_j  = b_post + chol(V_post,'lower')*randn(K,1); % draw
    %toc;
    
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % This the analog code I would use to break down the estimation within
%     % an equation one variable at a time 
%     this_iV  = iV(index,index);
%     this_iVb = iVb_prior(index);
%     tic;
%     for jj = 1:length(index)
%         % Step 1. Rotate the data
% %         q1 = Xr(:,jj)./norm(Xr(:,jj));
% %         tmp   = randn(T,length(index)-1);
% %         [Q,~] = qr([q1 tmp]);
% %         Q2 = Q(:,2:end);
% %         Q  = [q1,Q2];
% 
%         % This is how we used to do it with eig, but eig is 4 times slower
%         % than QR
% %         q1 = Xr(:,jj)./norm(Xr(:,jj));
% %         tmp=eye(T)-q1*q1';
% %         % This is the bottleneck
% %         [V,D]=eig(tmp);
% %         Q2 = V(:,setdiff((1:T),round(diag(D))==0));
% %         Q  = [q1,Q2];
% 
%         % Or alternatively this, which used a function grams and is a lot slower
%         q1 = Xr(:,jj)./norm(Xr(:,jj));
%         tmp = randn(T,T-1);
%         Q  = grams([q1,tmp]')'; % grams makes the rows of Q orthonormal, so transposing Q to make its columns orthonormal
%         Q2 = Q(:,2:end);
%         Q  = [q1,Q2];
%         
%         % Define \beta_{(-j)} and X_{(-j)}
%         X_diff = Xr(:,setdiff(1:length(index),jj));
%         
%         % Define matrices for the rotated/rescaled regression model
%         y_til  = Q2'*Yr;
%         y_star = q1'*Yr;
%         X_til  = Q2'*X_diff;
%         x_new  = q1'*X_diff;
%         alpha  = norm(Xr(:,jj));
%         
%         
%         
%         V_overline_inv = this_iV(setdiff(1:length(index),jj),setdiff(1:length(index),jj)) + (X_til'*X_til);
%         V_overline     = V_overline_inv\eye(size(V_overline_inv,1));
%         mu_overline    = V_overline*(X_til'*y_til);
%         
%         mu   = x_new*mu_overline;
%         tau2 = (1+(x_new*V_overline*x_new'));
%         
%         psi_j(jj) = 1/(this_iV(jj,jj) + (alpha^2)/tau2);
%         m_j(jj)   = psi_j(jj)*alpha/tau2*(y_star-mu);
%         
%         %beta_sep(i,j) = m_j(j) + chol(psi_j(j))'*randn;
%     end
%     toc;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % The 2 lines below perform a draw from pai_j using a formula similar
    % to that in footnote 5, but equation by equation. These 2 lines are
    % based on inv(Chol_precision)*inv(Chol_precision)'=chol(V_post,'lower')*chol(V_post,'lower')'
    % Using these 2 lines will give further (but minor) speed improvements. 
    % Chol_precision = chol(iV(index,index) + Xr'*Xr);
    % pai_j = Chol_precision\((Chol_precision'\(iVb_prior(index) + Xr'*Yr)) + randn(K,1));
    
    % save residuals and present draw of pai_j
    resid(:,j)=Yr-Xr*pai_j; % store residuals to be removed in next equation
    PAI(:,j) = pai_j;       % store the draw of PAI  
    
end
            
