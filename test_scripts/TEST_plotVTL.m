%TEST_plotVTL
% tester for plotVTL

%% 
[filename, filedir] = uigetfile('*.xlsx');
full_file = fullfile(filedir, filename);

%%
desired_sheet_name = getSheet(full_file); 

%% Extract all sheet data to a table and column names 
T = readtable(full_file, 'Sheet', desired_sheet_name); 
column_names = geColumnNames(T);

%% 
