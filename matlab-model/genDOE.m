tic 
global newWing newRef newInd cri bi
%Defining the DOE space
nFactors = 9;
nLevels = 5;
V = 25; % flight speed, m/s
rho = 0.738; % air density, kg/m^3

% J selected so that
% nRows = nFactors^J
% and
% nCols = nFactors = (nRows^J-1)/(nRows-1)

%syms nRows nCols J nLevels
% assume(nLevels,'integer')
%assume(nRows,'integer')
%assume(nCols,'integer')
%assume(J,'integer')

%eq1 = nRows == nLevels^J;
%eq2 = nCols == nFactors;
%eq3 = nCols == (nLevels^J-1)/(nLevels-1);

%[nRows nCols J] = solve([eq1 eq2 eq3],[nRows nCols J])
%df = oa_permut(nLevels,nFactors,J)

%% Generating fractional factorial representation
lam = 0.2:0.2:1; nlam = length(lam); % taper ratio adjustment
bScaling = 0.8:0.1:1.2; nbScaling = length(bScaling); % span scaling
crScaling = 0.8:0.1:1.2; ncrScaling = length(crScaling); % root chord scaling
alphaI = -2:1:2; nalphaI = length(alphaI); % angle of attack adjustment 
%The format of the representation is [b cr lam alphaI*6]

%df = oa_permut(nLevels,nFactors,J)
fullFact = fullfact(ones(1,nFactors)*nLevels); %full factorial design, calculation of all levels
fullFactInd = 1:1:size(fullFact,1);                  %FF design indices
nWings = 2000;                                 %Number of wings to sample  
sampleInd = datasample(fullFactInd,nWings,'Replace',false); %sampling indices

% Sample full factorial to generate fractional factorial
factorLevels = fullFact(sampleInd,:);

%% Generating the geometry inputs
%Initial inputs
initRef = [15.91 0.755 21.06]; %Sref, Cref, Bref (ft)
initWing = [0 0 0 1 0 0 0;
    0 3 0 1 0 0 0;
    0.0655 6 0 0.7378 0.25 0 0;
    0.1202 8.5 0 0.5194 0.5 0 0;
    0.142 9.5 0 0.432 0 0.75 0;
    0.1645 10.53 0 0.342 1 0 0];
%Xle Yle Zle Chord Ainc Nspanwise Sspace

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

lami = 0; bi = 0; cri = 0; 
structEval = []; %mass and tip deflection each stored
fuelEval = []; %fuel volume of each wing stored 
LoDEval = [];
for i = 1:nWings
    newInd = i;
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
    structEval = [structEval; [W_wing, delta_tip]];
    fuelVolume = fuelVol(newWing)*.3048^3;
    fuelEval = [fuelEval; fuelVolume];
    %Putting the newWing into AVL format using geoMod
    geoMod;
    a = 320; %m/s
    total_weight = 71.41*.454*9.81+W_wing; %N
    [LoD] = LoDeval(newInd, total_weight, newRef(1), rho, V, a)
    LoDEval = [LoDEval; LoD];
end

toc
    
