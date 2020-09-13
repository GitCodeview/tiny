clc
clear all

%% %MDPD
type='MDPD';
delta = 0.0;
cellfile={...
    'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\1.1.MDPD_DT0.005_tau10\data\',...
    'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\1.2.MDPD_DT0.005_tau100\data\',...
    'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\1.3.MDPD_DT0.005_tau1000\data\',...
    'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\1.4.MDPD_DT0.01_tau10\data\',...
    'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\1.5.MDPD_DT0.01_tau100\data\',...
    'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\1.6.MDPD_DT0.01_tau1000\data\',...
    'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\1.7.MDPD_DT0.02_tau10\data\',...
    'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\1.8.MDPD_DT0.02_tau100\data\',...
    'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\1.9.MDPD_DT0.02_tau1000\data\'...
     }
% type='MDPD';
% delta = 0.8;
% cellfile={...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\3.1.MDPD_DT0.005_tau10\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\3.2.MDPD_DT0.005_tau100\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\3.3.MDPD_DT0.005_tau1000\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\3.4.MDPD_DT0.01_tau10\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\3.5.MDPD_DT0.01_tau100\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\3.6.MDPD_DT0.01_tau1000\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\3.7.MDPD_DT0.02_tau10\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\3.8.MDPD_DT0.02_tau100\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\3.9.MDPD_DT0.02_tau1000\data\'...
%      }
%  %DPD
% type='DPD';
% delta = 0.0;
% cellfile={...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\0.1.DPD_DT0.005_tau10\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\0.2.DPD_DT0.005_tau100\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\0.3.DPD_DT0.005_tau1000\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\0.4.DPD_DT0.01_tau10\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\0.5.DPD_DT0.01_tau100\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\0.6.DPD_DT0.01_tau1000\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\0.7.DPD_DT0.02_tau10\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\0.8.DPD_DT0.02_tau100\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\0.9.DPD_DT0.02_tau1000\data\'...
%      }
%  
% type='DPD';
% delta = 0.6
% cellfile={...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\2.1.DPD_DT0.005_tau10\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\2.2.DPD_DT0.005_tau100\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\2.3.DPD_DT0.005_tau1000\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\2.4.DPD_DT0.01_tau10\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\2.5.DPD_DT0.01_tau100\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\2.6.DPD_DT0.01_tau1000\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\2.7.DPD_DT0.02_tau10\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\2.8.DPD_DT0.02_tau100\data\',...
%     'G:\MDPD\MDPDcase\1.7.EOS\barostatCompressibility\2.9.DPD_DT0.02_tau1000\data\'...
%      }
 
 
%% output into the plt file
Vpltfile=sprintf('%s%s%0.1f%s','barostatcom-',type,delta,'.plt');
Vplt=fopen(Vpltfile,'w');
fprintf(Vplt,'Variables= "riseTime","lpercent","T","v","v2NPT","beta","KT"\n');

[i,nfile]=size(cellfile);
Kt=zeros(nfile,1);
% for i=1:nfile
% %% read original file TrhoP.plt, fpatch is the patch of TrhoP.plt.
% % The matrix TrhoP each colum is "time","T","rho","P","mu","tau",orderly.
% [TrhoPF,fpath]=readTrhoP(cellfile{i},'TrhoP.plt'); 
% [vlm,fpath]=readvlm(cellfile{i},'vlm.plt');
% end
for i=1:nfile
%% load data 
TrhoPF= sprintf('%s%s',cellfile{i},'TrhoP.mat');
vlm= sprintf('%s%s',cellfile{i},'vlm.mat');
load(TrhoPF);
load(vlm);
%% Read data file into ExtraPara.dat
[ParaF]= readPara(cellfile{i});
load(ParaF);
%% find the barostat end time
[j,AStep]=size(time);
AStep=AStep-1;
Nend=AStep-10000;
% for j = JStep:AStep
%     if(P(j)>= JPress) Nend=j;break;end
% %    if (abs(P(i)-JPress)/JPress) < 0.1 Nrtime=i;break;end
% end
% rtime=time(Nend)-time(JStep); % obtain the real rising time
%% get each variable:Mean/Standard Deviation
Tmstd=zeros(3,2);

% for T - temperature
Tmstd(1,1)= mean(T(1:JStep),2);
Tmstd(1,2)= std(T(1:JStep),0,2);
Tmstd(2,1)= mean(T(JStep:AStep),2);
Tmstd(2,2)= std(T(JStep:AStep),0,2);
Tmstd(3,1)= mean(T(Nend:AStep),2);
Tmstd(3,2)= std(T(Nend:AStep),0,2);

%% compute the compressibility
vmstd=zeros(3,2);
v2mstd=zeros(3,2);
v2NPT=zeros(3,1);
beta=zeros(3,1);
% v
vmstd(1,1)= mean(v(1:JStep),2);
vmstd(1,2)= std(v(1:JStep),0,2);
vmstd(2,1)= mean(v(JStep:AStep),2);
vmstd(2,2)= std(v(JStep:AStep),0,2);
vmstd(3,1)= mean(v(Nend:AStep),2);
vmstd(3,2)= std(v(Nend:AStep),0,2);
% v2
v2mstd(1,1)= mean(v2(1:JStep),2);
v2mstd(1,2)= std(v2(1:JStep),0,2);
v2mstd(2,1)= mean(v2(JStep:AStep),2);
v2mstd(2,2)= std(v2(JStep:AStep),0,2);
v2mstd(3,1)= mean(v2(Nend:AStep),2);
v2mstd(3,2)= std(v2(Nend:AStep),0,2);

item=3;
%%compute the compressibility with no barostat
PartileNo=118800-10800;
rho=PartileNo/vmstd(item,1);
alpha=0.101;
c=4.16;
A=-40;
B=25;
rd=0.75;

if strcmp(type,'MDPD')
KT(i,1)=1/(rho*(Tmstd(item,1)+2*A*alpha*rho+2*alpha*B*(rd^4)*(3*rho*rho-2*c*rho)));
i,'MDPD'
elseif strcmp(type,'DPD')
KT(i,1)=1/(rho*(Tmstd(item,1)+2*B*alpha*rho));
i,'DPD'
end

if riseTime == 10
    fprintf(Vplt,'zone\n');
end
%%for item=1:3
v2NPT(item,1)=v2mstd(item,1)-(vmstd(item,1)^2);
beta(item,1)=v2NPT(item,1)/(vmstd(item,1)*Tmstd(item,1));
fprintf(Vplt,'%9.4f %9.4f %17.10f %17.10f %17.10f %17.10f %17.10f\n',...
riseTime,lpercent,...
Tmstd(item,1),vmstd(item,1),...
v2NPT(item,1),beta(item,1),KT(i,1));
%%end

end
%% close the files
fclose(Vplt);




