global savedfilename not_save_geometry_file count
%savedfilename = 'gradPareto.mat';
not_save_geometry_file = true;

global costarr
count = 0;
init;
global scaling
scaling = 1;
%initMod = [1.0237 1.1158 0.1 0 0 0 0 0 0];
xscaled = x;
xscaled(2) = scaling*x(2);
initMod = xscaled;
costarr = [];
lower = [0.8 scaling*0.8 0 -2 -2 -2 -2 -2 -2];
upper = [1.2 scaling*1.2 1 2 2 2 2 2 2];
%diffminchange = [0.05 scaling*0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05];

%'FiniteDifferenceStepSize', diffminchange,...
options = optimoptions(@fminunc, ...
    'Display','iter-detailed',...
    'FiniteDifferenceType', 'central',...
    'MaxFunctionEvaluations', 50);

[x feval] = fmincon('wingEvalGrad', initMod, [],[],[],[], ...
    lower, upper);
bestDesign = x(end,:);
 
%designAnalysis;