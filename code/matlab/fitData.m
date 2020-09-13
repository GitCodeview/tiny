clc
clear all

d=18;c=4.16;alpha=0.101;
A=-20;B=25;rd=0.75;
kBT=(0.9911+0.9935+0.9960)/3;
rho=4.5:0.1:7.5;
pmdpd=@(rho)2*alpha*B*(rd^4)*(rho.^3)+...
            (alpha*A-2*alpha*B*(rd^4)*c)*(rho.^2)...
            +kBT*rho;%+2*alpha*B*(rd^4)*d;
MdpdP=pmdpd(rho);
figure
plot(rho,MdpdP,'g.')
hold on
% % fitP= 0.9991*(rho.^3.085)-2145;
% fitP= 0.00153*(rho.^5.748)-50.06;
% plot(rho,fitP,'r-.')

% %%
% r=3.53
% NP=848;
% rho=3*NP/(4*pi*r^3)

