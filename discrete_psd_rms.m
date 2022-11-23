function rms = discrete_psd_rms(frequency, psd) 
%DISCRETEPSDRMS rms of digital PSD data. 
%   DISCRETEPSDRMS(frequency, psd) computes the RMS of discrete PSD data 
%   using a cumulative trapezoidal formula to compute square root of the 
%   trapezoidal area under a PSD.
%   Useful for computing the RMS of accelerometer data. 
%
%   C.Kim 23Nov2022 JHUAPL
%%
if numel(frequency) ~= numel(psd) 
    ME = MException('Dimensions must be equal.');
end

area_under_curve = 0; 

for i = 2:numel(frequency)

    area_under_curve = area_under_curve...
                       + (psd(i-1) + psd(i))... 
                       * .5 * (frequency(i)...
                       - frequency(i-1)); 
end

rms = sqrt(area_under_curve); 

