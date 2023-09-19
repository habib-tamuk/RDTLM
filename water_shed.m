%%https://www.mathworks.com/matlabcentral/fileexchange/13628-edge-detection-and-segmentation
function rfgm = water_shed(im)
f = im; 

%page 593
h=fspecial('sobel');
fd=im2double(f);
sq=sqrt(imfilter(fd,h,'replicate').^2+imfilter(fd,h','replicate').^2);
%page 595
im=imextendedmin(f,20); %extended minima transform
Lim=watershed(bwdist(im));
em=Lim==0;

%page 596
rfmin=imimposemin(sq,im|em);
wsdmin=watershed(rfmin);

rfgm=f;
rfgm(wsdmin==0)=255;
end