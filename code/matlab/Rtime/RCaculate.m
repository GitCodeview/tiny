%% Read data file into BP which is the coordinate of all particles

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
cell=textscan(tempstr,'%f %f %f\n');
BP=zeros(nline,3);
BP(1:nline,1)=cell{1};
BP(1:nline,2)=cell{2};
BP(1:nline,3)=cell{3};

fclose(fidin);

%% caculate the centre point of the sphere
BPC=zeros(1,3);
for i =1:nline
    BPC(1,1)= BPC(1,1) + BP(i,1);
    BPC(1,2)= BPC(1,2) + BP(i,2);
    BPC(1,3)= BPC(1,3) + BP(i,3);
end
BPC(1,1)= BPC(1,1) /nline;
BPC(1,2)= BPC(1,2) /nline;
BPC(1,3)= BPC(1,3) /nline;

BPC

%% caculate the sphere radius

% get the relative coordinate 
BPmc=zeros(nline,3);
for i =1:nline
    BPmc(i,1) =  BP(i,1) - BPC(1,1);
    BPmc(i,2) =  BP(i,2) - BPC(1,2);
    BPmc(i,3) =  BP(i,3) - BPC(1,3);
end
I=zeros(3,3);
for i =1:nline
    for j = 1:3
        for k =1:3        
            I(j,k) = I(j,k) + BPmc(i,k)*BPmc(i,j);
        end
    end
end

theta = 0.5*atan(2*I(1,3)/(I(1,1)- I(3,3)))

S1 = I(1,1)*cos(theta)^2 + I(3,3)*sin(theta)^2 + 2*I(1,3)*sin(theta)*cos(theta);

S2 = I(1,1)*sin(theta)^2 + I(3,3)*cos(theta)^2 - 2*I(1,3)*sin(theta)*cos(theta);

S3 = I(2,2);
    
    
BR = (125*S1*S2*S3/(nline^3))^(1/15)

BRa= sqrt(5*I(1,1)/nline)
BRb= sqrt(5*I(2,2)/nline)
BRc= sqrt(5*I(2,2)/nline)

BR = (BRa+BRb+BRc)/3

for i =1:nline
    BPmc(i,1) =  BPmc(i,1)*cos(theta)+BPmc(i,3)*sin(theta);
    BPmc(i,3) =  -BPmc(i,1)*sin(theta)+BPmc(i,3)*cos(theta);
end

for j = 1:3
    for k =1:3        
        I(j,k) = 0.0;
    end        
end
    
for i =1:nline
    for j = 1:3
        for k =1:3        
            I(j,k) = I(j,k) + BPmc(i,k)*BPmc(i,j);
        end
    end
end

BRa= sqrt(5*I(1,1)/nline);
BRb= sqrt(5*I(2,2)/nline);
BRc= sqrt(5*I(2,2)/nline);

BR = (BRa+BRb+BRc)/3

rho = 3*nline/(4*pi*BRa*BRb*BRc)
rho = 3*nline/(4*pi*BR^3)









