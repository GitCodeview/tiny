% clc
% clear all
% bubble clipse
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
St = 3.104028;%0.0720;   %0.0003;   %3.104028*CGst%0.0743;%0.0720;   % surface tension 
Dv =  0.278641959;%0;%8.9000e-04;   %0.600e-04;   %0.278641959*CGdv%0.0069;%8.9000e-04;   % dynamics viscosity 
%----fluid input parameter--------------------------------------  
global rho Pinf Pv Pg01 Pg02 Pg03 Pb R0                         
rho =6;%1.0235e+03;
Pinf = 50;%1.01e5;%30*1.01e5;%9.675*CGpress;%1.01e5;
Pv = 23.0090625;%3169;%0;      % water saturated vapor pressure
%----------bubble input parameter---------------------------------
Pgatm1=0.05;%0;%0.1;%0.05;
Pgatm2=-0.02;%0;%0.05;
Pgatm3=0.05;%0;%0.05;
Pg01 = 6;%Pgatm1*1.01e5;%0.06e5;%(5.414-0.896)*CGpress%0.66e5;
Pg02 =-336.8754;%Pgatm2*1.01e5;% 0.896*CGpress%3*0.896*Rgc*298.15
Pg03 =276.10875;%Pgatm2*1.01e5;% 0.896*CGpress%3*0.896*Rgc*298.15
Pb =Pv+Pg01+Pg02+Pg03; 
R0 = 4.0193;%4e-7;%5.1850*CGlength%4e-7;

%% Create axes
figure
axes1 = axes('FontSize',14);
box(axes1,'on');
hold(axes1,'all');

%% sets
if (Pg02 == 0 && Pg01 == 0)
    EOS='_Vacuum';
elseif (Pg02 == 0)
    EOS='_idealGas';
elseif (Pg03 == 0)
    EOS='_DPDGas';
else
    EOS='_MDPDGas';
end

%% Rayleigh-Plesset Equation
tc = 0.91468*R0*sqrt(rho/(Pinf-Pb))
rptc=2*tc;
[T,R] = ode45('RayleighPlessetEq',[0 rptc], [R0 0]);
[m,n] =  size(R);
i =1;
ntm=0;
while i <= m
    if (i>6) 
        if (abs(R(i,1)-R(i-1,1)) < 10e-10)
            rptc=rptc+10*tc;
            i=m-1;
            ntm = i;
        end
    end
    if (i == m-1) 
        rptc=rptc+tc;
        [T,R] = ode45('RayleighPlessetEq',[0 rptc], [R0 0]);
        [m,n] =  size(R);
        i = 0;
    end 
    i=i+1;
    if (ntm > 0) break;end
end
i=m+1;
rptc = T(i-1,1)
% R=R./R0;
% T=T./tc;
plot(T(1:(i-1),1),R(1:(i-1),1),'b')
hold on
% plot(T(i-1,1),R(i-1,1),'g.','markersize',10)
% hold on

% ouput the results and prepare for Plot
results = sprintf('%s%s','RayleighP.mat');
rpT=T;
rpR=R;
save(results,'tc','rpT','rpR');
fileName = sprintf('%s%s%s%0.3g%s%0.2f%s%0.2f','RP',EOS,'_R',R0,'_1P',Pgatm1,'_2P',Pgatm2);
outputPLT( fileName,rpT,rpR )

% figure;
% plot(T(1:(i-1),1),R(1:(i-1),2),'-.')

%% Rayleigh Equation
[T,R] = ode45('RayleighEq',[0 rptc], [R0 0]);
% R=R./R0;
% T=T./tc;
plot(T,R(:,1),'r')
hold on
% plot(1,0,'r.','markersize',10)
% hold on
% plot(T(end,1),R(end,1),'g.','markersize',10)
% hold on

xlabel('t','FontSize',14);
ylabel('R','FontSize',14);

% ouput the results and prepare for Plot
results = sprintf('%s%s','Rayleigh.mat');
rT=T;
rR=R;
save(results,'tc','rT','rR');

fileName = sprintf('%s%s%s%0.3g%s%0.2f%s%0.2f','R',EOS,'_R',R0,'_1P',Pgatm1,'_2P',Pgatm2);
outputPLT( fileName,rT,rR )

% tc-T(end,1)

%% Rayleigh-Plesset Equation the viscosity influence
% figure
% % Create axes
% axes1 = axes('FontSize',14);
% box(axes1,'on');
% hold(axes1,'all');
% 
% Dv =  0.9000e-04   % dynamics viscosity 
% while ( Dv < 0.04)
%     [T,R] = ode45('RayleighPlessetEq',[0 rptc], [R0 0]);
%     [m,n] =  size(R);
%     i =1;
%     ntm=0;
%     i=m+1;
%     plot(T(1:(i-1),1),R(1:(i-1),1),'b')
%     hold on
%     Dv =  Dv*2
% end
% xlabel('t','FontSize',14);
% ylabel('R','FontSize',14);
% 
%% Rayleigh-Plesset Equation the surface tension influence
% figure
% % Create axes
% axes1 = axes('FontSize',14);
% box(axes1,'on');
% hold(axes1,'all');
% Dv =  1.1000e-03   % dynamics viscosity 
% St =  0   % dynamics viscosity 
% while ( St < 0.1)
%     [T,R] = ode45('RayleighPlessetEq',[0 rptc], [R0 0]);
%     [m,n] =  size(R);
%     i =1;
%     ntm=0;
%     i=m+1;
%     plot(T(1:(i-1),1),R(1:(i-1),1),'b')
%     hold on
%     if(St>0.01) 
%         St =  St*2
%     else
%         St=St*5
%     end
%     if(St==0) St =  0.9000e-05;end  % dynamics viscosity 
% end
% xlabel('t','FontSize',14);
% ylabel('R','FontSize',14);

