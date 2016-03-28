%% Create run file
% TODO: test and convert to function
% Code readapted from http://www.uavs.us/2011/12/02/matlab-avl-control/
tic
% AVL located in avl_geometries/avl.exe
% .avl filepath relative to avl.exe
runname = 'hale';
M = 0.1314;
a = 340.3;
velocity = M*a;
avlfilepath = ['../avl_template_geometries/' runname, '.avl'];
runfilename = 'sweepalphas';
runfilepath = ['avl_run_inputs/' runfilename '.run'];
outfilename = 'angleofattack';
outfilepath = ['avl_run_outputs/' runfilename]; 
alphas = -3:15;

%% Operate AVL
% Overwrite input file
fid = fopen(runfilepath, 'w');
%Load the AVL definition of the aircraft
fprintf(fid, 'LOAD %s\n', avlfilepath);

% Disable Graphics
fprintf(fid,'PLOP\ng\n\n');
% Open the OPER menu and set the Mach number
fprintf(fid,'%s\n','OPER');   
fprintf(fid,'M \n');
fprintf(fid,'MN %6.4f\n \n',M);

% We need to repeat each angle for fprintf later on
alpharep = repmat(alphas,[2 1]);
alpharep = alpharep(:)';
fprintf(fid, ['a a %6.4f\n'...
              'x\n'...
              'st\n'...
              '../',outfilepath,'%d.st\n'...
              'o\n'],alpharep);
          
% Drop out of OPER menu, quit AVL and close the file
fprintf(fid, '\n');
fprintf(fid, 'Quit\n'); 
fclose(fid);

% Run filename.run with AVL
% preallocate filespace for the .st files, so that they can be overwritten
arrayfun(@(alpha) createrunfiles(...
    sprintf('%s%d.st',outfilepath,alpha)), alphas);
cd('airfoils_and_geometries');
[status,result] = dos(['avl.exe < ../' runfilepath]);
disp(result);
cd('../');

%% Reap the results
CL = [];
CD = [];
CM = [];
xnp = [];
% for alpha = alphas
%     runinfo = getruninfo([outfile num2str(alpha) '.st']);
%     CL = [CL runinfo.CLtot];
%     CD = [CD runinfo.CDtot];
%     CM = [CM runinfo.CMtot];
%     xnp = [xnp runinfo.xnp];
% end
% LoD = CL./CD;
toc