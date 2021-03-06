%% Objective of the overall optimization was to minimize MTOW. 
% This code takes in the optimal set of wings, and using the local
% sensitivities to wing parameters of interest, calculates the best 
% Pareto-optimal wing option
global savefilename
savedfilename = 'storedWingEvaluationsDOE.mat';
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

figure(11)
subplot(1,2,1)
plot(LoDPareto,wingPickCost,'ro')
hold on
plot(sol(1,1),sol(1,3),'p')
xlabel('L/D')
ylabel('\delta MTOW/MTOW')
grid on

subplot(1,2,2)
plot(W_wingPareto, wingPickCost,'ro')
hold on
plot(sol(1,2),sol(1,3),'p')
xlabel('W_{wing}');
ylabel('\delta MTOW/MTOW')
grid on



% % Also looking for the behavior of the DOE
% LoDSens = -1/2*V_windSens;
% % W_wingSens = (W_wing/W_wingRef).*(W_tot/MTOWRef)*gSens;
% W_wingSens = (W_wing)/(W_tot)*gSens;
% wingPickCost = LoDSens.*LoD./LoDRef +...
%     W_wingSens.*W_wing./W_wingRef;
% 
% figure(11);
% plot3(LoD,W_wing,wingPickCost,'ro')

%% Best wing design analysis
global newWing newRef cri
bestDesign = wings(sol(1,4))
evalWing(bestDesign.arr,sol(1,4))
[newWing newRef cri] = geoDescription(bestDesign.arr) 
geoMod(0) % To be able to check it out in AVL

%% Calculating gradients of objectives for Pareto-optimal wings
LoDgrad = []; W_winggrad = []; Lgrad =[]; fuelVolumegrad = []; delta0bgrad = [];
for i = 1
    ind = paretoWings(i)
    arr = wings(ind).arr;
    LoDInit = LoD(ind);
    WInit = W_wing(ind);
    LInit = wings(ind).L;
    fuelVolumeInit = fuelVolume(ind);
    delta0bInit = delta0b(ind);
    step = [.02 .02 .02 .2 .2 .2 .2 .2 .2];
    for j = 1:9
        disp((i-1)*9+j)
        dx = step(j);
        arrdx = arr; arrdx(j) = arrdx(j) + dx;
        [Ldx, LoDdx, W_wingdx, fuelVolumedx, delta_tipdx, extrainfo] = evalWing(arrdx,0);
        LoDgrad(i,j) = (LoDdx - LoDInit)/dx;
        W_winggrad(i,j) = (W_wingdx-WInit)/dx;
        Lgrad(i,j) = (Ldx-LInit)/dx;
        fuelVolumegrad(i,j) = (fuelVolumedx-fuelVolumeInit)/dx;
        delta0bgrad(i,j) = (delta_tipdx/(arr(1)*initRef(3))-delta0bInit)/dx;
    end
end

