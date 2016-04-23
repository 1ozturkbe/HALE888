addpath('wing_eval/savedruns')
%import('storedWingEvaluations.mat');
global delta0b_max fuelVolReq initRef

wings = savedEvaluations.values;
keys = savedEvaluations.keys;

validWings = [];

for i = 1:length(wings)
   wingRes = wings{i};
   L = wingRes.L;
   W_wing = wingRes.W_wing; 
   W_tot = W_wing + 71.41*.454*9.81;
   fuelVolume = wingRes.fuelVolume;
   b = wingRes.arr(1)*initRef(3);
   delta0b = wingRes.delta_tip/b;
   if L > 0.95*W_tot && delta0b < delta0b_max && fuelVolume > fuelVolReq
       validWings = [validWings wingRes];
   end
end
