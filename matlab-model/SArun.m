%% This executes simulated annealing (SA) algorithm on the initial aircraft design
global initWing initRef newWing newRef
global delta0b_max fuelVolReq
global V rho a
global bInd crInd lamInd aInd
global bInit crInit bCent
global count

% Flight parameters
V = 25; % flight speed, m/s
rho = 0.738; % air density, kg/m^3
a = 320; %m/s

% Defining constraints
delta0b_max = 0.2; %maximum tip deflection is 0.2*b at a load factor of 5
fuelVolReq = 0.0265; %fuel volume required, m^3

%Initial inputs
initRef = [15.91 0.755 21.06]; %Sref, Cref, Bref (ft^2, ft, ft)
initWing = [0 0 0 1 0 0 0;
    0 3 0 1 0 0 0;
    0.0655 6 0 0.7378 0.25 0 0;
    0.1202 8.5 0 0.5194 0.5 0 0;
    0.142 9.5 0 0.432 0.75 0 0;
    0.1645 10.53 0 0.342 1 0 0];
%Xle Yle Zle Chord Ainc Nspanwise Sspace (ft, ft, ft, ft, radians)

addpath('avl_geometries');
% Note that the center 3 ft of the wing will be designer to be a straight
% section. 
bCent = 3;
bInd = 1; crInd = 2; lamInd = 3; aInd = 4:9;
SrefInit = initRef(1); crefInit = initRef(2); brefInit = initRef(3);
crInit = initWing(1,4); bInit = initWing(6,2);
newWing = initWing;
newRef = initRef;
bi = bInit;
cri = crInit;

initMod = [1 1 .5 0 0 0 0 0 0];
count = 0
costInit = SAWingEval(initMod);
% Running the simulated annealing algorithm
xo = initMod;
file_eval = 'SAWingEval';
file_perturb = 'SAWingPerturb';
options = [];

options=[];
%To=-(log(0.995)/costInit)^-1; 
options(1)=7800;
schedule=2; options(2)=schedule;
dT=.3; options(3)=dT;
neq=5; options(4)=neq;
nfrozen=.5; options(5)=nfrozen;
diagnostics=0; options(6)=diagnostics;
options(7)=0;

[xbest,Ebest,xhist]=SA(xo,file_eval,file_perturb,options);

bestDesign = xbest(end,:);
designAnalysis;

