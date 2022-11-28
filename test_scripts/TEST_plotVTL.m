%TEST_plotVTL
% tester for plotVTL function

%% 
[filename, filedir] = uigetfile('*.xlsx');
full_file = fullfile(filedir, filename);

%%
desired_sheet_name = getSheet(full_file); 

%% Extract all sheet data to a table and column names 
T = readtable(full_file, 'Sheet', desired_sheet_name); 
column_names = getColumnNames(T);
T2 = rmmissing(T); % must remove missing data otherwise get NaN
%% Display column names
for i = 1:numel(column_names)
    if column_names{i} ~= "Phase [Deg]" & column_names{i} ~= "Coherence"
        fprintf("%i. %s\n", i, column_names{i})
    end
end

%% Instantiate an ASD object
freq = T2.X_Data_Hz_; 
psd = T2.Ctrl1Z_Plate_C__g__Hz_; 

a = ASD(freq, psd);

%% Plot it
[axs, h] = a.plot_ASD;

%% Plot an overlay of the reference data
asd_ref = T2.Reference_g__Hz_;
val = sprintf('+3dB [%3.2f grms]', psd_rms(freq, asd_ref));

h_3db = a.overlay(gca, freq, asd_ref, ...
    'LineStyle', '--', ... 
    'Color', 'r', ... 
    'DisplayName', val); 


%%
% in case you want to fix the legend
h_3db.DisplayName = 'Reference'; 

%% Plot an overlay of another accel data
asd_stiff = T2.R2Z_TPEAHigh_Stiff_W__g__Hz_; 
h_stiff = a.overlay(gca, freq, asd_stiff, ...
    "LineStyle", '--', ...
    "DisplayName", "Stiff", ...
    "Color", 'b'); 


