function [x,fval,exitflag,output] = PSrun(guess,strDesc)
% guess = [0.9342    0.9674    0.3193   -0.9684 ...
%    -0.9684   -0.9684   -0.9684   -0.9684   -0.9684];
lb = []; ub = [];
swarmSize = 0; maxIter = 0;
%Iterate through all variables
if strcmp(strDesc,'all')
    lb(1,1:3) = guess(1,1:3)-0.2;
    ub(1,1:3) = guess(1,1:3)+0.2;
    lb(1,4:9) = guess(1,4:9)-2;
    ub(1,4:9) = guess(1,4:9)+2;
    swarmSize = 15;
    maxIter = 30;
% Iterate through angles of attack
elseif strcmp(strDesc,'aoa')
	lb(1,1:3) = guess(1,1:3);
    ub(1,1:3) = guess(1,1:3);
    lb(1,4:9) = guess(1,4:9)-2;
    ub(1,4:9) = guess(1,4:9)+2;
    swarmSize = 15;
    maxIter = 40;
end
options = optimoptions('particleswarm','SwarmSize',swarmSize,'MaxIter',maxIter);
[x,fval,exitflag,output] = particleswarm(@SAWingEval,9,lb,ub,options)