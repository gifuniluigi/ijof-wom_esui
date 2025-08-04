%%% This file produces the results reported in Tables G9 & G10

clear; clc;

% Add path to functions
addpath('functions');

oil_p = 1; % 1 for WTI and 2 for Brent

% Dimensions for the 6 files: 2 rows and 3 columns.
nFileRows = 5;
nFileCols = 3;
formattedVals = cell(nFileRows, nFileCols);

addpath('functions');
% Loop over the 2 x 3 files
for r = 1:nFileRows
    for c = 1:nFileCols

        % Construct the filename
        filename = sprintf('SVBVARcmb_row%d_col%d.mat', r, c);
        % Load the .mat file (assumes it contains MSPE and DM_int)
        data = load(filename);

        % compute MSPEs
        data.MSPE=print_MSPE(data.msfe);

        % compute Diebold-Mariano test
        DM=print_dmpval(data.msfe,data.nmodel,data.nfore);

        %% Round MSPE values to three decimals
        data.MSPE = round(data.MSPE, 3);

        %% Round DM values to two decimals with the custom rule
        % First, perform standard rounding to two decimals
        DM2 = round(DM, 2);

        % Now, adjust values that are exactly at the half mark
        % We check if the fractional part of (DM*100) is exactly 0.5.
        frac_part = DM*100 - floor(DM*100);
        idx = abs(frac_part - 0.5) < 1e-12;  % identify values like 0.015, 1.015, etc.
        % For these values, we want to round down rather than up:
        DM2(idx) = floor(DM(idx)*100) / 100;

        %% Create a new 1x2 array DM_int using DM2 and the following rule:
        %   if DM2(i) <= 0.01  --> DM_int(i) = 3
        %   if DM2(i) <= 0.05  --> DM_int(i) = 2
        %   if DM2(i) <= 0.1   --> DM_int(i) = 1
        %   if DM2(i) >  0.1   --> DM_int(i) = 0
        data.DM_int = zeros(size(DM2));  % initialize DM_int with the same size as DM2
        for i = 1:numel(DM2)
            if DM2(i) <= 0.01
                data.DM_int(i) = 3;
            elseif DM2(i) <= 0.05
                data.DM_int(i) = 2;
            elseif DM2(i) <= 0.1
                data.DM_int(i) = 1;
            else
                data.DM_int(i) = 0;
            end
        end

        % Extract the first element from MSPE and DM_int
        val = data.MSPE(oil_p);  
        sig = data.DM_int(oil_p);  

        % Format the value based on the significance
        if sig == 3
            fmtStr = sprintf('%.3f\\makebox[0pt][l]{$^{***}$}', val);
        elseif sig == 2
            fmtStr = sprintf('%.3f\\makebox[0pt][l]{$^{**}$}', val);
        elseif sig == 1
            fmtStr = sprintf('%.3f\\makebox[0pt][l]{$^{*}$}', val);
        else  % sig == 0
            fmtStr = sprintf('%.3f', val);
        end

        formattedVals{r,c} = fmtStr;
    end
end

% Build the LaTeX table string
latexTable = '';
[nRowsFinal, nColsFinal] = size(formattedVals);
for i = 1:nRowsFinal
    rowStr = formattedVals{i,1};
    for j = 2:nColsFinal
        rowStr = [rowStr, ' & ', formattedVals{i,j}];
    end
    latexTable = [latexTable, rowStr, ' \\[5pt] ', newline];
end

% Display the final LaTeX table string
disp(latexTable);

%close path
rmpath('functions');