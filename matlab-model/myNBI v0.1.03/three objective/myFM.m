function [f] = myFM(x)

f   = ones(3,1);
f(1)= norm(x)^2 ;
f(2)= 3*x(1)+2*x(2) - x(3)/3 + 0.01*(x(4) - x(5))^3 ; 
f(3)= x(1)^2 + 3*(x(2)^2) + 0.2*(x(3) - x(5))^3 + log(x(4)^2 + x(1)^2 + x(2)^2 + 1);
