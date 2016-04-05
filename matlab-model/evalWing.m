function [L, LoD, W_wing, FuelVol, delta_tip] = evalWing(arr) 

V = 25; % flight speed, m/s
rho = 0.738; % air density, kg/m^3
a = 320; %m/s

% Format of arr is as follows:
% arr = [bScaling crScaling lam a1 a2 a3 a4 a5 a6]

%% Generating the geometry inputs
%Initial inputs
initRef = [15.91 0.755 21.06]; %Sref, Cref, Bref (ft^2, ft, ft)
initWing = [0 0 0 1 0 0 0;
    0 3 0 1 0 0 0;
    0.0655 6 0 0.7378 0.25 0 0;
    0.1202 8.5 0 0.5194 0.5 0 0;
    0.142 9.5 0 0.432 0.75 0 0;
    0.1645 10.53 0 0.342 1 0 0];
%Xle Yle Zle Chord Ainc Nspanwise Sspace (ft, ft, ft, ft, radians)

%% Creating more wings
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

[W_wingInit, delta_tipInit] = structRun();
fuelVolumeInit = fuelVol(newWing);
total_weight = 71.41*.454*9.81+W_wingInit; %N

lami = 0; bi = 0; cri = 0; 
structEval = []; %mass and tip deflection each stored
fuelEval = []; %fuel volume of each wing stored 
LoDEval = [];
for i = 1:nWings
    newInd = i
    newWing = initWing;
    newRef = initRef;
    flInt = factorLevels(i,:); %Levels of factors for current design
    alphaij = [];
    cri = 0;
    %Deciphering wing modifications from the factor levels
    for j = 1:nFactors
        if j == bInd
            bi = bInit*bScaling(flInt(j)); %Note that bi is the half-span
        elseif j == crInd
            cri = crInit*crScaling(flInt(j)); %root chord
        elseif j == lamInd
            lami = lam(flInt(j)); %taper ratio
        else
            alphaij = [alphaij alphaI(flInt(j))]; %angle mod for each section
        end
    end
    %Rewriting wing reference array
    newRef(3) = 2*bi*bScaling(flInt(j)); %reference span
    newRef(1) = 2*(bCent*cri + (1+lami)/2*cri*(bi-bCent)); %reference area
    newRef(2) = newRef(1)/newRef(3); %reference chord
    %Rewriting wing geometry array
    newWing(3:6,2) = newWing(3:6,2)*bScaling(flInt(bInd)); % scaling y position of le
    chordArr = [cri]; % changing all of the wing chords and xles
    ctip = cri*lami;
    chordArr = [chordArr; linspace(cri,cri*lami,5)'];
    newWing(:,1) = chordArr/4; % Wing c/4 aligned along wing. 
    newWing(:,4) = chordArr;
    newWing(:,5) = newWing(:,5) + alphaij';
    %Evaluating performance of wings (structural, fuel capacity)
    [W_wing, delta_tip] = structRun();
    FuelVol = fuelVol(newWing);
    %Putting the newWing into AVL format using geoMod
    geoMod;
    %total_weight = 71.41*.454*9.81+W_wing; %N
    [Lift, LoD] = LoDeval(newInd, newRef(1), rho, V, a);
end

toc
    
