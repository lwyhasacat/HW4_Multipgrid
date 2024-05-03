clc, clear, close all;

data = [
    100, 1, 1, 22.9507, 1.0072, -0.1641;
    100, 1, 2, 23.1187, 1.0065, -0.1484;
    100, 1, 3, 23.2520, 1.0059, -0.1356;
    100, 2, 1, 22.0110, 1.0105, -0.2327;
    100, 2, 2, 22.2553, 1.0095, -0.2101;
    100, 2, 3, 22.4495, 1.0086, -0.1916;
    250, 1, 1, 60.4531, 1.0028, -0.1638;
    250, 1, 2, 60.6285, 1.0025, -0.1474;
    250, 1, 3, 60.7724, 1.0023, -0.1335;
    250, 2, 1, 59.5145, 1.0040, -0.2324;
    250, 2, 2, 59.7682, 1.0036, -0.2091;
    250, 2, 3, 59.9719, 1.0033, -0.1897;
    500, 1, 1, 122.9515, 1.0014, -0.1640;
    500, 1, 2, 123.1205, 1.0012, -0.1483;
    500, 1, 3, 123.2533, 1.0011, -0.1356;
    500, 2, 1, 122.0124, 1.0020, -0.2326;
    500, 2, 2, 122.2574, 1.0018, -0.2101;
    500, 2, 3, 122.4476, 1.0016, -0.1922;
];

resultsTable = table(data(:,1), data(:,2), data(:,3), data(:,4), data(:,5), data(:,6), ...
    'VariableNames', {'Grid_Size', 'p', 'q', 'Final_Residual', 'Avg_Reduction_Factor', 'Slope'});
fprintf('%10s %4s %4s %15s %20s %10s\n', 'Grid_Size', 'p', 'q', 'Final_Residual', 'Avg_Reduction_Factor', 'Slope');
fprintf('%10s %4s %4s %15s %20s %10s\n', '__________', '___', '___', '_______________', '____________________', '__________');
indices = [1:6:18, 2:6:18, 3:6:18, 4:6:18, 5:6:18, 6:6:18];

for idx = indices
    if idx <= height(resultsTable)
        fprintf('%10d %4d %4d %15.4f %20.4f %10.4f\n', ...
            resultsTable.Grid_Size(idx), resultsTable.p(idx), resultsTable.q(idx), ...
            resultsTable.Final_Residual(idx), resultsTable.Avg_Reduction_Factor(idx), resultsTable.Slope(idx));
    end
end
