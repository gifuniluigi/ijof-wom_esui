function Vol=proxy(resid,sent,iprice)
%Use text as a proxy to get a new measure of price stochastic volatility error
lag=0;
xlag = lagmatrix(sent,lag);
xlag = xlag(lag+1:end,:);
Y = resid(lag+1:end,iprice);
X = [ones(size(xlag,1),1) xlag];
b = (X'*X)\X'*Y;    
VolP=X*b;
Vol=[resid(lag+1:end,1:size(resid,2)~=iprice) VolP];

end
