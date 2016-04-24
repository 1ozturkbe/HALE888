function [cost, extrainfo] = wingEvalGrad(arr, newInd)
global initRef
[L, LoD, W_wing, fuelVolume, delta_tip, extrainfo] = evalWing(arr, newInd);
b = arr(1)*initRef(3);
delta0b = delta_tip/b;
cost = costFunction(L, LoD, W_wing, fuelVolume, delta0b);



    
