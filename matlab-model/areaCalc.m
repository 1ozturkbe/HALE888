function [area, xyarray] = areaCalc(airfoilpath, tolerablethickness)
% tolerablethickness is in fractional percentage (0.05)
% airfoilpath = 'fuse_sd7032.dat';
% tolerablethickness = 0.05;

%% Parse "all" airfoil files, and get the x.xxxx y.yyyy geometry
fid = fopen(['airfoils_and_executables/' airfoilpath]);
tline = fgetl(fid);
matchinglines = '';
regex = '([-+]?([0-9]*\.[0-9]{3,})[^\S\n]+[-+]?([0-9]*\.[0-9]{3,}))';
while ischar(tline)
    if regexp(tline, regex)
        matchline = regexp(tline, regex, 'match');
        matchinglines = [matchinglines matchline{1} '\n'];
    end
    tline = fgetl(fid);
end
fclose(fid);
s = sprintf(matchinglines);
xycell = textscan(s, '%f %f \n', 'CollectOutput', 1);
xyarray = xycell{1};

%% Only include points that are within the tolerable clearance
len = length(xyarray);
halflen = ceil(len/2);
top = xyarray(1:halflen, :);
bottom = xyarray(halflen+1:end, :);
botyinterp = interp1(bottom(:,1), bottom(:,2), top(:,1));
height = top(:,2)-botyinterp;
idx = find(height>=tolerablethickness);
filteredtop = top(idx,:);
filteredbottom = [top(idx,1) botyinterp(idx)];

%% Order the points in counterclockwise order
[~, order] = sort(filteredtop(:,1), 'ascend');
filteredtop = filteredtop(order,:);
[~, order] = sort(filteredbottom(:,1), 'descend');
filteredbottom = filteredbottom(order,:);
xyfiltered = [filteredtop;filteredbottom];
x = xyfiltered(:,1); 
y = xyfiltered(:,2); 
%plot(x,y); axis equal;
area = polyarea(x,y);
end