function [y_fore] = fore_VAR(YF,intercept,beta_t,Q_t,r,nlag,nfore,ndraws)
  
X_fore = [];   
for i = 1:nlag       
    X_fore = [X_fore, [YF(end-i+1,:)]];
end
y_fore  = zeros(r,nfore,ndraws);
VAR_mean = 0; VAR_var = 0; miu = [intercept(:,end); zeros(r*(nlag-1),1)];
By = beta_t(:,:,end); BB = eye(r*nlag);
Sy = zeros(r*nlag,r*nlag);
Sy(1:r,1:r) = Q_t(:,:,end);
for ihor = 1:nfore       
    VAR_mean = VAR_mean + BB*miu;
    VAR_FORECAST = VAR_mean + BB*By*X_fore';
    VAR_var = VAR_var + BB*Sy*BB';
    if ndraws == 1
        y_fore(:,ihor,:) = VAR_FORECAST(1:r);
    else
        y_fore(:,ihor,:) = repmat(VAR_FORECAST(1:r),1,ndraws) +  chol(VAR_var(1:r,1:r))'*randn(r,ndraws);
    end
    BB = BB*By;
end

if ndraws == 1
    y_fore = squeeze(y_fore);
end

