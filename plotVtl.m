function full_file = plotVtl(varargin)
% PLOTVTL plots the VTL test data. 

%%
switch nargin 
    case 0 
        [filename, filedir] = uigetfile('*.xlsx');
        full_file = fullfile(filedir, filename);
    case 1
        full_file = varargin{1};
end

%% SHEET SELECTION BY INDEX
desired_sheet_name = getSheet(full_file); 

%% Extract all sheet data to a table and column names 
T = readtable(filepath, 'Sheet', desired_sheet_name); 
column_names = get_column_names(T);
FREQUENCY_COLUMN_INDEX = column_indices(1);  % need to figure out how to handle this better
FORCE_SUM_COLUMN_INDEX = column_indices(2);

%% Extract data
% RV is always from 20-2000Hz, so leaving these as magic #'s 
f_0_index = find(T{:, FREQUENCY_COLUMN_INDEX} == 20);  
f_1_index = find(T{:, FREQUENCY_COLUMN_INDEX} == F_FINAL); 

% digital frequency data
freq_20_2000 = T{:, FREQUENCY_COLUMN_INDEX}(f_0_index : f_1_index); 

% force washer psd data 
force_washer_psd = T{:, FORCE_SUM_COLUMN_INDEX}(f_0_index : f_1_index); % store control psd [lb^2/Hz]
%%
% reference FSD
REF_FSD = [[20 50 100 250 450 500 2000]' [1092 1092 1092 109 109 88 1]'];

end