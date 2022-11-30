%SCRIPT_DF_IEM_ASD
%   Rev A Spec

clc
clear all
close all

%% spec
f = [20 35 200 300 500 700 800 925 2000]; 
asd = [.01 .08 .08 .04 .04 .03 .06 .06 .013];

f = [20 35 200 300 500 2000]; 
asd = [.01 .08 .08 .04 .04 .01];

%% ASD object
iem_asd = ASD(f, asd); 
[axs, h] = iem_asd.plot_ASD;
fprintf('%3.2f\n', iem_asd.grms)
title(axs, ...
    "7511-9038, Rev. B, ProtoFlight Random Vibration Levels for Lander Components Mounted on Y Panels and Z Deck 1min/axis")
%asd.overlay_gevs(gca)
horizontal_lines=iem_asd.overlay_horizontal(axs);

%% overlay 3dB bands
[f_plus, g_plus] = iem_asd.plus_db(3); 
[f_min, g_min] = iem_asd.plus_db(-3); 
plot(axs, f_plus, g_plus, 'r-.', "DisplayName", "+3dB")
plot(axs, f_min, g_min, 'r--', "DisplayName", "-3dB")
%iem_asd.overlay(gca, f_plus, g_plus)
%iem_asd.overlay(gca, f_min, g_min)

%% SRS object and plot
f_srs = [100 2000 10000];
g_srs = [7 1386 1386]; 

iem_srs = SRS(f_srs, g_srs);    
iem_srs.plot_SRS

axs = gca;
axs.XAxis.TickValues = f_srs;

iem_srs.overlay_horizontal(axs)
%axs.YLim = [round(min(g_srs), -2) round(max(g_srs), -2)]
title(axs, "7511-9038, Rev. B, Max Expected Shock Environment for Components Mounted on Lander Side Panels")

%%
g_100_mv = iem_srs.compute_g_at_mv(100)
plot(axs, f_srs, g_100_mv, 'r--', "DisplayName", '100 IPS')

g_50_mv = iem_srs.compute_g_at_mv(50)
plot(axs, f_srs, g_50_mv, '--', "DisplayName", '50 IPS', "Color", [0.9290 0.6940 0.1250])

%%
[filename, filedir] = uigetfile('*.txt');
full_file = fullfile(filedir, filename);
T = readtable(full_file);
f = T.Var1; 
g = T.Var2;
fig = figure;
axs = axes("Parent",fig); 
h_plt = plot(axs, f, g, 'k-');
grid(axs, 'on')
g_label = unique(g);
for i = 1:numel(g_label)
    label = sprintf('%0.2f g', g_label(i));
    yline(axs, g_label(i), '--', label)

end

