function dR = RPEqv( t,R )
% Rayleigh-Plesset Equation

Pinf = 1.01e5;  % surrouding liquid pressure
Pv = 3169;      % water saturated vapor pressure
deltaP = Pv-Pinf;
rho =1e3;       % surrouding liquid density
Sp = 0.89e-3;   % surface tension
Dv =0.799e-3;   % dynamics viscosity
dR = zeros(2,1);
dR(1) = R(2);
dR(2) = -1.5*(R(2)^2)/R(1)+ (deltaP)/(rho*R(1))-(2*Sp+4*Dv*R(2))/(rho*R(1)^2);
end

