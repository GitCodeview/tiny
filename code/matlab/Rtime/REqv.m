function dR = REqv( t,R )
% Rayleigh Equation

Pinf = 1.01e5;  % surrouding liquid pressure
Pv = 3169;      % water saturated vapor pressure
deltaP = Pv-Pinf;
rho =1e3;       % surrouding liquid density
dR = zeros(2,1);
dR(1) = R(2);
dR(2) = -1.5*(R(2)^2)/R(1)+(deltaP)/(rho*R(1));
end
