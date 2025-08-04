function LS = logscoreq_system(errors,V)

% computes log predictive score for full vector of variables of interest
% using the quadratic approximation of Adolfson et al. (2007)
n = size(V,1);
LS = -0.5*( n*log(2*pi) + log(det(V)) + errors'*inv(V)*errors );   % log score