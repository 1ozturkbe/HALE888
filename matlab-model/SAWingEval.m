function [cost, deltaCost, fuelCost, liftCost, weightCost] = SAWingEval(modArray)
global count
count = count + 1
global delta0b_max fuelVolReq bi

[Lift, LoD, W_wing, fuelVolume, delta_tip] = evalWing(modArray, count);
W_tot = 71.41*.454*9.81+W_wing; %N

% Evaluating costs (constraints)
liftCost = abs(W_tot-Lift);
if Lift < W_tot
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