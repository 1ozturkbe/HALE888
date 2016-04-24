b = [];
c = [];
l = [];
LoD = [];
W_tot = [];
delta_tip = [];
delta0b = [];
fuelVolume = [];
costs = [];

wings = loadedWings;
for i = 1:length(wings)
    wingRes = wings(i);
    b = [b wingRes.arr(1)];
    c = [c wingRes.arr(2)];
    l = [l wingRes.arr(3)];
    LoD = [LoD wingRes.LoD];
    delta_tip = [delta_tip wingRes.delta_tip];
    delta0b = [delta0b wingRes.delta0b];
    fuelVolume = [fuelVolume wingRes.fuelVolume];
    W_tot = [W_tot wingRes.W_tot];
    costs = [costs wingRes.cost];
end