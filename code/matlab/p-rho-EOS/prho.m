
% This function uses to compute the MDPD equAtion of stAte(EOS) to get the
% relAtionship of fluid Between pressure And density.
alpha=0.1;
c=4.16;
d=18;
rcut_d=0.75;
A=-40;
B=20;
T=1.0; %T=temperature*kb
rho=0.1:0.01:8;
% rho=rho';

%zero
zerop=@(rho)rho*0.0 ;
%ideal fluid
pi=@(rho)T*rho ;

%DPD
pdpd=@(rho)T*rho + (alpha+0.001)*B*rho.^2;

%MDPD
%p=@(rho)2*alpha*B*(rcut_d^4)*(rho.^3)+(alpha*A-2*alpha*B*(rcut_d^4)*c)*(rho.^2)+T*rho+2*alpha*B*(rcut_d^4)*d;

pmdpd=@(rho)2*alpha*B*(rcut_d^4)*(rho.^3)+(alpha*A-2*alpha*B*(rcut_d^4)*c)*(rho.^2)+T*rho+2*alpha*B*(rcut_d^4)*d;

vrho=@(p)175663936/(36905625*((128*p)/405 + (((128*p)/405 + 308718230309/224201671875)^2 - 5420605838451650526969856/50266389671545166015625)^(1/2) + 308718230309/224201671875)^(1/3)) + ((128*p)/405 + (((128*p)/405 + 308718230309/224201671875)^2 - 5420605838451650526969856/50266389671545166015625)^(1/2) + 308718230309/224201671875)^(1/3) + 13544/6075;


%
[m,n]=size(rho);
EOS=zeros(n,5);
EOS(1:n,1)= rho';
EOS(1:n,2)= zerop(rho)';
EOS(1:n,3)= pi(rho)';
EOS(1:n,4)= pdpd(rho)';
EOS(1:n,5)= pmdpd(rho)';
%simulation value of press and density


%p=0.2*25*(^4)*(rho^3)+(0.1*(-40)-0.832*B*(0.75^4))*(rho^2)+1*rho+3.6*25*(0.75^4);
%plot(rho,zerop(rho),'k-.',rho,pi(rho),'g',rho,pdpd(rho),'b',rho,pmdpd(rho),'r')
% hold on
% plot(density,press)
%% Get the Extremum of function p
vpa(solve('(1215*rho^2)/256 - (1693*rho)/80 + 1','rho'))
%% find the point which p =0 /stegant point
solve('0.2*25*(0.75^4)*(rho^3)+(0.1*(-40)-0.832*25*(0.75^4))*(rho^2)+1*rho+3.6*25*(0.75^4)','rho')
%% Solving derivative
syms rho %alpha c d ruct_d A B T
p(rho)=0.2*25*(0.75^4)*(rho^3)+(0.1*(-40)-0.832*25*(0.75^4))*(rho^2)+1*rho+3.6*25*(0.75^4);
diff(p(rho))
%% Solving inverse function
alpha=0.1;
c=4.16;
d=18;
rcut_d=0.75;
A=-40;
B=25;
T=1.0; %T=temperature*kb
syms rho %alpha c d ruct_d A B T
p=sym(2*alpha*B*(rcut_d^4)*(rho^3)+(alpha*A-2*alpha*B*(rcut_d^4)*c)*(rho^2)+T*rho+2*alpha*B*(rcut_d^4)*d);
finverse(p)


%% find 
rho=5:0.01:7;
pmdpd=@(rho)2*alpha*B*(rcut_d^4)*(rho.^3)+(alpha*A-2*alpha*B*(rcut_d^4)*c)*(rho.^2)+T*rho+2*alpha*B*(rcut_d^4)*d;
MdpdP=pmdpd(rho);
figure
plot(rho,MdpdP,'g.')
hold on
% fitP= 0.9991*(rho.^3.085)-2145;
fitP= 0.00153*(rho.^5.748)-50.06;
plot(rho,fitP,'r-.')

