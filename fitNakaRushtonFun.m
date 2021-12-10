function [sse] = fitNakaRushtonFun(params,contrast,response)
% calculate sse for a given set of parametrs for data (contrast and
% response values)
% 
% inputs:
% params = parametesrs (see NakaRushton.m for order)
% contrast = vector of contrast valus
% response = vector of response values
% 
% note: this code was adapted from "FitNakaRushton" in Psychtoolbox:
% http://psychtoolbox.org/docs/FitNakaRushtonFun

% Unpack paramters, make predictions
pred = NakaRushton(params,contrast);
sse = sum((response-pred).^2); % calculate sum of squared errors