function V = volumeCalc(airfoilpath1, airfoilpath2, c1, c2, y1, y2)
tolerablethickness = 0.05;
A1 = areaCalc(airfoilpath1, tolerablethickness);
A2 = areaCalc(airfoilpath2, tolerablethickness);
V = (y2 - y1)*(A1*c2^2 + A2*c1^2 + 2*c1*c2*(A1 + A2) +...
    3*(A1*c1^2 + A2*c2^2))/12;
end