
global savedfilename not_save_geometry_file count
savedfilename = 'storedWingEvaluationsHessian.mat';
not_save_geometry_file = true;
count = 0;

H = hessian('wingEvalGrad', x);