
ROIname = {'V1','V2','V3'}
ylims = [-0.5 0.5];

for r = 1:3

% V1
if r == 1
match_dat = [-0.4298   -0.4027   -0.3752   -0.2301   -0.2810   -0.1243    0.0431    0.1328    0.0013    0.3752];
mismatch_dat = [-0.3809   -0.3709   -0.2701   -0.3284   -0.1459   -0.0625    0.0350    0.2776    0.1372    0.2965];
end

% V2
if r == 2
match_dat = [-0.3676   -0.3649   -0.3502   -0.2162   -0.2897   -0.1805   -0.0283    0.0403   -0.0917    0.1294];
mismatch_dat = [-0.3429   -0.3514   -0.2697   -0.3372   -0.1631   -0.1229   -0.0586    0.1483    0.0015    0.0570];
    
end

% V3
if r == 3
match_dat = [-0.1568   -0.2137   -0.2013   -0.1091   -0.1619   -0.1121    0.0187    0.0693   -0.0350    0.1452];
mismatch_dat = [-0.1650   -0.2066   -0.1438   -0.1836   -0.0311   -0.0493    0.0170    0.1687    0.0643    0.0730];
end

%% fit Naka Rushton function to subject-averaged data

params0 = [1,0,50,2]; % init params
c = 100*[0 0.0267    0.0400    0.0533    0.0800    0.1600    0.3200    0.4800    0.6400    0.9600]; % contrast values

% match
[params] = fitNakaRushton(c,match_dat,params0);
match.Gr = params(1);
match.b = params(2);
match.Gc = params(3);
match.n = params(4);
match.Rmax = NakaRushton(params,100)-params(2); % predicted response at c = 100 - baseline
match.c50 = computeC50(params); 

% mismatch
[params] = fitNakaRushton(c,mismatch_dat,params0);
mismatch.Gr = params(1);
mismatch.b = params(2);
mismatch.Gc = params(3);
mismatch.n = params(4);
mismatch.Rmax = NakaRushton(params,100)-params(2); % predicted response at c = 100 - baseline
mismatch.c50 = computeC50(params); 

subplot(1,3,r)

c_plot = c; c_plot(1) = 1.2; % vector that is conducive to plotting zero
contrast = 2:0.1:100;
% plot model fits
match_fit = NakaRushton([match.Gr,match.b,match.Gc,match.n],contrast);
semilogx(contrast,match_fit,'LineWidth',1,'Color','b'); hold on;
mismatch_fit = NakaRushton([mismatch.Gr,mismatch.b,mismatch.Gc,mismatch.n],contrast);
semilogx(contrast,mismatch_fit,'LineWidth',1,'Color','r'); 
% plot model fits at 0
plot([1.05 1.35],match.b*ones(2,1),'LineWidth',1,'Color','b')
plot([1.05 1.35],mismatch.b*ones(2,1),'LineWidth',1,'Color','r')
% plot data
scatter(c_plot,match_dat,'b');
scatter(c_plot,mismatch_dat,'r');
ylabel('BOLD (z-scored)')
xlabel('Contrast (%)')
xlim([1 100])
ylim(ylims);
xticks([c_plot(1) c_plot(2) c_plot(6) c_plot(10)])
xticklabels({'0',num2str(c(2)),num2str(c(6)),num2str(c(10))})
box off
title(ROIname{r});


end
