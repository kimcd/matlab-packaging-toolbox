function desired_column_index = getColumnIndex(column_name, column_names)
fprintf("This sheet cotains the following columns: \n");

for i = 1:numel(column_names) 
    fprintf('%i. %s\n', i, column_names{i});
end

% Begin selection confirmation
confirm = false; 
while ~confirm 
    accelerometer_prompt = sprintf('\nSelect %s data, by column #: ', column_name); 
    desired_column_index = input(accelerometer_prompt);

    % TODO: error check that it's valid 
    fprintf('You selected %s.', column_names{desired_column_index});
    response = input(' Are you sure? Y/N [Y]: ', 's');

    if response == 'y' | response == "Y"
        confirm = true;
    elseif isempty(response)  % blank response defaults to true
        confirm = true; 
    else 
        confirm = false;
    end

    % loop back to input if response is no
       %if response == 'N' | response == 'n'
       %    confirm = false; 
       %end
end

%desired_column_index = column_names{desired_column_index}; 