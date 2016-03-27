function area = volumeCalc(airfoilpath, tolerablethickness)
    % tolerablethickness is in fractional percentage (0.05)
    fid = fopen(airfoilpath);
    xycell = textscan(fid, '%f%f', 'CollectOutput', 1);
    fclose(fid);
    xyarray = xycell{1};
    len = length(xyarray);
    [~, ~, idx2] = unique(xyarray(:,1));
    top = xyarray(1:len/2, 2);
    bottom = xyarray(len/2:end, 2);
    
    idx = find(xyarray == xyarray(1:len/2,1));
    plot(xyarray(:,1),xyarray(:,2))
    area = polyarea(xyarray(:,1),xyarray(:,2));
end