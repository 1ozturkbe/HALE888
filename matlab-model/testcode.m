init
initMod = [1 1 .5 0 0 0 0 0 0];
bs = linspace(0.8,1.2,20);
chords = linspace(0.8,1.2,20);
ls = linspace(0.1,1,20);
a1 = linspace(-2,2,20);
a2 = linspace(-2,2,20);
a3 = linspace(-2,2,20);
a4 = linspace(-2,2,20);
a5 = linspace(-2,2,20);
a6 = linspace(-2,2,20);

[bLoD, bineq1, bineq2, beq] = arrayfun(@(x) ...
    wingEvalGrad([x initMod(2:end)],1), bs);

[cLoD, cineq1, cineq2, ceq] = arrayfun(@(x) ...
    wingEvalGrad([initMod(1) x initMod(3:end)],1), chords);

[lLoD, lineq1, lineq2, leq] = arrayfun(@(x) ...
    wingEvalGrad([initMod(1:2) x initMod(4:end)],1), ls);

[a1LoD, a1ineq1, a1ineq2, a1eq] = arrayfun(@(x) ...
    wingEvalGrad([initMod(1:3) x initMod(5:end)],1), a1);

[a2LoD, a2ineq1, a2ineq2, a2eq] = arrayfun(@(x) ...
    wingEvalGrad([initMod(1:4) x initMod(6:end)],1), a2);

[a3LoD, a3ineq1, a3ineq2, a3eq] = arrayfun(@(x) ...
    wingEvalGrad([initMod(1:5) x initMod(7:end)],1), a3);

[a4LoD, a4ineq1, a4ineq2, a4eq] = arrayfun(@(x) ...
    wingEvalGrad([initMod(1:6) x initMod(8:end)],1), a4);

[a5LoD, a5ineq1, a5ineq2, a5eq] = arrayfun(@(x) ...
    wingEvalGrad([initMod(1:7) x initMod(9)],1), a5);

[a6LoD, a6ineq1, a6ineq2, a6eq] = arrayfun(@(x) ...
    wingEvalGrad([initMod(1:8) x],1), a6);