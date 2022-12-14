function z_inf = steinberg(...
    board_length, ...
    component_factor, ...
    board_thickness, ...
    position_factor, ...
    component_length)
% STEINBERG returns the maximum (3-sig RMS) at the center of the PCB for
%   component to withstand 20 million reversals. 
%
%   Inputs:
%       component_factor - 
%
%   C.KIM 22Nov2022, JHUAPL
%%
STEINBERG_CONST = 0.00022;

z_inf = STEINBERG_CONST * board_length / ...
    (component_factor * ...
    board_thickness * ... 
    position_factor * ... 
    sqrt(component_length));

end

