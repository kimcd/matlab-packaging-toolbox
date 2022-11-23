function r = positionFactor(x, y, a, b)
% POSITIONFACTOR computes the relative component position factor, r, given 
%                it's coordinate position on a board and the boards length 
%                and width. r is used in Steinberg fatigue calculations. 
%
%   Inputs
%       x = position
%       a = length (in x)
%       y = position
%       b = length (in y)
%
%   C.Kim 22Nov2022 JHUAPL
%%
r = sin(pi * x / a) * sin(pi * y / b);

end
