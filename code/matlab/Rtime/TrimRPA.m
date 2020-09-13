 clc
 clear all
%% read the data from RP.plt
NS=30000;
NE=34000;
[RT,fpath]= readRPA();
% trim RT
Nsample=[0:((NE-NS)/2)];
R=RT(NS:2:NE,2);
T=Nsample.*0.01;
clear RT Bc
plot(T,R)
% save the trim results
RTfile = sprintf('%s%s',fpath,'RT.plt');
RTplt=fopen(RTfile,'w');
fprintf(RTplt,'Variables= "Radius","time"\nZONE  T="RT"\nF = POINT\n');
m=size(Nsample);
for i=1:m(2)
    fprintf(RTplt,'%8.6f %8.6f\n',T(i),R(i));
end