Fnum 	= 2;
Spac 	= 10;
TolCon 	= 1.0000e-007;
TolF 	= 1.0000e-004;
TolX 	= 1.0000e-004;
VLB     = [];
VUB     = [];
X0      = [0.1000 0.1000  0.1000 0.1000 0.1000]';

[Pareto_Fmat, Pareto_Xmat] = NBI(X0,Spac,Fnum,VLB,VUB,TolX,TolF,TolCon)