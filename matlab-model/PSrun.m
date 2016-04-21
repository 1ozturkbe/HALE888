guess = [0.9342    0.9674    0.3193   -0.9684 ...
    -0.9684   -0.9684   -0.9684   -0.9684   -0.9684];
lb = []; ub = [];
lb(1,1:3) = guess(1,1:3)-0.2;
ub(1,1:3) = guess(1,1:3)+0.2;
lb(1,4:9) = guess(1,4:9)-3;
ub(1,4:9) = guess(1,4:9)+1;
options = optimoptions('particleswarm','SwarmSize',20,'MaxIter',30);
[x,fval,exitflag,output] = particleswarm(@SAWingEval,9,lb,ub,options)