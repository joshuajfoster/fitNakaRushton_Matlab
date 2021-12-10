function [params] = fitNakaRushton(contrast,response,params0)
% inputs:
% contrast = vector of contrast values
% response = vector of responses
% params0 = init parameters for fmincon
% 
% outputs:
% params = param estimates
%
% note: this code was adapted from "FitNakaRushton" in Psychtoolbox: http://psychtoolbox.org/docs/FitNakaRushton

% Set up minimization options
options = optimset;
options = optimset(options,'Diagnostics','off','Display','off');
options = optimset(options,'LargeScale','off');

% Gr, b, Gc, and n
vlb = [0    -10	0    0.1]; % lower bounds
vub = [10  10  100  10]; % upper bounds

params = fmincon('fitNakaRushtonFun',params0,[],[],[],[],vlb,vub,[],options,...
contrast,response); 