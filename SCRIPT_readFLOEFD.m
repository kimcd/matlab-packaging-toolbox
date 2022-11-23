% SCRIPT_READFLOEFD Parses and plots FLOEFD convergence data. 
%   TODO: Automate column read and data extraction to generalize this
%         script into a function. 
%
%   C.Kim 23Nov2022 JHUAPL

%% User select file
[filename, filedir] = uigetfile('*.txt');
full_file = fullfile(filedir, filename);

%% Stuff data into Table
T=readtable(full_file); 

%% Extract values
iteration = T.Iteration;
travels = T.Travels;
AvValue = T.AvValue;
MinVal = T.MinValue;
MaxVal = T.MaxValue;
Delta = T.Delta;

%% Initialize Plot
fig = figure;
set(fig, 'Color', [1 1 1])
axs = axes("Parent", fig);
grid(axs, 'on'); 
grid(axs, 'minor');
hold(axs, 'on');
xlabel(axs, 'iteration'); 
ylabel(axs, 'criteria');

%% Plot data
%plot(axs, iteration, travels, 'k');
plot(axs, iteration, AvValue, 'r'); 
plot(axs, iteration, MinVal, 'g'); 
plot(axs, iteration, MaxVal, 'c'); 
plot(axs, iteration, Delta, 'k'); 

legend(axs, 'AvValue', 'MinValue', 'MaxValue', 'Delta', ...
    'Location', 'NorthEastOutside');