%% Objective of the overall optimization was to minimize MTOW. 
% This code takes in the optimal set of wings, and using the local
% sensitivities to wing parameters of interest, calculates the best 
% Pareto-optimal wing option

% Sensitivities of interest
gSens = 1.039;
V_windSens = 0.3181; 

% Deriving sensitivities to wing optimization parameters
LoDSens = -2*V_windSens;
W_wingSens
