%% This executes simulated annealing (SA) algorithm on the initial aircraft design
global initWing initRef 
global delta0b_max fuelVolReq
global V rho a
global bInd crInd lamInd aInd

% Flight parameters
V = 25;         % flight speed [m/s]
rho = 0.738;    % air density [kg/m^3]
a = 320;        % soeed of sound at flight altitude[m/s]

% Defining constraints
delta0b_max = 0.2; %maximum tip deflection is 0.2*b at a load factor of 5
fuelVolReq = 0.0265; %fuel volume required, m^3
bInd = 1; crInd = 2; lamInd = 3; aInd = 4:9;

%Initial inputs
initRef = [15.91 0.755 21.06]; %Sref, Cref, Bref (ft^2, ft, ft)
% Format:   Xle(ft) Yle(ft) Zle(ft) Chord(ft)   Ainc(deg) options not used
initWing = [0       0       0       1           0       0 0;
            0       3       0       1           0       0 0;
            0.0655  6       0       0.7378      0.25    0 0;
            0.1202  8.5     0       0.5194      0.5     0 0;
            0.142   9.5     0       0.432       0.75    0 0;
            0.1645  10.53   0       0.342       1       0 0];

% Need access to avl geometries folder
addpath('avl_geometries');
addpath('wing_eval')
addpath('wing_eval\savedruns')
addpath('DERIVESTsuite')