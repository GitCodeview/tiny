function dR = RayleighPlessetSpEq( t,R )
% Rayleigh-Plesset Equation

Pinf = 1.01e5;  % surrouding liquid pressure
Pb = 3026;      % bubbble pressure
rho =1e3;       % surrouding liquid density
Sp = 0.89e-3;   % surface tension
Dv = 0.799e-6;   % dynamics viscosity 0.0; %  +4*Dv*R(2)
dR = zeros(2,1);
dR(1) = R(2);
dR(2) = -1.5*(R(2)^2)/R(1)+(Pb-Pinf)/(rho*R(1))-(2*Sp)/(rho*R(1)^2);
end

