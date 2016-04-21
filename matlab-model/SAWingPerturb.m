function pertWing = SAWingPerturb(mod)
% Perturbs the wing mod function for simulated annealing
global bInd crInd lamInd 
global fuelCost liftCost initMod
pertWing = [];
for i = 1:length(mod)
    if i == bInd
        pertWing(i) = initMod(i);
        if fuelCost > 0
            pertWing(i) = mod(i)*(1+0.05*rand());
        end
    elseif i == crInd
        pertWing(i) = initMod(i);
        if fuelCost > 0
            pertWing(i) = mod(i)*(1+0.05*rand());
        end
    elseif i == lamInd
        pertWing(i) = mod(i);
    else    
        pertWing(i) = initMod(i) - 1 + rand()*2;
    end
end
% for i = 1:length(mod)
%     if i == bInd
%         %pertWing(i) = .8 + rand()*0.4;
%         pertWing(i) = mod(i);
%     elseif i == crInd
%         %pertWing(i) = .75 + rand()*.5;
%         pertWing(i) = mod(i);
%     elseif i == lamInd
%         %pertWing(i) = rand();
%         pertWing(i) = mod(i);
%     else    
%         if fuelCost > 0
%             pertWing(i) = mod(i) + rand()*0.5;
%         else
%             pertWing(i) = initmod(i) - 1 + rand()*2;
%         end
%     end
% end
% for i = 1:length(mod)
%     if i == bInd
%         pertWing(i) = mod(i)*(0.9 + rand()*0.2);
%     elseif i == crInd
%         pertWing(i) = mod(i)*(.9 + rand()*.2);
%     elseif i == lamInd
%         pertWing(i) = max(min(mod(i)*(0.8 + rand()*.4),1),.2);
%     else    
%         pertWing(i) = mod(i) -0.5 + rand()*1;
%         if pertWing(i) > 2
%             pertWing(i) = 2;
%         elseif pertWing(i) < -2
%             pertWing(i) = -2;
%         end
%     end
% end
