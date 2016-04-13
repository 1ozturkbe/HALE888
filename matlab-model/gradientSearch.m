global count xarr
count = 0;
init;
initMod = [1 1 .5 -1 -1 -1 -1 -1 -1];
xarr = initMod;
lower = [0.8 0.8 0 -2 -2 -2 -2 -2 -2];
upper = [1.2 1.2 1 2 2 2 2 2 2];
diffminchange = [0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05];
[costInit, infoInit] = SAWingEval(initMod);

options = optimoptions(@fminunc, ...
    'Display','iter-detailed',...
    'FiniteDifferenceStepSize', diffminchange,...
    'FiniteDifferenceType', 'central');

[x feval] = fmincon(@SAWingEval, initMod, [],[],[],[], ...
    lower, upper, @haleConstraints);
bestDesign = x(end,:);
 
designAnalysis;