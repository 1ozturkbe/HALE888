function[Fmatrix, Xmatrix] = LinCom(X0, W, VLB, VUB, Options)

% function[Fmatrix, Xmatrix] = LinCom(X0, W, VLB, VUB, Options)
%
% This program solves the same MOP as the one being solved by the NBI method,
% and is mainly used for comparison of Pareto point spreads and flop counts.
% This finds Pareto optimal points by minimizing w'F(x).
% The weights can be specified as rows in W
% The user must pass the number of equality constraints in options(13) 
%
% Needed files:
%   myLinCom.m
%   myCon.m

    global g_Weight

    more off

    failures= 0;

    Fmatrix = [];
    Xmatrix = [];

    x       = X0;

    for i = 1:size(W,2)
        g_Weight = W(:,i);

        [x,f,fiasco] = fmincon('myLinCom',x,[],[],[],[],VLB,VUB,'myCon',Options);

        if fiasco>=0,
            Fmatrix = [Fmatrix, myFM(x)]; 
            Xmatrix = [Xmatrix, x];
        else  
            failures= failures+1;
        end
    end