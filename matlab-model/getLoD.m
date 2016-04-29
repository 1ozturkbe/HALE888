function [LoD,W_wing] = getLoD(arr,ind)
[L, LoD, W_wing, fuelVolume, delta_tip, extrainfo] = evalWing(arr, ind)