init
levels = 9;
ff = fullfact(levels * ones(1,3));
bs = linspace(0.85,1.15,levels);
cs = linspace(0.8,1.2,levels);
ls = linspace(0.1,1,levels);

for i = 1:length(ff)
    x = [bs(ff(i,1)) cs(ff(i,2)) ls(ff(i,3)) ...
        -1.5521 -2.1994   -3.3736   -2.6008   -1.1641   -0.8915];
    evalWing(x,i)
end

