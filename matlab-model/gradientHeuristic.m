global savedfilename not_save_geometry_file count
savedfilename = 'hessians.mat';
not_save_geometry_file = true;
count = 0;

xguess = x
% xhuess = bestDesign;
dxmax = [0.2 0.2 0.4 2 2 2 2 2 2];

xk = xguess;
xgoodi = [];
fgoodi = [];
xevals = {};
fevals = {};
out = [];
for i = 1:length(xguess)
    dxbound = dxmax(i);
    xminbound = xk(i) - dxbound;
    xmaxbound = xk(i) + dxbound;
    keeprunning = 1;
    iterationcount = 0;
    dx = dxbound/2;
    xevals{1} = [xk(i) - dx, xk(i) - dx/10, xk(i) + dx/10 xk(i) + dx];
    xevals{2} = xevals{1};
    xevals{3} = xevals{1};
    xevals{4} = xevals{1};
    fevals{1} = [];
    fevals{2} = [];
    fevals{3} = [];
    fevals{4} = [];
    
    for sol = 1:1
        for j = 1:length(xevals{sol})
                temp = xk;
                temp(i) = xevals{sol}(j);
                xi = temp;
%                 [LoD, ineq1, ineq2, eq] = wingEvalGrad(xi, 1);
%                 fevals{1} = [fevals{1} LoD];
%                 fevals{2} = [fevals{2} ineq1];
%                 fevals{3} = [fevals{3} ineq2];
%                 fevals{4} = [fevals{4} eq];
                fevals{1} = [fevals{1} wingEvalGrad(xi)];
        end
        xnews = [];
    
        while keeprunning && iterationcount <= 2;
            iterationcount = iterationcount + 1;
            [polys, info] = polyfit(xevals{sol},fevals{sol},1);
            disp(xevals{sol})
            disp(fevals{sol})
            disp(info.normr)
            if info.normr < 0.1
                keeprunning = 0; 
                xgood = [xevals{sol}(1) xevals{sol}(end)]; % save results
                fgood = [fevals{sol}(1) fevals{sol}(end)]; % save results
            else
                xminbound = xevals{sol}(1);
                xmaxbound = xevals{sol}(end);
                xevals{sol} = xevals{sol}(2:end-1);
                fevals{sol} = fevals{sol}(2:end-1);
            end
            if ~(keeprunning && iterationcount <= 2)
                xnews = [0.5*(xevals{sol}(1)+xminbound) 0.5*(xevals{sol}(end)+xmaxbound)];  
                temp = xk;
                temp(i) = xnews(1);
                xi = temp;
                %[out(1), out(2), out(3), out(4)] = wingEvalGrad(xi, 1);
                out(1) = wingEvalGrad(xi);
                temp = xk;
                temp(i) = xnews(2);
                xi = temp;
                %[out(1), out(2), out(3), out(4)] = wingEvalGrad(xi, 1);
                out(1) = wingEvalGrad(xi);
                fevals{sol} = [out(sol) fevals{sol} out(sol)];
                xevals{sol} = [xnews(1) xevals{sol} xnews(2)];
            end
        end
        idxstart = 2*sol-1;
        idxend = 2*sol;
        idx = idxstart:idxend;
        xgoodi(i,idx) = xgood;
        fgoodi(i,idx) = fgood;
    end
end
        