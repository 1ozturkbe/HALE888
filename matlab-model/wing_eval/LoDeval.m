function [Lift, LoD, extrainfo] = LoDeval(newInd, Sref, rho, V, a)
    suf = num2str(newInd);
    runname = ['haleMod', suf];
    % allow for the option to not store every single plane evaluation
    global not_save_geometry_file
    if not_save_geometry_file
        runname = 'haleMod';
    end
    disp(runname)
    [CL, CD, ~, extrainfo] = avlRun(runname, V/a);
    Lift = CL*0.5*rho*V^2*Sref*.3048^2;
    LoD = CL/CD;
end