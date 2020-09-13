
c=4;
r=0:0.1:10;
%%
a=2;
b=-3;
figure
plot(r,pfunc(r,a,b,c),'g.-')
hold on
a=2;
b=-4;
plot(r,pfunc(r,a,b,c),'r.')