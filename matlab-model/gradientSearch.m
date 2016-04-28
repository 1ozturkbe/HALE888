global savedfilename not_save_geometry_file count
savedfilename = 'storedWingEvaluationsGrad.mat';
not_save_geometry_file = true;

global count xarr costarr
addpath('DERIVESTsuite')
count = 0;
init;
initMod = [1.2 1.2 1 1 1 1 1 1 1];
xarr = initMod;
costarr = [];
lower = [0.8 0.8 0 -2 -2 -2 -2 -2 -2];
upper = [1.2 1.2 1 2 2 2 2 2 2];
diffminchange = [0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05];

options = optimoptions(@fminunc, ...
    'Display','iter-detailed',...
    'FiniteDifferenceStepSize', diffminchange,...
    'FiniteDifferenceType', 'central',...
    'MaxFunctionEvaluations', 50);

[x feval] = fmincon('wingEvalGrad', initMod, [],[],[],[], ...
    lower, upper);
bestDesign = x(end,:);
 
%designAnalysis;