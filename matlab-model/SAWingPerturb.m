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
