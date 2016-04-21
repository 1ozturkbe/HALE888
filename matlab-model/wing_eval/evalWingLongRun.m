function [L, LoD, W_wing, fuelVolume, delta_tip, extrainfo] = evalWingLongRun(arr, newInd)
% usage:
% vect = [1 1 0.5 0 0 0 0 0 0]
% [L, LoD, W_wing, fuelVolume, delta_tip] = evalWing(vect)
global rho V a
global newWing newRef
global xarr
xarr = [xarr arr];
disp(arr)
[wingDescription, wingRef, cri] = geoDescription(arr);

% Evaluating performance of wings (structural, fuel capacity)
[W_wing, delta_tip] = structRun(wingRef, cri);
fuelVolume = fuelVol(wingDescription);
%Putting the newWing into AVL format using geoMod
newWing = wingDescription;
newRef = wingRef;
geoMod(newInd);
%total_weight = 71.41*.454*9.81+W_wing; %N
[L, LoD, extrainfo] = LoDeval(newInd, wingRef(1), rho, V, a);



    
