function rms = discretePsdRms(frequency, psd) 
%{ 
WORKS FOR DISCRETE DATA ONLY. DO NOT RUN A SPEC THROUGH THIS...

Integration under PSD over the frequency range. 
Returns rms. 

Utilizes the trapezoidal rule, which works well for this application.

%}

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

