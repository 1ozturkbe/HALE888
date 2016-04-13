[cost, extrainfo] = SAWingEval(bestDesign);
copyfile(['avl_geometries/' extrainfo.runname '.avl'], ...
    'airfoils_and_executables')
disp(extrainfo)