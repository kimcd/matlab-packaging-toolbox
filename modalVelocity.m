function out = modalVelocity(f_srs, g_srs)
%MODALVELOCITY SRS modal velocity
%   MODALVELOCITY(frequency, SRS) computes the modal velocity [ips] of an 
%   SRS given a 1xN array of SRS frequencies [Hz] and SRS 
%   accelerations [G]. 
%
%   C. Kim, 13Nov2022, JHUAPL
%% Data validation
if numel(f_srs) ~= numel(g_srs)
    error("Dimensions must be equal."); 
end

% enforce row vector 
f_srs = reshape(f_srs, [], 1); 
g_srs = reshape(g_srs, [], 1);

%% Compute
out = (386.1 * g_srs) ./ (2 * pi * f_srs); 


