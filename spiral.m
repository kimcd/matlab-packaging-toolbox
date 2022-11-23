clear all 
close all
clc

%% initialize plot
fig = figure; 
axs = axes('Parent', fig);
hold(axs, 'on');
xlim(axs, [0 40])
ylim(axs, [0 40])

%% intialize spiral
start_coord = [20; 20];
end_coord = [39; 39];
plot(axs, start_coord(1), start_coord(2), 'go')
plot(axs, end_coord(1), end_coord(2), 'rx')

% go up one to start
heading = [0; 1];  % start heading pointing up
curr_pos = start_coord + heading;

% initialize the visited nodes list
visited = [start_coord curr_pos];  

% clockwise 90deg rotation matrix
rotate = [0 1; -1 0]; 

end_flag = false;
%n_steps = 1; 

%% spiral logic

while ~end_flag

    plot(axs, ...
        [visited(1,end-1) visited(1,end)], ...
        [visited(2,end-1) visited(2, end)], 'r')
    drawnow

    % candidate turn
    candidate = curr_pos + rotate * heading;

    % check if turning right is valid
    if ismember(candidate', visited', 'rows')  % if visited, then can't 
                                               % turn here
        curr_pos = curr_pos + heading;  % continue moving 1 unit in same 
                                        % direction
    else
        curr_pos = candidate;  % else, can turn; update current pos to 
                               % candidate
        heading = rotate * heading; % update heading cw 90
    end

    % append the visited list 
    visited = [visited curr_pos];

    % check if we're at the end
    if isequal(curr_pos, end_coord)
        end_flag = true;
    end
    
end


