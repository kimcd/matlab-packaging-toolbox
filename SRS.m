classdef SRS
    % SRS class definition for an SRS object. Will perform basic plots for
    %   analyzing an SRS. 
    %
    % C.Kim 23Nov2022 JHUAPL


    properties
        frequencies
        accelerations
        mv
    end

    properties(Constant)
        g = 386.1;  % [in/s^2]
    end
    methods

        function obj = SRS(f, g)
            obj.frequencies = f;
            obj.accelerations = g;
            obj.mv = get_modal_velocity(obj); 
        end


        function plot_handle = plot_SRS(obj)

            [fig_handle, axs_handle] = generate_figure_axes();
            
            plot_handle = loglog(axs_handle, ...
                obj.frequencies, ...
                obj.accelerations); 

            grid(axs_handle,'on')

        end


        function mv = get_modal_velocity(obj)
            mv = modalVelocity(obj.frequencies, obj.accelerations);
        end

    end


end

%% HELPERS
function [fig, axs] = generate_figure_axes(varargin)

narginchk(0, 1)

switch nargin
    case 0
        fig = figure;
        axs = axes('Parent', fig);
    case 1
        axs = varargin{1};
end

if ~strcmp(get(axs, 'type'), 'axes')
    error('Axes must be a valid handle. ');
end

hold(axs, 'on')

end

function make_plot_pretty(fig, axs)
end
