init
initMod = [1 1 .5 -1 -1 -1 -1 -1 -1];
chords = linspace(0.1,1,30);
bs = linspace(0.5,1.5,30);
v_of_c = arrayfun(@(x) fuelVol(geoDescription(...
    [initMod(1) x initMod(3:end)])), chords);
d_of_c = arrayfun(@(x) structRunTest(...
    [initMod(1) x initMod(3:end)]), chords);
d_of_b = arrayfun(@(x) structRunTest(...
    [x initMod(2:end)]), bs);
