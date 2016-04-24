% This function generates the Pareto Front for LoD and W_wing for a given
% set of evaluated wings
% Note: make sure that you are pulling the right set of data in wingFSCheck
init;
wingFSCheck;
wingFSCPlot;

%% Plot the set of wings to look at the Pareto front
figure(2);
plot(W_wing, LoD,'b.')
xlabel('W_wing (N)');
ylabel('L/D')
title('DOE results, W_{wing} vs. L/D');
grid on

%% Finding the bounds of the Pareto frontier
nPareto = 20;
weights = [0 logspace(-1,1,nPareto-1)];
%Stores the INDEX of the Pareto-optimal wings
paretoWings = [];
cost = ones(1,nPareto)*100;
for i = 1:nPareto
    for j = 1:length(validWings)
        newCost = -LoD(j) + weights(i)*W_wing(j);
        if newCost < cost(i) 
            cost(i) = newCost;
            paretoWings(i) = j;
        end
    end
end

% Removing repeated Pareto wings
paretoWings = unique(paretoWings);

figure(2); 
hold on
plot(W_wing(paretoWings),LoD(paretoWings),'ro');


