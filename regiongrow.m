function [g, nr] = regiongrow(x, s, t)
f=double(x);
if numel(s)==1
    si=f==s;
    s1=s;
else
    si=bwmorph(s,'shrink',Inf);
    s1=f(si);
end
ti=false(size(f));
for k=1:length(s1)
    sv=s1(k);
    s=abs(f-sv)<=t;
    ti=ti|s;
end
[g, nr]=bwlabel(imreconstruct(si,ti));
g = mat2gray(g);
g = im2uint8(g);
end
