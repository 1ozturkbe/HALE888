function [cost, extrainfo] = gradientWingEval(modArray)
global count
count = count + 1;
disp(count);

global Lift fuelVolume delta_tip W_tot
[Lift, LoD, W_wing, fuelVolume, delta_tip, extrainfo2] = evalWing(modArray, count);
W_tot = 71.41*.454*9.81+W_wing; %N

cost = -LoD;
disp(cost)

addpath('catstruct')
extrainfo = struct('Lift', Lift, 'LoD', LoD, 'W_wing', W_wing,...
    'W_tot',W_tot,'fuelVolume', fuelVolume, 'delta_tip', delta_tip);
extrainfo = catstruct(extrainfo, extrainfo2);