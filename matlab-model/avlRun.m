%% Create run file
% Code readapted from http://www.uavs.us/2011/12/02/matlab-avl-control/
tic
% AVL located in AVL/airfoils/avl.exe
% .avl filepath relative to avl.exe
avlfile = ['avl_geometries/' runname, '.avl'];
M = MN(choice);
velocity = M*a;
filename = 'runs/alpharun'; %name of the Run file
alphas = -3:15;

%delete([filename '*'])

%% Operate AVL
% Overwrite input file
fid = fopen([filename, '.run'], 'w');
%Load the AVL definition of the aircraft
fprintf(fid, 'LOAD %s\n', avlfile);

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
              '../',filename,'%d.st\n'...
              'o\n'],alpharep);

% Drop out of OPER menu, quit AVL and close the file
fprintf(fid, '\n');
fprintf(fid, 'Quit\n'); 
fclose(fid);

% Run filename.run with AVL
cd('xfoilavl');
[status,result] = dos(['avl.exe < ../' filename '.run']);
disp(result);
cd('../');

%% Reap the results
CL = [];
CD = [];
CM = [];
xnp = [];
for alpha = alphas
    runinfo = getruninfo([filename num2str(alpha) '.st']);
    CL = [CL runinfo.CLtot];
    CD = [CD runinfo.CDtot];
    CM = [CM runinfo.CMtot];
    xnp = [xnp runinfo.xnp];
end
save(['avl results/' runname],'CL','CD','CM','xnp');
toc