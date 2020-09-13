function dR = RayleighPlessetEq( t,R )
% Rayleigh-Plesset Equation
global rho Pinf Pv Pg01 Pg02 R0 St Dv

Kpg1=Pg01*R0^3;
Kpg2=Pg02*R0^6;
Kpg3=Pg02*R0^9;
deltaP = Pv-Pinf;
dR = zeros(2,1);
dR(1) = R(2);
dR(2) = -1.5*(R(2)^2)/R(1)+ (deltaP)/(rho*R(1))-(2*St+4*Dv*R(2))/(rho*R(1)^2)...
    + Kpg1/(rho*R(1)^4)+ Kpg2/(rho*R(1)^7)+ Kpg3/(rho*R(1)^10);
end
