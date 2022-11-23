function area = asd_area(f1, f2, asd1, asd2)
%ASD_AREA area under ASD.
%   ASD_AREA(f1, f2, asd1, asd2) computes the area underneath (f1, asd1)
%   and (f2, asd2). 
%
%   References:
%       https://femci.gsfc.nasa.gov/random/randomgrms.html
%
%   C.Kim 23Nov2022 JHUAPL
%%
dB = asd_dB(asd1, asd2);
oct = octaves(f1,f2);
slope = dB/oct;

if abs(slope - (-10 * log10(2))) < eps
    'zero'
    area = asd1 * f1 * log(f2 / f1);
else
    area = 10 * log10(2) * ( asd2 / (10 * log10(2) + slope) )...
        * (f2 - (f1 * (f1 / f2) ^ (slope / (10 * log10(2))) ));
end

if area<0 
    error('Area cannot be negative.')
end

end
