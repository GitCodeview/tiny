%% =========================================================================
clc
clear all
%vapour bubble situation
Pinf = 1.01e5;
Pv = 3169; 
rho =1e3;
R0 = 5e-7;
%% Rayleigh Equation
tc = 0.91468*R0*sqrt(rho/(Pinf-Pv))
[T,R] = ode45('REqv',[0 tc], [R0 0]);
% R=R./R0;
% T=T./tc;
plot(T,R(:,1),'r','LineWidth',2)
% hold on
% plot(1,0,'r.','markersize',10)
% hold on
% plot(T(end,1),R(end,1),'g.','markersize',10)
hold on

xlabel('t','FontSize',16,'FontWeight','bold')
ylabel('R','FontSize',16,'FontWeight','bold')

% ouput the results and prepare for Plot
results = sprintf('%s%s','REqv.mat');
rT=T;
rR=R;
save(results,'tc','rT','rR');

% tc-T(end,1)

%% Rayleigh-Plesset Equation
rptc=5*tc;
[T,R] = ode23s('RPEqv',[0 rptc], [R0 0]);
[m,n] =  size(R);
i =1;
while i <= m
    if (R(i,1) < 0) break;end
    if (i == m-1) 
        rptc=rptc+tc;
        [T,R] = ode23s('RPEqv',[0 rptc], [R0 0]);
        [m,n] =  size(R);
        i = 0;
    end 
    i=i+1;
end
rptc = T(i-1,1)
% R=R./R0;
% T=T./tc;
plot(T(1:(i-1),1),R(1:(i-1),1),'-.','LineWidth',2)
% hold on
% plot(T(i-1,1),R(i-1,1),'g.','markersize',10)
hold on

% ouput the results and prepare for Plot
results = sprintf('%s%s','RPEqv.mat');
rpT=T;
rpR=R;
save(results,'tc','rpT','rpR')

%% Rayleigh-Plesset Equation only consider the dynamic viscosity
% rptc=10*tc;
% [T,R] = ode23tb('RPDvEqv',[0 rptc], [R0 0]);
% [m,n] =  size(R);
% i =1
% while i <= m
%     if (R(i,1) <= 0) break;end
%     if (i == m-1) 
%         rptc=rptc+tc;
%         [T,R] = ode23tb('RPDvEqv',[0 rptc], [R0 0]);
%         [m,n] =  size(R);
%         i = 0;
%     end
%     i=i+1;
% end
% % i=m+1
% rptc = T(i-1,1)
% % R=R./R0;
% % T=T./tc;
% plot(T(1:(i-1),1),R(1:(i-1),1),'g-.','LineWidth',2)
% % hold on
% % plot(T(i-1,1),R(i-1,1),'g.','markersize',10)



%% Rayleigh-Plesset Equation only consider the surface tension
% rptc=tc;
% [T,R] = ode23tb('RPSpEqv',[0 rptc], [R0 0]);
% [m,n] =  size(R);
% i =1;
% while i <= m
%     if (R(i,1) < 0) break;end
%     if (i == m-1) 
%         rptc=rptc+tc;
%         [T,R] = ode23tb('RPSpEqv',[0 rptc], [R0 0]);
%         [m,n] =  size(R);
%         i = 0;
%     end
%     i=i+1;
% end
% rptc = T(i-1,1)
% plot(T(1:(i-1),1),R(1:(i-1),1),'r-.')
% hold on
% plot(tc,0,'r.','markersize',10)
% hold on
% plot(T(i-1,1),R(i-1,1),'g.','markersize',10)
% hold on
