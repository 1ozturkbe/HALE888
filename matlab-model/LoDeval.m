function LoD = LoDeval(newInd, total_weight, Sref, rho, V, a)
CL_required = total_weight/(0.5*rho*V^2*Sref);
suf = num2str(newInd);
runname = ['haleMod', suf];
[CL, CD, ~] = avlRun(runname, V/a);
CD_required = interp1(CL, CD, CL_required);
LoD = CL_required/CD_required;
end