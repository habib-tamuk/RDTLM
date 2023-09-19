%%https://www.mathworks.com/matlabcentral/fileexchange/13628-edge-detection-and-segmentation
% Consider a binary image composed of small blobs. Segmenting the circular
% blobs using 
%    a) Distance Transform
%    b) Watershed Transform
clc;
clear all;
close all; 

in=imread('C:\Users\Lenovo\Downloads\Covid-19\Matlab\COVID_13.png');
pout = rgb2gray(in); %used for RGB image
cout=imresize(pout, [1650 1350]);
cout_medFilter = medfilt2(cout);

f = cout_medFilter; 

%page 589
bw=im2bw(f,graythresh(f));
bwc=~bw;
%page591
dst=bwdist(bwc);
ws=watershed(-dst);
w=ws==0;
figure,imshow(ws),title('Watershed - Distance Transformation');
rf=bw&~w;

figure,imshow(rf),title('Superimposed - Watershed (DT) and original image');

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
figure,imshow(rfmin),title('Watershed - Gradient and Marker Controlled');


rfgm=f;
rfgm(wsdmin==0)=255;
figure,imshow(rfgm),title('Superimposed - Watershed (GM) and original image');
%%
rf_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(rf)); %Root Mean Square Error (defined function)
rf_sNR = getPSNR(double(im2bw(cout_medFilter)), double(rf)); %Signal to noise Ratio (defined function)
rf_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(rf)); %Structural Similarity (building function)
%%
rfmin_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(im2bw(im2uint8(mat2gray(rfmin))))); %Root Mean Square Error (defined function)
rfmin_sNR = getPSNR(double(im2bw(cout_medFilter)), double(im2bw(im2uint8(mat2gray(rfmin))))); %Signal to noise Ratio (defined function)
rfmin_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(im2bw(im2uint8(mat2gray(rfmin))))); %Structu
%%
rfgm_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(im2bw(rfgm))); %Root Mean Square Error (defined function)
rfgm_sNR = getPSNR(double(im2bw(cout_medFilter)), double(im2bw(rfgm))); %Signal to noise Ratio (defined function)
rfgm_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(im2bw(rfgm))); %Structural Similarity (building function)