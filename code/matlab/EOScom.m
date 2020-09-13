clc
clear all

d=18;c=4.16;alpha=0.101;
A=-20;B=25;rd=0.75;
kBT=0.9911;%0.9935;%0.9960;%
St=101.040162;%30.608563;%26.919925;%
Grho=5.779493;%5.772113;%5.777851;%
Lrho=6.867932;%6.888154;%6.885246;%
R0=3.319333;%3.318972;%3.317149;%
%% coefficient
para(1,1)=d*2*alpha*B*(rd^4);
para(1,2)=kBT;
para(1,3)=alpha*A-c*2*alpha*B*(rd^4);
para(1,4)=2*alpha*B*(rd^4);

%% partial pressure value
para(2,1)=para(1,1);
para(2,2)=para(1,2)*Grho;
para(2,3)=para(1,3)*(Grho^2);
para(2,4)=para(1,4)*(Grho^3);

%% frequency compute in scheme II

P=para(2,4)+para(2,3)+para(2,2)%+para(1,1)
freThry=sqrt((9*para(2,4)+6*para(2,3)+3*para(2,2)...
    -(2*St)/R0)/Lrho)/(2*pi*R0)
%% find the best k
k=2:0.01:16;
frestd=zeros(size(k))+0.34;
frestdThry=zeros(size(k))+freThry;
fre=sqrt((3*k*P-(2*St)/R0)/Lrho)/(2*pi*R0);
plot(k,fre,'k-',k,frestd,'r-.',k,frestdThry,'g-.')
hold on
%% plot special case in scheme I
kSpc=7.794;%7.531;
aSpc=3.179e-05;%5.382e-05;
PSpc=aSpc*Grho^kSpc;
freSpc=sqrt((3*kSpc*P-(2*St)/R0)/Lrho)/(2*pi*R0);
frestdSpc=zeros(size(k))+freSpc;
plot(k,frestdSpc,'b-.')
xlabel 'k'
ylabel 'frequency'

%% compare deviation0.5544(63\%)  \\
% 0.5869(73\%)   &	0.5893(73\%)  \\
x0=0.35;
x=0.4325;
x0pi=x0*2*pi
xpi=x*2*pi
prc=(x-x0)*100/x0

y=[0.5773,0.5869,0.5893]
y*2*pi
