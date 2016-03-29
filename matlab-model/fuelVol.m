function fuelVol(wingparam)
%n=6    n x [Xle    Yle     Zle Chord   Ainc    Nspanwise Sspace]
%wingparam = [0      0       0   1       0       0       0;
%             0      3       0   1       0       0       0;
%             0.0655 6       0   0.7378  0.25    0       0;
%             0.1202 8.5     0   0.5194  0.5     0       0;
%             0.142  9.5     0   0.432   0       0.75    0;
%             0.1645 10.53   0   0.342   1       0       0];
n = size(wingparam,1);
n = n; % if we don't want to count all the sections do n-2 or n-3
yle_idx = 2;
chord_idx = 4;
airfoilpath = 'sd7032.dat';
panel1 = wingparam(1,:);
fuelVolume = 0;
for i = 2:n
    panel2 = wingparam(i,:);
    y1 = panel1(yle_idx);
    c1 = panel1(chord_idx);
    y2 = panel2(yle_idx);
    c2 = panel2(chord_idx);
    sectionVolume = volumeCalc(airfoilpath, airfoilpath, c1, c2, y1, y2);
    fuelVolume = fuelVolume + sectionVolume;
    panel1 = panel2;
end
        
end