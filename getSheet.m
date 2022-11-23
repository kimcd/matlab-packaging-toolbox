function desired_sheet_name = getSheet(filepath)

sheet_names = sheetnames(filepath);
fprintf("This file contains the following sheets: \n");

for i = 1:numel(sheet_names) 
    fprintf('%i. %s\n', i, sheet_names{i});
end

% Begin selection confirmation
confirm = false; 
while ~confirm 
    desired_sheet_index = input('\nSelect the number of the sheet you want to process: ');

    % TODO: error check that it's valid 
    fprintf('You selected %s.', sheet_names{desired_sheet_index});
    response = input(' Are you sure? Y/N [Y]: ', 's');

    if response == 'y' | response == "Y"  
        confirm = true; 
    elseif isempty(response)
        confirm = true; 
    else 
        confirm = false; 
    end

end
desired_sheet_name = sheet_names{desired_sheet_index};