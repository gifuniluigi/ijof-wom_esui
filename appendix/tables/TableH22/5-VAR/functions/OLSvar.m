function r = OLSvar(y,lags,Hmax)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function maximizes the ML of a VAR with MN prior with respect to the
% prior hyperparameters.
%
% ydata:    dependent variable data matrix
%
% lags:     number of lags in the VAR
%
% mn.psi:   0 = ML not maximized with respect to psi (which is set so that 
%               psi/(d-n-1) equals the residual variance of an AR(1))
%           1 = ML maximized also with respect to psi
%
% Mmax:       Max horizon for which the code must produce forecasts

% dimensions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[TT,n]=size(y);
k=n*lags+1;


% data matrices manipulations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=zeros(TT,k);
x(:,1)=1;
for i=1:lags
    x(:,1+(i-1)*n+1:1+i*n)=lag(y,i);
end

x=x(lags+1:end,:);
y=y(lags+1:end,:);
[T,n]=size(y);

% output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% posterior mode of the VAR coefficients
betahat=(x'*x)\(x'*y);


Y=[y;zeros(Hmax,n)];
for tau=1:Hmax
    xT=[1;reshape(Y([T+tau-1:-1:T+tau-lags],:)',k-1,1)]';
    Y(T+tau,:)=xT*betahat;
end
r.forecast=Y(T+1:end,:);