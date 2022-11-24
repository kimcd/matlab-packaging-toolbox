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

        function obj = ASD(f, asd)
            if numel(f) ~= numel(asd)
                ME = MException('Dimensions must be equal.');
            end

            obj.f = f;
            obj.asd = asd;
            obj.grms = psd_rms(f, asd);
        end

        function [f g] = plus_db(obj, db)
            %db = 10 * log10(asd2/asd1)
            %db/10 = log10(asd2/asd1)
            %10^(db/10) = asd2/asd1
            %asd1 * 10^(db/10) = asd2
            g = obj.asd .* 10^(db/10);
            f = obj.f;

        end

        function h = overlay(obj, axs, f, g) 
            h = plot(axs, f, g, 'k--'); 
        end



        function overlay_gevs(obj, axs)
            f = [20 50 800 2000];
            asd = [.026 .16 .16 .026];
            plot(axs, f, asd);

        end


        function obj = plot_ASD(obj, varargin)

            narginchk(1, 2)

            switch nargin
                case 1
                    fig = figure('units','normalized','outerposition',[0 0 1 1])
                    %fig = figure;
                    axs = axes('Parent', fig);
                case 2
                    axs = varargin{1};
            end

            if ~strcmp(get(axs, 'type'), 'axes')
                error('Axes must be a valid handle. ');
            end

            hold(axs, 'on')

            plot(axs, obj.f, obj.asd, 'k');
            make_plot_log(axs);
            legend(axs, sprintf('%3.2f grms', obj.grms))
            

            %             obj.plot_pretty_title(axs, ...
            %                 sprintf('Print paths for Slice %i', obj.id));
        end



    end

end
% HELPERS
function make_plot_log(axs)
axs.YScale = 'log';
axs.XScale = 'log';
axs.XGrid = 'on';
axs.YGrid = 'on';
axs.YMinorGrid = 'on';
axs.XMinorGrid = 'on';
axs.XLim = [10 3000];
axs.YLim = [0 1];
axs.XLabel.String = 'Frequency $[Hz]$';
axs.YLabel.String = 'ASD $[\frac{G^2}{Hz}]$';
axs.YAxis.Exponent=0;
set([axs.Title, axs.XLabel, axs.YLabel], ...
    'FontName', 'AvantGarde', 'Interpreter', 'latex');
%set(axs,'YTick',[-pi,0,pi],'YTickLabel',{'-\pi','0','\pi'});
set(gcf, 'Color', [1 1 1])

end
