function [ evalue ] = extremum( x,y,Naverge )
% obtain the extremum value 

[Ns,n]=size(x);
evalue=zeros(Ns,3);
for i=1:Ns
    rsum=0.;
    lsum=0.;
    % suming
    for j=0:Naverge
        if (i-j)>0 rsum=rsum+y(i-j); end
        if (i+j)<= Ns lsum=lsum+y(i+j);end
    end
    
    % averaging
    if (i-Naverge)>0 
        rsum=rsum/(Naverge+1); 
    elseif (i-Naverge)<=0 
        rsum=rsum/i;
    end
    if (Ns-i)>= Naverge
        lsum=lsum/(Naverge+1);
    elseif (Ns-i)< Naverge
        lsum=lsum/(Ns-i+1);
    end
    
    % judge extremum value
    if rsum < y(i) && lsum < y(i)
        evalue(i,1)=y(i);
    elseif rsum > y(i) && lsum > y(i)
        evalue(i,2)=y(i);
    end   
    evalue(i,3)=evalue(i,1)+evalue(i,2);
end

end

