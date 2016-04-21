savedfilename = 'storedWingEvaluations.mat';
savedfolderpath = [pwd '\savedruns'];
addpath(savedfolderpath);
savedfilepath = [savedfolderpath '\' savedfilename];
savedVariableName = 'savedEvaluations';
    
if exist(savedfilepath, 'file')
    load(savedfilepath)
else 
    savedEvaluations = containers.Map();
end