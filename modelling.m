load proj.mat;

y = Close;
yE = y(1:1086)
yT = y(1086:end)

% Plot the original data (dates vs y)
figure;
plot(Date1, y);
title({'Daily Ethereum Price in USD'; 'at Close (Raw Data)'});

% Calculate returns from the price series in percentages
r = 100 * price2ret(yE);

[h_adf, pValue_adf] = adftest(r);

% Length of the return series
T = length(r);
figure;
plot(r);
title('Percentage Returns');

% Autocorrelation plots
figure;
autocorr(r);
title('Autocorrelation of Returns');
ax = gca; % Get the current axes
ax.XTick = 0:3:20; % Set ticks at intervals of 3 (e.g., 0, 3, 6, ..., 20)

figure;
parcorr(r);
title('Partial Autocorrelation of Returns');
ax = gca; % Get the current axes
ax.XTick = 0:3:20; % Set ticks at intervals of 3 (e.g., 0, 3, 6, ..., 20)

figure;
autocorr(r.^2);
title('Autocorrelation of Squared Returns');
ax = gca; % Get the current axes
ax.XTick = 0:2:20; % Set ticks at intervals of 3 (e.g., 0, 3, 6, ..., 20)

figure;
parcorr(r.^2);
title('Partial Autocorrelation of Squared Returns');
ax = gca; % Get the current axes
ax.XTick = 0:2:20; % Set ticks at intervals of 3 (e.g., 0, 3, 6, ..., 20)

