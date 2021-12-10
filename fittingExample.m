% This script provides an example of how to use the fitting functions

% simulate some data
Gr = 1; 
b = -0.5;
Gc = 50;
n = 2;
noiseSD = 0.05; % SD of noise added
contrasts = 100*[0 0.0267    0.0400    0.0533    0.0800    0.1600    0.3200    0.4800    0.6400    0.9600]; % contrast values
dat = NakaRushton([Gr,b,Gc,n],contrasts) + normrnd(0,noiseSD,size(contrasts));

% do fitting
params0 = [1,0,50,2]; % init params for fitting
[params] = fitNakaRushton(contrasts,dat,params0);
Gr_hat = params(1);
b_hat = params(2);
Gc_hat = params(3);
n_hat = params(4);
Rmax_hat = computeRmax(params);
C50_hat = computeC50_NegVals(params); % note: using the version that can handle negative baselines!
% plot data with fitted function
figure;
contrasts_plot = contrasts; contrasts_plot(1) = 1.2; % vector that is conducive to plotting zero
contrasts_cont = 2:0.1:100;
% plot model fit
fit = NakaRushton([Gr_hat,b_hat,Gc_hat,n_hat],contrasts_cont);
semilogx(contrasts_cont,fit,'LineWidth',1,'Color','b'); hold on;
% plot model fit at 0% contrast
plot([1.05 1.35],b_hat*ones(2,1),'LineWidth',1,'Color','b')
% plot data
scatter(contrasts_plot,dat,'b');
ylabel('Response')
xlabel('Contrast (%)')
xlim([1 100])
xticks([contrasts_plot(1) contrasts_plot(2) contrasts_plot(6) contrasts_plot(10)])
xticklabels({'0',num2str(contrasts(2)),num2str(contrasts(6)),num2str(contrasts(10))})
box off

% print param ests to command window
fprintf('Param estimates: \n')
fprintf('baseline = %.2f \n',b_hat)
fprintf('n = %.2f \n',n_hat)
fprintf('Gr = %.2f \n',Gr_hat)
fprintf('Rmax = %.2f \n',Rmax_hat)
fprintf('Gc = %.2f \n',Gc_hat)
fprintf('C50 = %.2f \n',C50_hat)