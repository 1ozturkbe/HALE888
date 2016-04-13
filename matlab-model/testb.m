x1 = [0.8 1 .5 2 2 2 2 2 2];
x2 = [1.5 0.5 .5 0 0 0 0 0 0];
[L1, LoD1, W_wing1, fuelVolume1, delta_tip1, extrainfo1] = evalWing(x1, 1);
[L2, LoD2, W_wing2, fuelVolume2, delta_tip2, extrainfo2] = evalWing(x2, 2);