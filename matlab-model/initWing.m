% Code that puts in the initial guess for the wing configuration.

% Design variables
NSection = 6;
Spacing = 'lin'; % can also be 'sin' 
Airfoils = ['c141f','hq2010','sd7032','sg6041'];

% Cruise regime
V = 25; % flight speed, m/s
rho = 0.738; % air density, kg/m^3

% Non-dimensional
AR = 27.87; % Aspect ratio
Nmax = 5; % Load factor at failure

%Lengths
b = 21.06; %ft
h_spar = 0.02764; %m
c_avg = b/AR;

%Areas
A_capcent = 9.979*10^-5; % Spar cap area at wing root
%Volumes
Vol_fuel = 0.02653; % Fuel volume, m^3
Vol_cap = 0.0002135; % Cap volume, m^3
%Weights 

%Forces and moments

%% Calculating wing parameters



