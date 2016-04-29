b = [];
c = [];
l = [];
LoD = [];
W_tot = [];
W_wing = [];
delta_tip = [];
delta0b = [];
fuelVolume = [];
costs = [];
Lift = [];

wings = validWings;
for i = 1:length(wings)
    wingRes = wings(i);
    b = [b wingRes.arr(1)];
    c = [c wingRes.arr(2)];
    l = [l wingRes.arr(3)];
    Lift = [Lift wingRes.L];
    LoD = [LoD wingRes.LoD];
    delta_tip = [delta_tip wingRes.delta_tip];
    delta0b = [delta0b wingRes.delta0b];
    fuelVolume = [fuelVolume wingRes.fuelVolume];
    W_tot = [W_tot wingRes.W_tot];
    W_wing = [W_wing wingRes.W_wing];
    costs = [costs wingRes.cost];
end