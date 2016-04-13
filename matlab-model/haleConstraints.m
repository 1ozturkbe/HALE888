function [c,ceq] = haleConstraints(~)
    global Lift W_tot delta0b_max delta_tip bi fuelVolume fuelVolReq
    ceq = Lift-W_tot;
    c = [delta0b_max - delta_tip /(2*bi);
         fuelVolume - fuelVolReq];