function c50 = computeC50_NegVals(params)
% calculate c50 given a set of Naka-Rushton parameters in the spirit of
% Itthipuripat et al. (2019) Journal of Neuroscience. 
% Find the contrast value that produces the response halfway between
% baseline and value at 100% contrast.
% This is slightly different to the Itthipuripat et al. approach of finding
% the contrast value at which the N-R function reaches half the max
% response. That approach can't handle negative baseline values.

maxResp = NakaRushton(params,100); % note: different to Rmax param! not subtracting baseine
baseline = params(2);
SemiSatR = mean([baseline, maxResp]);
c = 0.01:0.001:100; % finely spaced vector of contrast values
pred = NakaRushton(params,c); % gerate function values of finely spaced contrast values
[m idx] = min(abs(pred-SemiSatR)); % find value in function closet to half of value at c = 100
c50 = c(idx); % grab the contrast value



