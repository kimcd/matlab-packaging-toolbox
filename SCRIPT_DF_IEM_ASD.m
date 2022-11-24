%SCRIPT_DF_IEM_ASD
%   Rev A Spec

%% spec
f = [20 35 200 300 500 700 800 925 2000]; 
asd = [.01 .08 .08 .04 .04 .03 .06 .06 .013];

%% ASD object
asd = ASD(f, asd); 
asd.plot_ASD;
fprintf('%3.2f\n', asd.grms)

%asd.overlay_gevs(gca)

%% overlay 3dB bands
[f_plus, g_plus] = asd.plus_db(3); 
[f_min, g_min] = asd.plus_db(-3); 

asd.overlay(gca, f_plus, g_plus)
asd.overlay(gca, f_min, g_min)

%%