function cost = SAWingEval(modArray)
global rho V a
global bInd crInd lamInd 
global bi cri
global bInit crInit bCent
global initWing initRef
nFactors = 9;
global delta0b_max fuelVolReq
newWing = initWing;
newRef = initRef;

alphaij = [];
cri = 0; bi = 0; lami = 0;
%Deciphering wing modifications from the factor levels
for j = 1:nFactors
    if j == bInd
        bi = bInit*modArray(bInd); %Note that bi is the half-span
    elseif j == crInd
        cri = crInit*modArray(crInd); %root chord
    elseif j == lamInd
        lami = modArray(lamInd); %taper ratio
    else
        alphaij = [alphaij modArray(j)]; %angle mod for each section
    end
end

%Rewriting wing reference array
newRef(3) = 2*bi; %reference span
newRef(1) = 2*(bCent*cri + (1+lami)/2*cri*(bi-bCent)); %reference area
newRef(2) = newRef(1)/newRef(3); %reference chord
%Rewriting wing geometry array
newWing(3:6,2) = newWing(3:6,2)*modArray(1); % scaling y position of le
chordArr = [cri]; % changing all of the wing chords and xles
ctip = cri*lami;
chordArr = [chordArr; linspace(cri,cri*lami,5)'];
newWing(:,1) = chordArr/4; % Wing c/4 aligned along wing.
newWing(:,4) = chordArr;
newWing(:,5) = newWing(:,5) + alphaij';

[W_wing, delta_tip] = structRun();
fuelVolume = fuelVol(newWing);
%Putting the newWing into AVL format using geoMod
geoMod;
W_tot = 71.41*.454*9.81+W_wing; %N

[Lift,LoD] = LoDeval(newInd, newRef(1), rho, V, a);

% Evaluating costs (constraints)
liftCost = 0; deltaCost = 0; fuelCost = 0;
if Lift < W_tot
    liftCost = W_tot-Lift; 
end
if delta_tip /(2*bi) > delta0b_max
    deltaCost = (delta_tip/2*bi - delta0b_max)*6;
end
if fuelVolume < fuelVolReq
    fuelCost = -(fuelVolume-fuelVolReq)*1000;
end

cost = -LoD + deltaCost + fuelCost + liftCost