function [ p_out ] = pfunc( r,a,b,c )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
p_out=zeros(size(r));
p_out=a./r+b*sqrt(r.^2-c^2);
end

