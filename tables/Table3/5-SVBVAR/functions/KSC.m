%% Draws mixture states and then volatilities using KSC algorithm
function h = KSC(v_tilda,h,Qt,states_pmean,states_pvar)
% Based on modifications of code by J. Chan / D. Korobilis

% pointers
[T, N]= size(v_tilda);

% normal mixture moments
pi =   [0.0073 .10556 .00002 .04395 .34001 .24566 .2575];
mi =   [-10.12999 -3.97281 -8.56686 2.77786 .61942 1.79518 -1.08819] - 1.2704;  
si =   [5.79596 2.61369 5.17950 .16735 .64009 .34023 1.26261];

% 1. draw mixture states from a 7-point discrete distribution
S=zeros(T,N);
for i=1:N
q = repmat(pi,T,1).*normpdf(repmat(v_tilda(:,i),1,7),repmat(h(:,i),1,7)+repmat(mi,T,1), repmat(sqrt(si),T,1));
q = q./repmat(sum(q,2),1,7);
S(:,i) = 7 - sum(repmat(rand(T,1),1,7)<cumsum(q,2),2) +1 ; 
end

% 2. draw volatilities conditional on mixture states, using CK (1994)
h = CK(v_tilda-mi(S),si(S),Qt,N,T,states_pmean,states_pvar);


%% Function for Carter and Kohn (1994) smoother
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