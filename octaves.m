function n_oct = octaves(f1, f2)
%OCT octaves.
%   OCT(f1, f2) octaves between f1 and f2.
%
%   C.Kim 23Nov2022 JHUAPL
%%
n_oct = log10(f2 / f1) / log10(2);

end
