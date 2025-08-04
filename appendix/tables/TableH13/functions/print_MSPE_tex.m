% Round Table_DF to three decimals
roundedDF = round(Table_DF, 3);

% Get the dimensions of Table_DF (15x10)
[rows, cols] = size(roundedDF);

% Define the row names for the 15 rows (first column of the LaTeX table)
rowNames = {
    '\text{Sentiment count}', ...
    '\text{Uncertainty count}', ...
    '\text{Boolean count}', ...
    '\text{Financial Stability}', ...
    '\text{Financial Liability}', ...
    '\text{Afinn}', ...
    '\text{Harvard-IV}', ...
    '\text{Sentiment tfm}', ...
    '\text{Uncertainty tfm}', ...
    '\text{Sentiment tf-idf}', ...
    '\text{Uncertainty tf-idf}', ...
    '\text{VADER}', ...
    '\text{Opinion Sentiment}', ...
    '\text{BERT}'};

latexRows = cell(rows, 1);

for i = 1:rows
    % Start the row string with the corresponding row name
    rowStr = rowNames{i};
    
    for j = 1:cols
        % Get the rounded value from Table_DF at (i,j)
        val = roundedDF(i, j);
        formattedVal = sprintf('%.3f', val);
        
        % Append the significance marker based on Table_DM at (i,j)
        if Table_DM(i, j) == 1
            sigMarker = '\makebox[0pt][l]{$^{*}$}';
        elseif Table_DM(i, j) == 2
            sigMarker = '\makebox[0pt][l]{$^{**}$}';
        elseif Table_DM(i, j) == 3
            sigMarker = '\makebox[0pt][l]{$^{***}$}';
        else
            sigMarker = '';
        end
        formattedVal = [formattedVal, sigMarker];
        
        % For rows 2:15, if the value is lower than the value in row 1 (same column),
        % bold the formatted value.
        if  (val < 1)
            formattedVal = ['\textbf{', formattedVal, '}'];
        end
        
        % Append the formatted value to the row string
        % (using ' & ' to separate columns)
        rowStr = [rowStr, ' & ', formattedVal];
    end
    latexRows{i} = rowStr;
end

% Write the LaTeX rows to a text file (e.g., MSPE.txt)
fid = fopen('MSPE.txt', 'w');
for i = 1:rows
    fprintf(fid, '%s \\\\\n', latexRows{i});
end
fclose(fid);
