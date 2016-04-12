global count
[cost, deltaCost, fuelCost, liftCost, weightCost] = SAWingEval(bestDesign);
[Lift, LoD, W_wing, fuelVolume, delta_tip] = evalWing(bestDesign, count);
