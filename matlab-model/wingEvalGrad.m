function [cost, extrainfo] = wingEvalGrad(arr)
global initRef
global count
count = count + 1
[Lift, LoD, W_wing, fuelVolume, delta_tip, ~] = evalWing(arr, count);
b = arr(1)*initRef(3);
delta0b = delta_tip/b;
[cost, extrainfo2] = costFunction(Lift, LoD, W_wing, fuelVolume, delta0b);
extrainfo = struct('Lift', Lift, 'LoD', LoD, 'W_wing', W_wing,...
    'fuelVolume', fuelVolume, 'delta_tip', delta_tip, ...
    'delta0b', delta0b);
extrainfo = catstruct(extrainfo, extrainfo2);

disp(cost);
disp(extrainfo)


    
