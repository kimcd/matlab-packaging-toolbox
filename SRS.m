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
            hold(axs_handle,'on')

            plot_handle = plot(axs_handle, ...
                obj.frequencies, ...
                obj.accelerations, 'k'); 

            format_plot(axs_handle);

        end


        function mv = get_modal_velocity(obj)
            mv = modalVelocity(obj.frequencies, obj.accelerations);
        end


        function g_srs = compute_g_at_mv(obj, MV) 
            %f = [100 10000];
            g_srs = MV .* (2 * pi * obj.frequencies) / (386.1);
        end

        function h_plot = overlay_horizontal(obj, axs)
            unique_acc = unique(obj.accelerations); 

            for acc_i = 1:numel(unique_acc)
               label = sprintf('%3.0f g', unique_acc(acc_i));
                h_plot(acc_i) = yline(axs, ...
                    unique_acc(acc_i), ...
                    '--', ...
                    label, ...
                    "DisplayName", '');
            end

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

function format_plot(axs)
% set(axs, ...
%     "YScale", 'log', ...
%     "XScale", 'log', ...
%     "XGrid", 'on', ...
%     "YGrid", 'on', ...
%     "YMinorGrid", 'on', ...
%     "XMinorGrid", 'on', ...
%     "Xlim", [10 3000], ...
%     "YLim", [0 1], ...
%     "XLabel.String", 'Frequency $[Hz]$', ...
%     "YLabel.String", 'ASD $[\frac{G^2}{Hz}]$', ...
%     "YAxis.Exponent", 0)
axs.YScale = 'log';
axs.XScale = 'log';
axs.XGrid = 'on';
axs.YGrid = 'on';
axs.YMinorGrid = 'on';
axs.XMinorGrid = 'on';
axs.XLim = [90 20000];
axs.YLim = [0 2000];
axs.XLabel.String = 'Frequency $[Hz]$';
axs.XLabel.FontSize = 18;
axs.YLabel.String = 'SRS $[g]$';
axs.YLabel.FontSize = 18;
axs.YAxis.Exponent=0;
set([axs.Title, axs.XLabel, axs.YLabel], ...
    'FontName', 'AvantGarde', 'Interpreter', 'latex');
axs.Title.FontSize = 16;
%set(axs,'XTick',[10 20 100 1000 2000],'XTickLabel',{'10', '20', '100','1000', '2000'});
%set(axs,'YTick',[-pi,0,pi],'YTickLabel',{'-\pi','0','\pi'});
set(gcf, 'Color', [1 1 1])

end

