function ratio = asd_dB(asd_1, asd_2)
%ASD_DB decibel ratio of asd1 and asd2.
%   DB(asd1, asd2) decibel ratio of asd2/asd1. 
%
%   C.Kim 23Nov2022 JHUAPL
%%
    ratio = 10 * log10(asd_2/asd_1);
end
