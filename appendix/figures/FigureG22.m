% Comparison between TOSI and indices accounting for general sentiment and
% uncertainty

clear;clc;
addpath('Data')

% Read TOSI
TOSI = readtable('TOSI.xlsx', 'Sheet', 1, 'Range', 'A:B');
TOSI = TOSI.TOSI;

% Compute 3-Month Rolling Mean
TOSIsmooth = movmean(TOSI, 3, 'Endpoints', 'shrink');

% Compute the z-score normalization
dataMean = mean(TOSIsmooth, 'omitnan');
dataStd  = std(TOSIsmooth, 'omitnan');
TOSIsmooth = (TOSIsmooth - dataMean) / dataStd;

files = {  
    'OVX_uncertainty.xlsx',...
    'BakerWurgler_sentiment.xlsx',...
    'GlobalEPU_uncertainty.xlsx',...
    'OPU_uncertainty.xlsx',...
    'BEX_sentiment.xlsx'};
          
nFiles = length(files);

% Preallocate a cell array to store each indicator as a timetable.
TT = cell(nFiles,1);

for i = 1:nFiles
    % Read the current Excel file
    T = readtable(files{i}, 'Sheet', 1);
    
    % Convert the first column to datetime.
    dates_i = datetime(T{:,1}, 'InputFormat', 'dd-MMM-yyyy');
    
    % Extract the numeric data
    data_i = T{:,2};
    
    % Create a new table with a meaningful variable name for the indicator.
    varName = sprintf('Indicator%d', i);
    Tnew = table(dates_i, data_i, 'VariableNames', {'Date', varName});
    
    % Convert the table to a timetable, using the 'Date' column as row times.
    TT{i} = table2timetable(Tnew, 'RowTimes', 'Date');
end

% Merge all timetables over the union of dates.
TAll = TT{1};

% For each additional timetable, synchronize with TAll.
for i = 2:nFiles
    TAll = synchronize(TAll, TT{i}, 'union');
end

% Identify Indicator Variables
indicatorVars    = TAll.Properties.VariableNames(1:end);
smoothedNormData = TAll(:, 1:end);

% Loop Over Each Indicator, apply 3-Month Rolling Mean and Z-Score
for i = 1:numel(indicatorVars)

    % Extract the raw indicator data as a column vector
    rawData = TAll.(indicatorVars{i});
    
    % Compute the 3-month rolling mean.
    smoothedData = movmean(rawData, 3, 'Endpoints', 'shrink');
    
    % Compute the z-score normalization
    dataMean = mean(smoothedData, 'omitnan');
    dataStd  = std(smoothedData, 'omitnan');
    normalizedData = (smoothedData - dataMean) / dataStd;
    
    % Store the normalized series
    smoothedNormData.(indicatorVars{i}) = normalizedData;
end

% Aggregate Across Indicators (Row-by-Row)
dataMatrix = smoothedNormData{:,:};

% Compute the row-wise minimum, mean, and maximum, ignoring any NaNs.
minVals  = min(dataMatrix, [], 2, 'omitnan');
meanVals = mean(dataMatrix, 2, 'omitnan');
maxVals  = max(dataMatrix, [], 2, 'omitnan');

% Create a New Timetable for the Aggregated Results
TAllAggregated = timetable(TAll.Properties.RowTimes, minVals, meanVals, maxVals, ...
    'VariableNames', {'Min', 'Mean', 'Max'});

% Extract the time vector from TAllAggregated.
timeVec = TAllAggregated.Properties.RowTimes;

% Extract the Min and Max series.
minSeries = TAllAggregated.Min;
maxSeries = TAllAggregated.Max;

% Prepare data for the filled area:
% Create vectors that go from the first to the last date, and then back in reverse.
xFill = [timeVec; flipud(timeVec)];
yFill = [minSeries; flipud(maxSeries)];

% Create a new figure.
figure;
hold on;

% Plot the filled area between Min and Max.
% The fill function requires x and y as numeric vectors. With datetime x-axis, fill works as well.
hFill = fill(xFill, yFill, [0.8, 0.8, 0.8], 'EdgeColor', 'none', 'FaceAlpha', 0.5);

% Plot TOSIsmooth on top. (Assuming TOSIsmooth is a vector aligned with timeVec.)
hTOSI = plot(timeVec, TOSIsmooth, 'b-', 'LineWidth', 3);

% Optionally, add the cross-sectional mean from TAllAggregated.
hMean = plot(timeVec, TAllAggregated.Mean, 'r--', 'LineWidth', 3);

% Set the axis tick label sizes
ax = gca;
ax.FontSize = 26;

box on;
ylims = ylim;

% 1. Missile attacks on Iran - 01-Apr-1984
xEvent = datetime('01-Apr-1984','InputFormat','dd-MMM-yyyy');
plot([xEvent xEvent], ylims, 'k--', 'LineWidth', 1);
text(xEvent-160, mean(ylims), 'Civilian truce Iran - Iraq war', ...
    'Color', 'k', 'FontSize', 26, 'Rotation', 90, ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');

% 2. Asian economic crisis - 01-Jan-1998
xEvent = datetime('01-Jan-1998','InputFormat','dd-MMM-yyyy');
plot([xEvent xEvent], ylims, 'k--', 'LineWidth', 1);
text(xEvent-160, mean(ylims), 'Asian economic crisis', ...
    'Color', 'k', 'FontSize', 26, 'Rotation', 90, ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');

% 3. Opec's cut - 01-Apr-2001
xEvent = datetime('01-Apr-2001','InputFormat','dd-MMM-yyyy');
plot([xEvent xEvent], ylims, 'k--', 'LineWidth', 1);
text(xEvent-160, mean(ylims)-1, 'Opec''s cut', ...
    'Color', 'k', 'FontSize', 26, 'Rotation', 90, ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');

% 4. Iraq war - 01-Feb-2003
xEvent = datetime('01-Feb-2003','InputFormat','dd-MMM-yyyy');
plot([xEvent xEvent], ylims, 'k--', 'LineWidth', 1);
text(xEvent-160, mean(ylims), 'Iraq war', ...
    'Color', 'k', 'FontSize', 26, 'Rotation', 90, ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');

% 5. Venezuelan protests - 01-Jun-2016
xEvent = datetime('01-Jun-2016','InputFormat','dd-MMM-yyyy');
plot([xEvent xEvent], ylims, 'k--', 'LineWidth', 1);
text(xEvent-160, mean(ylims), 'Venezuelan protests', ...
    'Color', 'k', 'FontSize', 26, 'Rotation', 90, ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');

% 6. Covid - 19 - 01-Apr-2020
xEvent = datetime('01-Apr-2020','InputFormat','dd-MMM-yyyy');
plot([xEvent xEvent], ylims, 'k--', 'LineWidth', 1);
text(xEvent-160, mean(ylims)-2, 'COVID - 19', ...
    'Color', 'k', 'FontSize', 26, 'Rotation', 90, ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');

% 7. Global oil production increase - 01-May-2021
xEvent = datetime('01-May-2021','InputFormat','dd-MMM-yyyy');
plot([xEvent xEvent], ylims, 'k--', 'LineWidth', 1);
text(xEvent-160, mean(ylims), 'Global oil production increase', ...
    'Color', 'k', 'FontSize', 26, 'Rotation', 90, ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');

% 8. Israel - Hamas war - 01-Nov-2023
xEvent = datetime('01-Nov-2023','InputFormat','dd-MMM-yyyy');
plot([xEvent xEvent], ylims, 'k--', 'LineWidth', 1);
text(xEvent-160, mean(ylims), 'Israel - Hamas war', ...
    'Color', 'k', 'FontSize', 26, 'Rotation', 90, ...
    'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle');

% Add labels and title.
hTitle = title({'TOSI versus alternative market sentiment and uncertainty indicators';''});

legend([hFill, hMean, hTOSI], {'General proxies min - max', 'General proxies mean', 'TOSI'}, 'Location', 'Best');

hold off;

rmpath('Data')