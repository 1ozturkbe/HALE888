addpath('wing_eval/savedruns')
load('storedWingEvaluationsGrad.mat');
global initRef

wings = savedEvaluations.values;
keys = savedEvaluations.keys;

loadedWings = cell(length(wings),1);

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
   wingRes.W_tot = W_tot;
   wingRes.delta0b = delta0b;
   runname = wingRes.extrainfo.runname;
   runnumber = regexp(runname, '\d+', 'match'); 
   runnumber = str2double(runnumber{1});
   [wingRes.cost, wingRes.costextra] = costFunction(L, LoD, W_wing, fuelVolume, delta0b);
   loadedWings{runnumber} = wingRes;
end