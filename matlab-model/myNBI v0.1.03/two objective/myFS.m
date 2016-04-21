function f = myFS(x)
global g_Index

if g_Index == 1,
    f = norm(x)^2;
elseif g_Index == 2,
    f = 3*x(1)+2*x(2) - x(3)/3 + 0.01*(x(4) - x(5))^3;
end