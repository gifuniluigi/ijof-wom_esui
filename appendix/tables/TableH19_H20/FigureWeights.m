
% Add path to functions
addpath('functions');

% Load the data from the Excel file
data = readtable('Weights.xlsx');

% Convert the first column to datetime format
data.Date = datetime(data.Date, 'InputFormat', 'yyyy-MM-dd'); % Adjust format if needed

% Extract date and weight values
dates = data.Date;
weights = data{:,2}; % Assuming weights are in the second column

smoothed_weights = movmean(weights, 3);

% Create the plot
figure;
plot(dates, smoothed_weights, 'k--', 'LineWidth', 3); % Black dashed line for smoothed series

% Format the plot
title({'Weighting Scheme';''});
grid on;
grid minor;
datetick('x', 'yyyy', 'keeplimits'); % Display years on x-axis
xlim([min(dates), max(dates)]);
ylim([min(weights), max(weights)]);

% Improve readability
set(gca, 'FontSize', 20);

%close path
rmpath('functions');
