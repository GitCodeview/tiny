function [outfile,fpath]= readTrhoP(fpath,fname)
%Read data file into RDF

% [fname,fpath]=uigetfile({'*.plt;*.dat','All data Files';...
%     '*.*','All Files' });   %chose the input data file location
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
cell=textscan(tempstr,'%f %f %f %f %f %f\n');
time(1:nline)=cell{1};
T(1:nline)=cell{2};
rho(1:nline)=cell{3};
P(1:nline)=cell{4};
mu(1:nline)=cell{5};
tau(1:nline)=cell{6};

fclose(fidin);

%% Save the data for next step
outfile = sprintf('%s%s',fpath,'TrhoP.mat');
save(outfile,'time','T','rho','P','mu','tau');
end

