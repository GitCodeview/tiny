function [ RT,fpath ] = readRPA()
%% Read data file into Bc RT which is the coordinate of bubble centre and radius

[fname,fpath]=uigetfile({'*.plt;*.dat','All data Files';...
    '*.*','All Files' });   %chose the input data file location
infile = sprintf('%s%s',fpath,fname);
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
cell=textscan(tempstr,'%f %f %f %f %f\n');
RT=zeros(nline,2);
% Bc=zeros(nline,3);
RT(1:nline,1)=cell{1};
RT(1:nline,2)=cell{2};
% Bc(1:nline,1)=cell{3};
% Bc(1:nline,2)=cell{4};
% Bc(1:nline,3)=cell{5};

fclose(fidin);

end