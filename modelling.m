load proj.mat;

y = Close;

%Divide the data into two datasets:
%yE for estimation
%yT for testing
yE = y(1:1086)
yT = y(1086:end)

% Plot the original data (dates vs y)
figure;
plot(Date1, y);
title({'Daily Ethereum Price in USD'; 'at Close (Raw Data)'});

% Calculate returns from the price series in percentages
r = 100 * price2ret(yE);

% Length of the return series
T = length(r);
figure;
plot(r);
title('Percentage Returns');

% Autocorrelation plots
figure;
autocorr(r);
title('Autocorrelation of Returns');
ax = gca;
ax.XTick = 0:3:20; % Set ticks at intervals of 3

figure;
parcorr(r);
title('Partial Autocorrelation of Returns');
ax = gca;
ax.XTick = 0:3:20; % Set ticks at intervals of 3

figure;
autocorr(r.^2);
title('Autocorrelation of Squared Returns');
ax = gca;
ax.XTick = 0:2:20; % Set ticks at intervals of 2

figure;
parcorr(r.^2);
title('Partial Autocorrelation of Squared Returns');
ax = gca; 
ax.XTick = 0:2:20; % Set ticks at intervals of 2

% Ljung-Box test for squared returns
[H_LB, p_LB] = lbqtest(r.^2);

% ARCH test for returns
[H_ARCH, p_ARCH] = archtest(r, 'Lags', 2);

% Define models
CondVarMdl = garch(1,1);  % GARCH model for conditional variance

% ARIMA models with conditional variance models
Model1 = arima(ARLags=1, Variance=CondVarMdl);
Model2 = arima(MALags=1, Variance=CondVarMdl);
Model3 = arima(ARLags=2, MALags=1, Variance=CondVarMdl);

% GJR-GARCH models for asymmetry
CondVarMd2 = gjr(1,1);
Model4 = arima(ARLags=1, Variance=CondVarMd2);
Model5 = arima(MALags=1, Variance=CondVarMd2);
Model6 = arima(ARLags=2, MALags=1, Variance=CondVarMd2);