function [c,ceq] = myTCon(x_t)

global g_Normal g_StartF

t = x_t(size(x_t,1));
x = x_t(1:(size(x_t,1)-1));

fe  = myFM(x) - g_StartF - t * g_Normal;

[c,ceq1] = myCon(x);
ceq = [ceq1;fe];

