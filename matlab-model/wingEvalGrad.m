function cost = wingEvalGrad(arr, newInd)
% usage:
% vect = [1 1 0.5 0 0 0 0 0 0]
% [L, LoD, W_wing, fuelVolume, delta_tip] = evalWing(vect)
global rho V a
global newWing newRef
global xarr
global bi delta0b_max fuelVolReq
xarr = arr;
disp(arr)
[wingDescription, wingRef, cri] = geoDescription(arr);
%Putting the newWing into AVL format using geoMod
newWing = wingDescription;
newRef = wingRef;
geoMod(newInd);
% Evaluating performance of wings (structural, fuel capacity)
[L, LoD, ~] = LoDeval(newInd, wingRef(1), rho, V, a);
[W_wing, delta_tip] = structRun(wingRef, cri);
fuelVolume = fuelVol(wingDescription);
greaterthanzero1 = delta_tip /(2*bi) - delta0b_max;
greaterthanzero2 = fuelVolReq - fuelVolume;
equaltozero = 71.41*.454*9.81+W_wing - L;

W_tot = 71.41*.454*9.81+W_wing; %N
% Evaluating costs (constraints)
liftCost = abs(W_tot-L);
if L < W_tot
    liftCost = liftCost^2 + 1;
end
weightCost = W_wing*0.1;
deltaCost = 0; fuelCost = 0;
if delta_tip /(2*bi) > delta0b_max
    deltaCost = (delta_tip/2*bi - delta0b_max)*6;
end
if fuelVolume < fuelVolReq
    fuelCost = -(fuelVolume-fuelVolReq)*1000;
end
cost = -LoD + deltaCost + fuelCost + liftCost + weightCost;
end



    
