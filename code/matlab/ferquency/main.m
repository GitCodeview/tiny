clc
clear all
%% list of comparing file 
%nfile=11;
% method one
% for i=1:nfile
% [fname,fpath]=uigetfile({'*.plt;*.dat','All data Files';...
%     '*.*','All Files' });   %chose the input data file location
% cellfile{i} = fpath;
% cellfile{i,2}= fname;
% end
%% %MDPD

 cellfile={...
    './data/Barostat/'...
     }

%  cellfile={...
%     'G:\MDPD\MDPDcase\1.6.barostat\7.21.Fr1.0_0.75_A-40_B25_rho6_MDPD_lp0.0_tau10_JP50_FD20\data\Barostat\',...
%     'G:\MDPD\MDPDcase\1.6.barostat\7.15.Fr1.0_0.75_A-40_B25_rho6_MDPD_lp0.6_tau10_JP50_FD20\data\Barostat\',...
%     'G:\MDPD\MDPDcase\1.6.barostat\7.31.Fr1.0_0.75_A-40_B25_rho6_MDPD_lp0.8_tau10_JP50_FD20\data\Barostat\'...
%      }

%% output into the plt file
[i,nfile]=size(cellfile);
for i=1:nfile
%% Read files
% read original file TrhoP.plt, fpatch is the patch of TrhoP.plt.
% % The matrix TrhoP each colum is "time","T","rho","P","mu","tau",orderly.
% [TrhoPF,fpath]=readTrhoP(cellfile{i},'TrhoP.plt');  
% TrhoPF= sprintf('%s%s',cellfile{i},'TrhoP.mat');
% load(TrhoPF);
% Read data file into RT.plt
%[RT,fpath]=readRT(cellfile{i},'RT.plt');  
RT= sprintf('%s%s',cellfile{i},'RT.mat');
load(RT);
% Read data file into ExtraPara.dat
[ParaF]= readPara(cellfile{i});
load(ParaF);
%% find the frequency of oscillation
%????????1024????
fs=100; %\deltaT=0.01

N=10000;
x=BR((JStep+1000):(N+JStep+1000-1));
t=time((JStep+1000):(N+JStep+1000-1));

% n=0:1023;
% t=n/fs;
% x=(50.^(-t)).*sin(2*pi*15*t);%+2*sin(2*pi*40*t); %??

[fre,mag]= fftPlot(fs,t,x);

% find the frequency extremum
i=1;
for j=2:N/2
    if(mag(j)>mag(j-1) && mag(j)>mag(j+1))
        faext(i,1)=fre(j);
        faext(i,2)=mag(j);
        i=i+1;
    end
end

figure
plot(faext(:,1),faext(:,2))
hold on
% find the max frequency
famax=zeros(1,2);
famax(1,1)= faext(1,1);
famax(1,2)=faext(1,2);
for j=2:i-1
    if(faext(j,2)>famax(1,2))
        famax(1,1)=faext(j,1);
        famax(1,2)=faext(j,2);
    end
end

plot(famax(1,1),famax(1,2),'r*')

end

