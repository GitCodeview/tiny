
rho=0:0.1:1000;

%zero
zerop=@(rho)rho*0.0 ;

% %Murnaghan-Tait equation of state
% P0= 101325; %Pa
% rho0= 1000; %kg/cu.m
% K0 = 2.15e9; %Pa
% un = 7.15;
% 
% ptait=@(rho)K0*(((rho/rho0).^un)-1)./un +P0;

%van der Waals equation of state
a=1;
b=1;
R=2000;
T=300;

pvdw=@(rho)R*T*rho/(1-b*rho) - a*(rho.^2);

plot(rho,zerop(rho),'k-.',rho,pvdw(rho),'g')