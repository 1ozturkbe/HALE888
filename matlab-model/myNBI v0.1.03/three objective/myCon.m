function [c,ceq] = myCon(x)
%Nonlinear equalities at x
ceq     = ones(2,1); 
ceq(1)  = x(1) + 2*x(2) - x(3) - 0.5*x(4) + x(5) - 2; 
ceq(2)  = 4*x(1) - 2*x(2) + 0.8*x(3) + 0.6*x(4) + 0.5*x(5)^2; 
%Nonlinear inequalities at x
c   = ones(1,1); 
c(1)= norm(x)^2 - 10; 