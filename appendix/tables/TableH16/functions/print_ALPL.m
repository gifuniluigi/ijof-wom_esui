%% This code prints Panel A, ALPL 

% Round Table_DF to three decimals
roundedDF = round(Table_DF, 3);

% For each column, determine the maximum (highest) value
maxVals = max(roundedDF, [], 1);

% Create LaTeX-formatted rows
[rows, cols] = size(roundedDF);
latexRows = cell(rows, 1);

for i = 1:rows
    rowStr = '';
    for j = 1:cols
        % Get the rounded value and format it to three decimals as a string
        val = roundedDF(i, j);
        formattedVal = sprintf('%.3f', val);
        
        % Append the significance marker based on Table_DM:
        % 1 → \makebox[0pt][l]{$^{*}$}
        % 2 → \makebox[0pt][l]{$^{**}$}
        % 3 → \makebox[0pt][l]{$^{***}$}
        if Table_DM(i,j) == 1
            marker = '\makebox[0pt][l]{$^{*}$}';
        elseif Table_DM(i,j) == 2
            marker = '\makebox[0pt][l]{$^{**}$}';
        elseif Table_DM(i,j) == 3
            marker = '\makebox[0pt][l]{$^{***}$}';
        else
            marker = '';
        end
        
        % Combine the formatted value with its marker
        formattedVal = [formattedVal, marker];
        
        % If this value is the highest in its column, wrap it in \textbf{}
        if abs(val - maxVals(j)) < 1e-6   % Using tolerance for floating point equality
            formattedVal = ['\textbf{', formattedVal, '}'];
        end
        
        % Append the formatted value to the row string
        if j < cols
            rowStr = [rowStr, formattedVal, ' & '];
        else
            rowStr = [rowStr, formattedVal];
        end
    end
    latexRows{i} = rowStr;
end

% Step 4: Write the LaTeX rows to a text file
fid = fopen('ALPL.txt', 'w');
for i = 1:rows
    fprintf(fid, '%s \\\\\n', latexRows{i});
end
fclose(fid);