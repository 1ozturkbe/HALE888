function [f] = myFM(x)

f   = ones(2,1);
f(1)= norm(x)^2;
f(2)= 3*x(1)+2*x(2) - x(3)/3 + 0.01*(x(4) - x(5))^3 ;
