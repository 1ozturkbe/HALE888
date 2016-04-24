addpath('wing_eval/savedruns')
%load('storedWingEvaluations.mat');
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
   delta_tip = wingRes.delta_tip;
   delta0b = delta_tip/b; % should this be /2b?
   LoD = wingRes.LoD;
   if L > 0.95*W_tot && delta0b < delta0b_max && fuelVolume > fuelVolReq
       wingRes.W_tot = W_tot;
       wingRes.delta0b = delta0b;
       wingRes.cost = costFunction(L, LoD, W_wing, fuelVolume, delta0b);
       validWings = [validWings wingRes];
   end
end

b = [];
cr
lam
b(1) = min(validWings.arr(1));
