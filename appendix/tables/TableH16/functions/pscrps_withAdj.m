function crps = pscrps_withAdj(forecasts, obs)
% This function calculates Continuous-Ranked Probability Score
% with penalty as in Gneiting and Raftery (JASA)

[M, S] = size(forecasts);
N = length(obs);

if (M ~= N)
    error('Length of OBS must match number of rows in FORECASTS');
end

crps_individual = zeros(1, N);
for i = 1:N
    crps1 = mean(abs(forecasts(i, :) - obs(i)));
    crps2 = mean(abs(diff(forecasts(i, randperm(S)))));
    crps_individual(i) = crps1 - 0.5*crps2;
end
crps = mean(crps_individual);
