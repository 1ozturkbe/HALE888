function [L, LoD, W_wing, fuelVolume, delta_tip, extrainfo] = ...
    evalWingStoreResults(arr, newInd)
% vect = [1 1 0.5 0 0 0 0 0 0]
global savedfilename
if ~exist('savedfilename')
    savedfilename = 'storedWingEvaluations.mat';
end
[pathtothisfile,~,~] = fileparts(mfilename('fullpath'));
savedfilepath = [pathtothisfile '\savedruns\' savedfilename];
savedVariableName = 'savedEvaluations';

if exist(savedfilepath, 'file')
    load(savedfilepath)
else 
    savedEvaluations = containers.Map();
end

% implementing a hash map for quick lookup
hashedarr = DataHash(arr);
if isKey(savedEvaluations,hashedarr)
    results = savedEvaluations(hashedarr);
    L = results.L;
    LoD = results.LoD;
    W_wing = results.W_wing; 
    fuelVolume = results.fuelVolume;
    delta_tip = results.fuelVolume;
    extrainfo = results.extrainfo;
else
    tic
    [L, LoD, W_wing, fuelVolume, delta_tip, extrainfo] = ...
        evalWingLongRun(arr, newInd);
    elapsed_time = toc;
    results = struct('arr', arr, ...
        'L',L,'LoD',LoD,'W_wing',W_wing,...
        'fuelVolume', fuelVolume, 'delta_tip', delta_tip,...
        'extrainfo', extrainfo, ...
        'count', newInd, 'elapsedtime', elapsed_time);
    savedEvaluations(hashedarr) = results;
end

save(savedfilepath, savedVariableName)

end