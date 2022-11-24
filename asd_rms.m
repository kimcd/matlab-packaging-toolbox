function grms = asd_rms(f, asd)
%PSDRMS rms of ASD.
%   ASD_RMS(f, asd) computes the rms of a ASD (square root of the area
%   under the ASD curve). 
%
%   This is GEVS spec: 
%       f= [20 50 800 2000];
%       asd = [.026 .16 .16 .026];
%       psd_rms(f, asd) = 14.1
%
%   C.Kim 23Nov2022 JHUAPL

%%
if numel(f) ~= numel(asd)
    error('f and ASD must have the same dimensions.'); 
end

%%
tot_area = 0; 
for i = 1:numel(f)-1
    area_i = asd_area(f(i), f(i+1), asd(i), asd(i+1));
    tot_area = tot_area + area_i;
end

grms = sqrt(tot_area);
