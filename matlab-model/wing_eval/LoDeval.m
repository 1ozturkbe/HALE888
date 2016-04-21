function [Lift, LoD, extrainfo] = LoDeval(newInd, Sref, rho, V, a)
    suf = num2str(newInd);
    runname = ['haleMod', suf];
    disp(runname)
    [CL, CD, ~, extrainfo] = avlRun(runname, V/a);
    Lift = CL*0.5*rho*V^2*Sref*.3048^2;
    LoD = CL/CD;
end