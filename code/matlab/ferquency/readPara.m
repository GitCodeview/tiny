function [outfile]= readPara(fpath)
%Read data file into ExtraPara

[k,l]=size(fpath);
infile = sprintf('%s%s',fpath(1:l-9),'ExtraPara.dat');
fidin=fopen(infile,'r'); % open orignal input data file

tempstr='';
nline=0;

while ~feof(fidin)% judge whether we ger the end of the input file
  tline=fgetl(fidin); % read one line 
  if ~isempty(tline) %  judge whether the is empty one
    [m,n]=size(tline);
    flag=1;
    for i=1:n ;% judge whether the line have char?except ?? E e and space?
      if ~(tline(i)==' '|tline(i)=='-'|tline(i)=='.'|tline(i)=='E'...
          |tline(i)=='e'|tline(i)=='+'...
          |(double(tline(i))>=48&&double(tline(i))<=57))
        flag=0;
        break;
      end
    end
    if flag==1; % if the line is the numerical line write the data
      tempstr = sprintf('%s%s\n',tempstr,tline);
      nline=nline+1;
    end
  end
end
cell=textscan(tempstr,'%f %f %f %f %f %f\n');
Para=zeros(nline,6);
Para(1:nline,1)=cell{1};
Para(1:nline,2)=cell{2};
Para(1:nline,3)=cell{3};
Para(1:nline,4)=cell{4};
Para(1:nline,5)=cell{5};
Para(1:nline,6)=cell{6};

nRDF = Para(1,2);
JStep = Para(4,1);
BStep = Para(4,2);
Density = Para(4,3);
JPress = Para(4,4);
riseTime = Para(4,5);
lpercent = Para(4,6);

fclose(fidin);

%% Save the data for next step
outfile = sprintf('%s%s',fpath,'Para.mat');
save(outfile,'nRDF','JStep','BStep','Density','JPress','riseTime','lpercent');
end

