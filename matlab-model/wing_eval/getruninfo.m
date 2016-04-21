function runinfo = getruninfo(filename)
    file = fopen(filename,'r');
    line = fgets(file);
    
    digitpattern =  '\-*\d+.\d*';
    patterns =  {'Neutral point  Xnp','CLtot','CDtot','Cmtot'};
    properties = {'xnp','CLtot','CDtot','CMtot'};

    while ischar(line)
        for i=1:length(patterns)
            linepattern = [patterns{i}, '\s+=\s+' digitpattern];
            temp = regexp(line,linepattern,'match');
            if ~isempty(temp)
                strnumber = regexp(temp{1},digitpattern,'match');
                runinfo.(properties{i}) = str2double(strnumber);
            end
        end
        line = fgets(file);
    end
    fclose(file);
end