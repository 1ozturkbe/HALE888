syms c1 c2 y1 y2 y
syms A1 A2 y1 y2 y
c = c1+(c2-c2)/(y2-y1)*(y-y1);
A = A1+(A2-A1)/(y2-y1)*(y-y1);
int(A*c^2,y,y1,y2);