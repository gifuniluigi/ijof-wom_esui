%--------------------------- Functions ----------------------------------
%
%--------------------------------------------------------------------------
% Log-likelihood function for an unrestricted VARMA model
%--------------------------------------------------------------------------
function f = neglog( b,y )

[ t,n ] = size( y );
v       = zeros( t,2 );
lf      = zeros( t-4,1 );

% First loop over MA part
for i = 4:t
    % Equation 1: v(i,1) uses coefficients 1 to 25
    v(i,1) = y(i,1) -  b(1)-  b(2)*y(i-1,1) -  b(3)*y(i-1,2) - ...
                              b(4)*y(i-2,1) -  b(5)*y(i-2,2) - ...
                              b(6)*y(i-3,1) -  b(7)*y(i-3,2);
                             

    % Equation 2: v(i,2) uses coefficients 26 to 50
    v(i,2) = y(i,2) -  b(8)-  b(9)*y(i-1,1) -  b(10)*y(i-1,2) - ...
                              b(11)*y(i-2,1) -  b(12)*y(i-2,2) - ...
                              b(13)*y(i-3,1) -  b(14)*y(i-3,2);
                              
end

v  = trimr( v,2,0 );
vc = v'*v/length(v);

for i = 1:t-2;

    lf(i) = -0.5*n*log(2*pi) - 0.5*log(det(vc)) ...
        - 0.5*v(i,:)*inv(vc)*v(i,:)';
end
f = -mean( lf );
end