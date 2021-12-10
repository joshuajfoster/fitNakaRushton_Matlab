function r = NakaRushton(params,c)
% input:
% params = vector of parameters [Gr,b,Gc,n]
% c = vector of contrast values
% output:
% r = response for each contrast value in 'c'

Gr = params(1); % response gain
b = params(2);  % baseline
Gc = params(3); % contrast gain
n = params(4);  % exponent that governs slope

r = Gr*((c.^n)./((c.^n)+(Gc.^n)))+b;