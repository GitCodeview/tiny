function [outfile] = outputPLT( fname,T,R )
% output the density and pressure relationship
outfile=sprintf('%s%s',fname,'.plt');
RP=fopen(outfile,'w');

[m,n]=size(T);
fprintf(RP,'Variables= "<i>t(<greek>m</greek>s)</i>","Radius(<i><greek>m</greek>m</i>)"\nZONE T=%s \nF = POINT\n',fname);
for i=1:m
    tT(i)=T(i).*1E6;
    tR(i)=R(i).*1E6;
    fprintf(RP,'%5.3e %10.6e\n',tT(i),tR(i));
end
end
