function [wingDescription, wingRef, cri] = geoDescription(arr) 
% vect = [1 1 0.5 0 0 0 0 0 0]
global bInd crInd lamInd aInd
global initWing
global bi

% Importing globals
%SrefInit = initRef(1); crefInit = initRef(2); brefInit = initRef(3);
crInit = initWing(1,4); bInit = initWing(6,2);
wingDescription = initWing;
wingRef = zeros(1,3);

% "Decipher" the vector
% Format of arr is as follows:
% arr = [bScaling crScaling lam a1 a2 a3 a4 a5 a6]
bi = bInit * arr(bInd);     % Note that bi is the half-span
cri = crInit * arr(crInd);  % root chord
lami = arr(lamInd);         % taper ratio
alphai = arr(aInd);         % angle mod for each section

% Note that the center 3 ft of the wing will be designer to be a straight
% section. 
bCent = 3; % [ft]

% Rewriting wing reference array
wingRef(1) = 2 * (bCent*cri + (1+lami)/2*cri*(bi-bCent)); % reference area
wingRef(3) = 2 * bi * arr(bInd);                          % reference span
wingRef(2) = wingRef(1) / wingRef(3);                     % reference chord

% Rewriting wing geometry matrix
% scaling y position of leading edge
wingDescription(3:6,2) = wingDescription(3:6,2) * arr(bInd); 
% ctip = cri*lami;
chordArr = [cri; linspace(cri,cri*lami,5)'];
wingDescription(:,1) = -chordArr/4; % Wing c/4 aligned along wing.
wingDescription(:,4) = chordArr;
wingDescription(:,5) = wingDescription(:,5) + alphai';