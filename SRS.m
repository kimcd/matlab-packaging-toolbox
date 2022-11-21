classdef SRS

    properties
        frequencies
        accelerations
    end

    properties(Constant)
        g = 386.1;  % [in/s^2]
    end
    methods
        function this = SRS(f, g)
            this.frequencies = f; 
            this.accelerations = g;
        end
        
        function plot_handle = plot_SRS(this)
            


        end

        
        function mv = get_modal_velocity(this)
            modalVelocity(this.frequencies, this.accelerations);
        end


    end



end

