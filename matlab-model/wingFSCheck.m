addpath('wing_eval/savedruns')
%import('storedWingEvaluations.mat');
global delta0b_max fuelVolReq

wings = savedEvaluations.values;
keys = savedEvaluations.keys;

validWings = [];
cFuel = false;
cDelta = false;
c

for i = 1:length(keys)
   wingRes = wings{i};
   fuelVolume = wingRes.fuelVolume;
   delta_tip = wingRes.delta_tip;
   L = wingRes.L;   
end
