%% SCRIPT_iThermBar
clear all 
close all 
clc
fig = figure; 
set(fig, 'Color', [1 1 1])
axs = axes('Parent', fig); 
hold(axs, 'on')
xlabel(axs, 'Thermocouple ID'); 
ylabel(axs, 'Temperature [$^{\circ}$C]')
title(axs, 'Thermocouple Readings')

set(axs,'XTick',linspace(1,16,16));
set(axs,'YTick',linspace(0,18,19));
set([axs.Title, axs.XLabel, axs.YLabel, axs.ZLabel], ...
    'FontName', 'AvantGarde', 'Interpreter', 'latex');
set([axs.XLabel, axs.YLabel], 'FontSize', 12);
set(axs.Title, 'FontWeight', 'bold', 'FontSize', 12)
set(axs, ...
    'Box'         , 'off'     , ...
    'TickDir'     , 'out'     , ...
    'TickLength'  , [.01 .01] , ...
    'XMinorTick'  , 'off'      , ...
    'YMinorTick'  , 'on'      , ...
    'ZMinorTick'  , 'on'      , ...
    'XGrid'       , 'on'      , ...
    'ZGrid'       , 'on'      , ...
    'YGrid'       , 'on'      , ...
    'XColor'      , [.3 .3 .3], ...
    'YColor'      , [.3 .3 .3], ...
    'LineWidth'   , 1         , ...
    'DataAspectRatio', [1 1 1]     );
%% DATA HERE
y = [6.09, 6.17; 6.24, 6.89; 6.67, 7.04; 6.27, 6.20; 6.62, 6.75; 9.01, 11.27; ...
    7.14 7.64; 6.37 6.69; 6.93 7.24; 8.84 9.48; 6.23 6.49; 6.27 6.25; 6.36 7.10; ...
    6.24 6.49; 6.19 6.41; 6.12 6.16];
bar(axs, y)

%% LEGEND FORMATTING
legend('Cho-seal', 'Bare')
%legend boxoff  % optional
set([axs.Legend], ...
    'FontName', 'AvantGarde', 'Interpreter', 'latex');
