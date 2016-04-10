function pertWing = SAWingPerturb(mod)
% Perturbs the wing mod function for simulated annealing
global bInd crInd lamInd 
pertWing = [];
for i = 1:length(mod)
    if i == bInd
        pertWing(i) = .8 + rand()*0.4;
    elseif i == crInd
        pertWing(i) = .75 + rand()*.5;
    elseif i == lamInd
        pertWing(i) = rand();
    else    
        pertWing(i) = -2 + rand()*4;
    end
end
