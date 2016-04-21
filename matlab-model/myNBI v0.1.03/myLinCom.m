function f = myLinCom(x)
   
global g_Weight

F   = myFM(x);

f = g_Weight' * F;
