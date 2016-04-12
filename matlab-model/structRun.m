function [W_wing, delta_tip] = structRun(newRef)
%% Evaluates the structural performance of a given wing design
global cri
g = 9.81; %m/s^2
rho_skin = 0.1*10^-3*10^4; %kg/cm^2
rho_cap = 1760; %kg/m^3
E_cap = 6894.76*2e7; %Pa 'Youngs modulus of CF cap'
sigma_cap = 475e6; %Pa, 'Cap stress'
t_cap = .028*0.0254; %m  'Spar cap thickness'

F = 1633; %N of max force on wing
tau = 0.1; %airfoil thickness ratio

S = newRef(1)*.3048^2; %m^2
b = newRef(3)*.3048; %m
cri = cri*.3048; %m

m_skin = rho_skin*S*2;
M_cent = b*F/8;
h_spar = tau*cri;
P_cap = M_cent/h_spar;
A_capcent = P_cap/sigma_cap;
Vol_cap = A_capcent*b/3;
m_cap = rho_cap*Vol_cap;
delta_tip = b^2*sigma_cap/(4*E_cap*h_spar)/0.3048; %ft

W_wing = m_skin*g + 1.2*m_cap*g; %N



