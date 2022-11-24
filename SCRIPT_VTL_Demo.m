%SCRIPT_VTL_Demo

%% 
[filename, filedir] = uigetfile('*.xlsx');
full_file = fullfile(filedir, filename);

%%
desired_sheet_name = getSheet(full_file); 

%% Extract all sheet data to a table and column names 
T = readtable(full_file, 'Sheet', desired_sheet_name); 
column_names = getColumnNames(T);

%% create ASD
% LABELS = ["digital frequency", "force washer"];  % label will be used for legend 
% column_indices = getColumnIndices(LABELS, column_names);
freq = T.X_Data_Hz_; 
asd = T.Control_g__Hz_; 
test = ASD(freq, asd)
test.plot_ASD
psd_rms()