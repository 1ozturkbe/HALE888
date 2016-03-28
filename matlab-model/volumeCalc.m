%function area = volumeCalc(airfoilpath, tolerablethickness)
    % tolerablethickness is in fractional percentage (0.05)
    airfoilpath = 'orig0foilmod.dat';
    tolerablethickness = 0.05;
    regex = '([-+]?([0-9]*\.[0-9]+|[0-9]+)\s[-+]?([0-9]*\.[0-9]+|[0-9]+))';
    fid = fopen(airfoilpath);
    tline = fgetl(fid);
    matchinglines = '';
    while ischar(tline)
        if regexp(tline, regex)
            matchinglines = [matchinglines tline '\n'];
        end
        tline = fgetl(fid);
    end
    fclose(fid);
    s = sprintf(matchinglines);
    xycell = textscan(s, '%f %f \n', 'CollectOutput', 1);
    xyarray = xycell{1};
    len = length(xyarray);
    top = xyarray(1:len/2, :);
    bottom = xyarray(len/2+1:end, :);
    [~, order] = sort(top(:,1), 'ascend');
    sortedtop = top(order,:);
    [~, order] = sort(bottom(:,1), 'ascend');
    sortedbottom = bottom(order,:);
    botyinterp = interp1(bottom(:,1), bottom(:,2), top(:,1));
    height = top(:,2)-botyinterp;
    idx = find(height>=tolerablethickness);
    filteredtop = sortedtop(idx,:);
    filteredbottom = sortedbottom(idx,:);
    [~, order] = sort(filteredbottom(:,1), 'descend');
    filteredbottom = filteredbottom(order,:);
    xyfiltered = [filteredtop;filteredbottom];
    x = xyfiltered(:,1);
    y = xyfiltered(:,2);
    plot(x,y)
    axis equal
    area = polyarea(x,y)
%end