function [L, LoD, W_wing, fuelVolume, delta_tip, bi] = evalWing(arr, newInd)
% usage:
% vect = [1 1 0.5 0 0 0 0 0 0]
% [L, LoD, W_wing, fuelVolume, delta_tip] = evalWing(vect)
global rho V a

[wingDescription, wingRef] = geoDescription(arr);

% Evaluating performance of wings (structural, fuel capacity)
[W_wing, delta_tip] = structRun();
fuelVolume = fuelVol(wingDescription);
%Putting the newWing into AVL format using geoMod
geoMod;
%total_weight = 71.41*.454*9.81+W_wing; %N
[L, LoD] = LoDeval(newInd, wingRef(1), rho, V, a);



    
