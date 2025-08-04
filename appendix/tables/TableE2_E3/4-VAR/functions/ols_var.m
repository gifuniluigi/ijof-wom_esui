
function [beta_OLS,intercept,sigmaf] = ols_var(YF,r,nlag) 

% Obtain the errors of the VAR(1) equation
yy = YF(nlag+1:end,:);
xx = mlag2(YF,nlag); xx = [ones(size(xx(nlag+1:end,:),1),1) xx(nlag+1:end,:)];
beta_OLS = inv(xx'*xx)*(xx'*yy);
sigmaf = (yy - xx*beta_OLS)'*(yy - xx*beta_OLS)/(size(yy,1));
beta_var = kron(sigmaf,inv(xx'*xx));
intercept = beta_OLS(1,:)';
beta_OLS = [beta_OLS(2:end,:)'; eye(r*(nlag-1)), zeros(r*(nlag-1),r)];
