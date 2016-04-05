function [L, LoD, W_wing, fuelVolume, delta_tip] = evalWing(arr) 

global newWing newRef initWing initRef newInd cri bi

V = 25; % flight speed, m/s
rho = 0.738; % air density, kg/m^3
a = 320; %m/s

% Format of arr is as follows:
% arr = [bScaling crScaling lam a1 a2 a3 a4 a5 a6]

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

bi = bInit*arr(bInd); %Note that bi is the half-span
cri = crInit*arr(crInd); %root chord
lami = arr(lamInd); %taper ratio
alphai = arr(aInd); %angle mod for each section


%Rewriting wing reference array
newRef(3) = 2*bi*arr(bInd); %reference span
newRef(1) = 2*(bCent*cri + (1+lami)/2*cri*(bi-bCent)); %reference area
newRef(2) = newRef(1)/newRef(3); %reference chord
%Rewriting wing geometry array
newWing(3:6,2) = newWing(3:6,2)*arr(bInd); % scaling y position of le
chordArr = [cri]; % changing all of the wing chords and xles
ctip = cri*lami;
chordArr = [chordArr; linspace(cri,cri*lami,5)'];
newWing(:,1) = chordArr/4; % Wing c/4 aligned along wing.
newWing(:,4) = chordArr;
newWing(:,5) = newWing(:,5) + arr(aInd)';
%Evaluating performance of wings (structural, fuel capacity)
[W_wing, delta_tip] = structRun();
fuelVolume = fuelVol(newWing);
%Putting the newWing into AVL format using geoMod
geoMod;
%total_weight = 71.41*.454*9.81+W_wing; %N
[L, LoD] = LoDeval(newInd, newRef(1), rho, V, a);



    
