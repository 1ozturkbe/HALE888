function LoD = LoDeval(newInd)
suf = num2str(newInd);
runname = ['haleMod', suf, '.avl'];
LoD = avlRun(runname);
end