classdef ASD
% Functionality to add:
%   - overlay another ASD object
%
% 
%%
    properties
        f
        asd
        grms
    end

    methods

        %------------------------BEGIN CONSTRUCTOR-------------------------
        % INPUT - max and min part dimensions = [x y z] coordinates of
        %         part
        % 
        function obj = ASD(f, asd)
            if numel(f) ~= numel(asd)
                ME = MException('Dimensions must be equal.');
            end

            obj.f = f;
            obj.asd = asd;
            obj.grms = asd_rms(f, asd);
        end
        %-------------------------------END--------------------------------

        %-------------------------------BEGIN------------------------------
        %PLUS_DB compute XdB data.
        % PLUS_DB(db) returns an ASD that is XdB from the current ASD.
        %             accepts signed values. 
        function [f, g] = plus_db(obj, db)

            g = obj.asd .* 10^(db/10);
            f = obj.f;

        end
        %-------------------------------END--------------------------------


        %-------------------------------BEGIN------------------------------
        %VERTICAL_LINE overlays a vertical line.
        % VERTICAL_LINE(axs, f) overlays a vertical line onto axs at x = f 
        %                       and returns handle h. 
        function h = vertical_line(~, axs, f)
            h = xline(axs, f, 'LineStyle', '-.', ...
                'LineWidth', 2);
            h.DisplayName = sprintf("%3.1f [Hz]", f);
        end
        %-------------------------------END--------------------------------

        %-------------------------------BEGIN------------------------------
        %OVERLAY overlays data. 
        % OVERLAY(axs, f, g) overlays [f, g] onto axs and returns a handle.
        % OVERLAY(axs, f, g, options) accepts additional inputs: 
        %                               Linestyle 
        %                               DisplayName 
        %                               Color
        function h = overlay(~, axs, f, g, options) 
            arguments
                ~ 
                axs matlab.graphics.axis.Axes 
                f double 
                g double
                options.LineStyle (1,1) string = "--" 
                options.DisplayName (1,1) string = "Data"
                options.Color (1,1) string = "k"
            end

            h = plot(axs, f, g, ... 
                'LineStyle', options.LineStyle, ...
                'DisplayName', options.DisplayName, ...
                'Color', options.Color); 

        end
        %-------------------------------END--------------------------------

        
        function [axs, h] = overlay_gevs(~, axs)
            f_gevs = [20 50 800 2000];
            asd_gevs = [.026 .16 .16 .026];
            h = plot(axs, f_gevs, asd_gevs);

        end


        function [axs, h_plot] = plot_ASD(obj, varargin)

            narginchk(1, 2)

            switch nargin
                case 1
                    fig = figure('units', 'normalized', ...
                        'outerposition',[0 0 1 1]);
                    
                    %fig = figure;
                    axs = axes('Parent', fig);
                case 2
                    axs = varargin{1};
            end


            if ~strcmp(get(axs, 'type'), 'axes')
                error('Axes must be a valid handle. ');
            end

            hold(axs, 'on')

            h_plot = plot(axs, obj.f, obj.asd, 'k');
            format_plot(axs);
            legend(axs, sprintf('%3.2f grms', obj.grms))
            

            %             obj.plot_pretty_title(axs, ...
            %                 sprintf('Print paths for Slice %i', obj.id));
        end

        function h_plot = overlay_horizontal(obj, axs)
            unique_asd = unique(obj.asd); 

            for asd_i = 1:numel(unique_asd)
               label = sprintf('%0.2f g', unique_asd(asd_i));
                h_plot(asd_i) = yline(axs, ...
                    unique_asd(asd_i), ...
                    '--', ...
                    label, ...
                    "DisplayName", '');
            end

        end


    end  % methods

end
% HELPERS
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
axs.XLim = [10 3000];
axs.YLim = [0 1];
axs.XLabel.String = 'Frequency $[Hz]$';
axs.XLabel.FontSize = 18;
axs.YLabel.String = 'ASD $[\frac{g^2}{Hz}]$';
axs.YLabel.FontSize = 18;
axs.YAxis.Exponent=0;
set([axs.Title, axs.XLabel, axs.YLabel], ...
    'FontName', 'AvantGarde', 'Interpreter', 'latex');
axs.Title.FontSize = 16;
set(axs,'XTick',[10 20 100 1000 2000],'XTickLabel',{'10', '20', '100','1000', '2000'});
%set(axs,'YTick',[-pi,0,pi],'YTickLabel',{'-\pi','0','\pi'});
set(gcf, 'Color', [1 1 1])

end
