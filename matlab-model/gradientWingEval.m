function cost = gradientWingEval(modArray)
[Lift, LoD, W_wing, fuelVolume, delta_tip] = evalWing(modArray);
W_tot = 71.41*.454*9.81+W_wing; %N

% Evaluating costs (constraints)
liftCost = 0; deltaCost = 0; fuelCost = 0;
if Lift < W_tot
    liftCost = W_tot-Lift; 
end
if delta_tip /(2*bi) > delta0b_max
    deltaCost = (delta_tip/2*bi - delta0b_max)*6;
end
if fuelVolume < fuelVolReq
    fuelCost = -(fuelVolume-fuelVolReq)*1000;
end
weightCost = 0.2*W_wing;
cost = -LoD + deltaCost + fuelCost + liftCost + weightCost;