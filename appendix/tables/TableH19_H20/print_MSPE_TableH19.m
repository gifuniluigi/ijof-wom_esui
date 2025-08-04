% Round Table_DF to three decimals
roundedDF = round(Table_DF, 3);

% Get the dimensions of Table_DF (15x10)
[rows, cols] = size(roundedDF);

% Define the row names for the 15 rows (first column of the LaTeX table)
rowNames = {
    '\scalebox{1.2}{\text{No - text}}', ...
    '\scalebox{1.2}{\text{Sentiment count}}', ...
    '\scalebox{1.2}{\text{Uncertainty count}}', ...
    '\scalebox{1.2}{\text{Boolean count}}', ...
    '\scalebox{1.2}{\text{Financial Stability}}', ...
    '\scalebox{1.2}{\text{Financial Liability}}', ...
    '\scalebox{1.2}{\text{Afinn}}', ...
    '\scalebox{1.2}{\text{Harvard-IV}}', ...
    '\scalebox{1.2}{\text{Sentiment tfm}}', ...
    '\scalebox{1.2}{\text{Uncertainty tfm}}', ...
    '\scalebox{1.2}{\text{Sentiment tf-idf}}', ...
    '\scalebox{1.2}{\text{Uncertainty tf-idf}}', ...
    '\scalebox{1.2}{\text{VADER}}', ...
    '\scalebox{1.2}{\text{Opinion Sentiment}}', ...
    '\scalebox{1.2}{\text{BERT}}'};

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
        
        % For rows 2 to 15, prepend the cell color based on Table_DM_notxt.
        % Table_DM_notxt is 14x10, corresponding to rows 2:15 of Table_DF.
        if i > 1
            if Table_DM_notxt(i-1, j) == 1
                colorMarker = '\cellcolor{M10} ';
            elseif Table_DM_notxt(i-1, j) == 2
                colorMarker = '\cellcolor{M5} ';
            elseif Table_DM_notxt(i-1, j) == 3
                colorMarker = '\cellcolor{M1} ';
            else
                colorMarker = '';
            end
        else
            colorMarker = '';
        end
        formattedVal = [colorMarker, formattedVal];
        
        % For rows 2:15, if the value is lower than the value in row 1 (same column),
        % bold the formatted value.
        if i > 1 && (val < roundedDF(1, j))
            formattedVal = ['\textbf{', formattedVal, '}'];
        end
        
        % Append the formatted value to the row string
        % (using ' & ' to separate columns)
        rowStr = [rowStr, ' & ', formattedVal];
    end
    latexRows{i} = rowStr;
end

% Write the LaTeX rows to a text file (e.g., MSPE.txt)
fid = fopen('MSPE_H19.txt', 'w');
for i = 1:rows
    fprintf(fid, '%s \\\\\n', latexRows{i});
end
fclose(fid);
