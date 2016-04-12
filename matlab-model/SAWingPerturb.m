function pertWing = SAWingPerturb(mod)
% Perturbs the wing mod function for simulated annealing
global bInd crInd lamInd aInd
pertWing = zeros(1,length(mod));
pertWing(aInd) = -2 + rand(length(aInd),1)*4;
pertWing(bInd) = .8 + rand()*0.4;
pertWing(crInd) = .75 + rand()*.5;
pertWing(lamInd) = rand();