clc
clear all
%% read the data from RT.plt
[RT,fpath]= readRT();
%% plot the RT
plot(RT(:,1),RT(:,2),'.')
%%
[EV]=extremum( RT(:,1),RT(:,2),200 );
%%
[rEV]=extremum( RT(:,1),EV(:,3),5);

%% plot extermum value results
% plot(RT(:,1),EV(:,1),'.',RT(:,1),EV(:,2),'*',RT(:,1),EV(:,3),'^')
% hold on
plot(RT(:,1),rEV(:,2),'.r')%,RT(:,1),rEV(:,2),'*')%,RT(:,1),rEV(:,3),'^')
axis([0 inf 3 6]);
%%
tc=4.6;
CRT(:,1)=RT(:,1)./tc;
CRT(:,2)=RT(:,2)./RT(1,2);
plot(CRT(:,1),CRT(:,2),'.')
%% numerical solving for Rayleigh-Plesset Equation
%---------------constant----------------------------------------
global NA KB Rgc
NA=6.022140857E23;       %Avogadros constant
KB=1.38064852E-23;       %Boltzmanns constant
Rgc= NA*KB;              %Gas constant (ideal gas EOS:PV=nRT=NKBT,N=NA*n
                         %(n is the amount of substance of the gas in moles))
%---------CGresults--------------------------------------
global CGlength CGtime
CGrho = 144.8423;        % the real densiR0ty(kg/m3) per length in DPD units.
CGpress = 8.3602e+04;    % the real pressure(pa) per pressure in DPD units.
CGlength = 3.6734e-09;    % the real length(m) per length in DPD units.
CGtime = 4.4886e-09;     % the real time(s) per time in DPD units.
CGst = 0.0026;           % the real surface tension() per in DPD units
CGdv = 0.0045;           % the real viscocity per in DPD units.
%--------fluid character parameter-----------------------
global St Dv
St = 0.0720;   %0.0003;   %3.104028*CGst%0.0743;%0.0720;   % surface tension 
Dv =  9.000e-03;   %0;%0.600e-04;   %0.278641959*CGdv%0.0069;%8.9000e-04;   % dynamics viscosity 
%----fluid input parameter--------------------------------------  
global rho Pinf Pv Pg01 Pg02 Pb R0                         
rho =1.0235e+03;
Pinf = 1.01e5;%30*1.01e5;%9.675*CGpress;%1.01e5;
Pv = 3169;%0;      % water saturated vapor pressure
%----------bubble input parameter---------------------------------
Pgatm1=0.05;%0;%0.1;%0.05;
Pgatm2=0.05;%0;%0.05;
Pg01 = Pgatm1*1.01e5;%0.06e5;%(5.414-0.896)*CGpress%0.66e5;
Pg02 =Pgatm2*1.01e5;% 0.896*CGpress%3*0.896*Rgc*298.15
Pb =Pv+Pg01+Pg02; 
R0 = 4e-7;%5.1850*CGlength%4e-7;
%---------- numerical solving --------------------------------------
% Rayleigh-Plesset Equation
Rtc = 0.91468*R0*sqrt(rho/(Pinf-Pb))
rptc=2*Rtc;
[rpT,rpR] = ode45('RayleighPlessetEq',[0 rptc], [R0 0]);
[m,n] =  size(rpR);
i =1;
ntm=0;
while i <= m
    if (i>6) 
        if (abs(rpR(i,1)-rpR(i-1,1)) < 10e-10)
            rptc=rptc+10*Rtc;
            i=m-1;
            ntm = i;
        end
    end
    if (i == m-1) 
        rptc=rptc+Rtc;
        [rpT,rpR] = ode45('RayleighPlessetEq',[0 rptc], [R0 0]);
        [m,n] =  size(rpR);
        i = 0;
    end 
    i=i+1;
    if (ntm > 0) break;end
end
i=m+1;
figure
plot(rpT(1:(i-1),1),rpR(1:(i-1),1),'r')
%% obtain rptc
[rpEV]=extremum( rpT(1:(i-1),1),rpR(1:(i-1),1),1 );
% plot extermum value results
%plot(rpT(1:(i-1),1),rpEV(:,1),'.',rpT(1:(i-1),1),rpEV(:,2),'*')%,rpT(1:(i-1),1),rpEV(:,3),'^')
%
for j=1:m
if rpEV(j,2)~=0 rptc=rpT(j,1); break;end
end
% ---------- comparigng --------------------------------------
% plot
figure
plot(CRT(:,1),CRT(:,2),'.')
hold on
[m,n]=size(rpT);
TrpRT=zeros(m,2);
TrpRT(:,1)=rpT(:,1)./rptc;
TrpRT(:,2)=rpR(:,1)./rpR(1,1);
plot(TrpRT(:,1),TrpRT(:,2),'r');
axis([0 4.5 0 1.2]);