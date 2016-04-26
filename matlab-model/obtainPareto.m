% This function generates the Pareto Front for LoD and W_wing for a given
% set of evaluated wings
% Note: make sure that you are pulling the right set of data in wingFSCheck
init;
wingFSCheck;
wingFSCPlot;

%% Plot the set of wings to look at the Pareto front
figure(2);
plot(W_wing, LoD,'b.')
xlabel('W_{wing} (N)');
ylabel('L/D')
title('DOE results, W_{wing} vs. L/D');
grid on

%% Find the non-dominated set of solutions
sol = prtp([-LoD' W_wing'])
LoDPareto = -sol(:,1);
W_wingPareto = sol(:,2);
paretoWings = [];
for i = 1:length(LoDPareto)
    [tf, index] = ismember(LoDPareto(i), LoD);
    paretoWings(i) = index;
end

%% Finding the bounds of the Pareto frontier
% nPareto = 50;
% weights = [0 logspace(-1,1,nPareto-1)];
% %Stores the INDEX of the Pareto-optimal wings
% paretoWings = [];
% cost = ones(1,nPareto)*100;
% for i = 1:nPareto
%     for j = 1:length(validWings)
%         newCost = -LoD(j) + weights(i)*W_wing(j);
%         if newCost < cost(i) 
%             cost(i) = newCost;
%             paretoWings(i) = j;
%         end
%     end
% end
% 
% % Removing repeated Pareto wings and sorting
% paretoWings = unique(paretoWings);
% LoDPareto = LoD(paretoWings);
% W_wingPareto = W_wing(paretoWings);
% sortArray = [LoDPareto' W_wingPareto' paretoWings']
% sortArray = sortrows(sortArray,1);
% paretoWings = sortArray(:,3)';
% %% Running AWS to find the wings that can't be found by weighted sums
% paretoWingsAWS = paretoWings; 
% for i = 1:length(paretoWings)-1
%     AWSInd = []; AWSInd1 = []; AWSInd2 = []; AWSInd3 = []; AWSInd4 = [];
%     pareto1 = paretoWings(i);
%     pareto2 = paretoWings(i+1);
%     LoDAWS = sort([LoD(pareto1),LoD(pareto2)]);
%     W_wingAWS = sort([W_wing(pareto1),W_wing(pareto2)]);
%     AWSInd1 = LoD > LoDAWS(1);
%     AWSInd2 = LoD < LoDAWS(2);
%     AWSInd3 = W_wing > W_wingAWS(1);
%     AWSInd4 = W_wing < W_wingAWS(2);
%     AWSInd = AWSInd1.*AWSInd2.*AWSInd3.*AWSInd4;
%     AWSInd = find(AWSInd); % finding the in-between points
%     paretoWingsAWS = [paretoWingsAWS AWSInd];
% end
% 
% % Clearing dominated solutions
% LoDAWS = [];
% W_wingAWS = [];
% dominated = true;
% while dominated
%     for i = 1:length(paretoWingsAWS)-1;
%         for j = i+1:length(paretoWingsAWS);
%             
%         end
%     end
% end
% 
% 
%% Plotting Pareto Wings
figure(2); 
hold on
plot(W_wing(paretoWings),LoD(paretoWings),'ro');

% %% PSO of Pareto Wings to find optimal aoa
% global count
% count = 0;
% paretoWingsAOA = [];
% W_wingaoa = []; LoDaoa = [];
% for i = 1:length(paretoWings);
%     arr = wings(paretoWings(i)).arr
%     [x, fval] = PSrun(arr,'aoa')
%     paretoWingsAOA(i,:) = x;
% end
% 
% for i = 1:length(paretoWings)
%     [cost, extrainfo] = SAWingEval(paretoWingsAOA(i,:));
%     LoDaoa(i) = extrainfo.LoD;
%     W_wingaoa(i) = extrainfo.W_wing;
% end
% 
%% Plotting new Pareto Frontier
% figure(2); 
% hold on
% plot(W_wingaoa,LoDaoa,'go');



