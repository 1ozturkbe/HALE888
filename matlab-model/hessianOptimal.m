addpath('DERIVESTsuite');
global savedfilename not_save_geometry_file count
savedfilename = 'hessianPareto1.mat';
not_save_geometry_file = true;
count = 0;
% [G, gerr] = gradest(@wingEvalGrad, x);
[H, err] = hessdiag(@wingEvalGrad, x);

% dx = [0.02 0.02 0.02...
%     0.1 0.1 0.1 0.1 0.1 0.1];
% left = wingEvalGrad(x+dx);
% right = wingEvalGrad(x-dx);
% g = (right-left)./(2*dx);