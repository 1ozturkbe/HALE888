function [cost, extrainfo] = costFunction(L, LoD, W_wing, fuelVolume, delta0b)
global delta0b_max fuelVolReq
W_tot = 71.41*.454*9.81+W_wing; %N
% Evaluating costs (constraints)
liftCost = abs(W_tot-L);
if L < W_tot
    liftCost = liftCost^2 + 1;
end
weightCost = W_wing*0.1;
deltaCost = 0; fuelCost = 0;
if delta0b / 2 > delta0b_max
    deltaCost = (delta0b / 2 - delta0b_max)*6;
end
if fuelVolume < fuelVolReq
    fuelCost = -(fuelVolume-fuelVolReq)*1000;
end
cost = -LoD + deltaCost + fuelCost + liftCost + weightCost;
extrainfo = struct('W_tot', W_tot, ...
    'fuelCot', fuelCost, 'deltaCost', deltaCost,...
    'liftCost',liftCost,'weightCost', weightCost);