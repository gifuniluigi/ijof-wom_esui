function [lag]=IC(y,sent,iprice,pmax)

warning('off')
[~,n] =size(sent);
aic = zeros(n,1,pmax+1);
sic = zeros(n,1,pmax+1);
hic = zeros(n,1,pmax+1);

for j = 0:pmax
    ylag = lagmatrix(sent,0:j);
    ylag = ylag(j+1:end,:);
    Y = y(j+1:end,iprice);
    X = [ones(size(ylag,1),1) ylag];
    k = size(X,2);      %# of parameters
    b = (X'*X)\X'*Y;    %Fitted values
    e = Y-(X*b);        %Residuals
    T=length(Y);
    V = diag((e'*e)/T); %Variance
    aic(:,:,j+1) = log(V) + 2*k/T;             %Akaike Inf Crit
    sic(:,:,j+1) = log(V) + k*log(T)/T;        %Schwarz Inf Crit
    hic(:,:,j+1) = log(V) + 2*k*log(log(T))/T; %Hannan Inf Crit
end

    [~,lag]=min(min([aic sic hic])); lag=lag-1;
    

end