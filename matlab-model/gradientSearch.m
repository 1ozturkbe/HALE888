global count
count = 0;
init;
initMod = [1 1 .5 0 0 0 0 0 0];
lower = [0.8 0.8 0 -2 -2 -2 -2 -2 -2];
upper = [1.2 1.2 1 2 2 2 2 2 2];
[costInit, infoInit] = SAWingEval(initMod);

% options = optimoptions(@fminunc, ...
%     'Display','iter-detailed',...%'FiniteDifferenceStepSize', diffminchange
%     'DiffMinChange', 0.1);

[x funeval] = fmincon(@SAWingEval, initMod, [],[],[],[], lower, upper);
bestDesign = xbest(end,:);
 
designAnalysis;