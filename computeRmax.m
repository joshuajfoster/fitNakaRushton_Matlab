function Rmax = computeRmax(params)
% calculate c50 given a set of Naka-Rushton parameters following method of
% Itthipuripat et al. (2019) Journal of Neuroscience.
% i.e. find the value of the Naka-Rushton function at c = 100 - baseline

Rmax = NakaRushton(params,100)-params(2);