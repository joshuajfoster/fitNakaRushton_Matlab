function c50 = computeC50(params)
% calculate c50 given a set of Naka-Rushton parameters following method of
% Itthipuripat, Sprague, and Serences (2019) Journal of Neuroscience.
% Specifically, find the contrast value that produces half the response seen at contrast = 100


SemiSatR = NakaRushton(params,100)/2; % calculate half of value at c = 100
c = 0.01:0.001:100; % finely spaced vector of contrast values
pred = NakaRushton(params,c); % gerate function values of finely spaced contrast values
[m idx] = min(abs(pred-SemiSatR)); % find value in function closet to half of value at c = 100
c50 = c(idx); % grab the contrast value


