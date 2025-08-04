%% This code generates the balanced datasets

for j=1:3
    % Loop over each general index file
    for i = 1:nFiles
        % Read general index file
        gen_tbl = readtable(genFiles{i}, 'Sheet', 1);

        % Make column 1 datetime
        gen_tbl.Date = datetime(gen_tbl{:,1});

        % Retain only date and index value (rename variable to 'Index')
        gen_tbl = gen_tbl(:, {'Date', gen_tbl.Properties.VariableNames{2}});
        gen_tbl.Properties.VariableNames{2} = 'Index';

        % Determine the later starting date between TOSI and the general index
        startDate = max(min(TOSI_tbl.Date), min(gen_tbl.Date));

        % Truncate both series to dates >= startDate
        OilP_trunc  = OilP_tbl(OilP_tbl.Date >= startDate, :);
        TOSI_trunc = TOSI_tbl(TOSI_tbl.Date >= startDate, :);
        gen_trunc  = gen_tbl(gen_tbl.Date >= startDate, :);


        % Convert to timetables for easy synchronization (using Date as row times)
        OilP_tt = table2timetable(OilP_trunc);
        TOSI_tt = table2timetable(TOSI_trunc);
        gen_tt  = table2timetable(gen_trunc);

        % Synchronize on the intersection of dates so both series have matching dates
        merged_tt = synchronize(OilP_tt, TOSI_tt, gen_tt, 'intersection');

        % Find the index of the row corresponding to January 2020.
        t0_date = events_datetime(1,j);
        t_end_date = events_datetime(2,j);

        t0 = find(merged_tt.Date >= t0_date, 1, 'first');
        t_end = find(merged_tt.Date >= t_end_date, 1, 'first');

        t0_vals(i,j) = t0;

        % Stop the dataset at the end of the period
        merged_tt = merged_tt(1:t_end, :);

        % Store the aligned data for later use in your forecasting loop
        alignedData{i,j} = merged_tt;
    end
end