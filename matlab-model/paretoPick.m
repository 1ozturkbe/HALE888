%% Objective of the overall optimization was to minimize MTOW. 
% This code takes in the optimal set of wings, and using the local
% sensitivities to wing parameters of interest, calculates the best 
% Pareto-optimal wing option

% Sensitivities of interest
gSens = 1.039;
V_windSens = 0.3181; 

% Reference values from optimization
W_wingRef = 7.514*.454*9.81; %N
MTOWRef = 83.14*.454*9.81; %N
LoDRef = 47; 

% Deriving sensitivities to wing optimization parameters
LoDSens = -1/2*V_windSens;
W_wingSens = W_wingRef./MTOWRef*gSens;

wingPickCost = LoDSens.*LoDPareto./LoDRef +...
    W_wingSens.*W_wingPareto./W_wingRef;

sol = [LoDPareto, W_wingPareto, wingPickCost, paretoWings']
sol = sortrows(sol,3)

figure(10)
plot3(LoDPareto,W_wingPareto,wingPickCost,'ro')
hold on
plot3(sol(1,1),sol(1,2),sol(1,3),'p')
xlabel('L/D');
ylabel('W_{wing}')
zlabel('\delta MTOW/MTOW')
grid on



%% Also looking for the behavior of the DOE
% LoDSens = -1/2*V_windSens;
% W_wingSens = (W_wing/W_wingRef).*(W_tot/MTOWRef)*gSens;
% wingPickCost = LoDSens.*LoD./LoDRef +...
%     W_wingSens.*W_wing./W_wingRef;
% 
% figure(11);
% plot3(LoD,W_wing,wingPickCost,'ro')

%% Best wing design analysis
bestDesign = wings(sol(1,4))
evalWing(bestDesign.arr,sol(1,4))
