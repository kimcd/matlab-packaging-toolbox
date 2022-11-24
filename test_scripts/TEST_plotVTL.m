%TEST_plotVTL
% tester for plotVTL

%% 
[filename, filedir] = uigetfile('*.xlsx');
full_file = fullfile(filedir, filename);

%%
desired_sheet_name = getSheet(full_file); 

%% Extract all sheet data to a table and column names 
T = readtable(full_file, 'Sheet', desired_sheet_name); 
column_names = getColumnNames(T);
T2 = rmmissing(T); % must remove missing data otherwise get NaN
%% Instantiate an ASD object
freq = T2.X_Data_Hz_; 
psd = T2.Ctrl1Z_Plate_C__g__Hz_; 

a = ASD(freq, psd);

%% Plot it
a.plot_ASD

%% Plot an overlay of the reference data
asd_ref = T2.Reference_g__Hz_;
a.overlay(gca, freq, asd_ref)


%% Plot an overlay of another accel data
asd_stiff = T2.R2Z_TPEAHigh_Stiff_W__g__Hz_; 
a.overlay(gca, freq, asd_stiff)