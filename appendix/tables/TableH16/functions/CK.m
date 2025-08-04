function St_draw = CK(y,Ht,Qt,N,T,S0,P0)

% transpose input
y=y';

% prepare matrices for storage 
St_collect = zeros(N,T);  Pt_collect = zeros(N,N,T); St_draw = zeros(N,T); 

% forward recursions (Kalman filter)
St = S0; Pt = P0; 
for t=1:T       
    % prediction using transition equation (prior)
    St_1 = St; Pt_1 = Pt + Qt;       
    % use observation equation to compute forecast error and Kalman gain
    vt = y(:,t) - St_1;              % conditional forecast error
    Varvt = Pt_1 + diag(Ht(t,:));    % variance of forecast error    
    Kt=Pt_1/Varvt;                   % Kalman Gain
    % update
    St = St_1 + Kt*vt; Pt = Pt_1 - Kt*Pt_1;
    % store
    St_collect(:,t) = St; Pt_collect(:,:,t) = Pt;    
end

% Backward simulation
St_draw(:,T) =St_collect(:,T) + chol(Pt_collect(:,:,T),'lower')*randn(N,1); 
for t=T-1:-1:1   
    % compute moments
    Kt    = Pt_collect(:,:,t)/(Pt_collect(:,:,t) + Qt);
    Smean = St_collect(:,t)   + Kt*(St_draw(:,t+1) - St_collect(:,t)); 
    Svar  = Pt_collect(:,:,t) - Kt*Pt_collect(:,:,t); 
    % draw and store
    St_draw(:,t) = Smean + chol(Svar,'lower')*randn(N,1);     
end

% transpose output
St_draw=St_draw';