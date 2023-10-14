%%
%Preprocessing with k-means clustering
clc;
clear all;
close all;
in = imread('C:\Users\Lenovo\Downloads\Covid-19\Matlab\COVID_13.png');
pout = rgb2gray(in); %used for RGB image
%center oriented croping
targetSize = [165 137];
r = centerCropWindow2d(size(pout),targetSize);
cout = imcrop(pout,r);
cout=imresize(cout, [256 256]);
cout_imadjust = imadjust(cout); %Intensity Transformation
cout_imadjust = kmeans(cout_imadjust);
cout_histeq = histeq(cout);     %Histohram Processing
cout_histeq = im2uint8(mat2gray(cout_histeq)); %mat2gray used to convert grayscale image
cout_histeq = kmeans(cout_histeq);
cout_adapthisteq = adapthisteq(cout);       %Contrast limited adaptive histogram equalization
cout_adapthisteq = kmeans(cout_adapthisteq);
meanFilter = fspecial('average', [3 3]);    %Linear Spatial Filter, mean/average/box
cout_meanFilter = imfilter(cout, meanFilter);
cout_meanFilter = kmeans(cout_meanFilter);
cout_medFilter = medfilt2(cout); %Non linear Spatial Filter, median
cout_medFilter = kmeans(cout_medFilter);
%location oriented croping
lout = imcrop(pout,[18 18 140 172]);
lout=imresize(lout, [256 256]);
lout_imadjust = imadjust(lout);
lout_imadjust = kmeans(lout_imadjust);
lout_histeq = histeq(lout);
lout_histeq = im2uint8(mat2gray(lout_histeq)); %mat2gray used to convert grayscale image
lout_histeq = kmeans(lout_histeq);
lout_adapthisteq = adapthisteq(lout);
lout_adapthisteq = kmeans(lout_adapthisteq);
meanFilter = fspecial('average', [3 3]);
lout_meanFilter = imfilter(lout, meanFilter);
lout_meanFilter = kmeans(lout_meanFilter);
lout_medFilter = medfilt2(lout);
lout_medFilter = kmeans(lout_medFilter);
subplot(2,1,1),montage({in,cout_imadjust,cout_histeq,cout_adapthisteq,cout_meanFilter, cout_medFilter},'Size',[1 6])
title("Original Image and Enhanced Images using imadjust, histeq, adapthisteq, average and medfilt3 using center crop");
subplot(2,1,2),montage({in,lout_imadjust,lout_histeq,lout_adapthisteq,lout_meanFilter, lout_medFilter},'Size',[1 6])
title("Original Image and Enhanced Images using imadjust, histeq, adapthisteq, average and medfilt3 using location crop");
%%
%Measurement Matrics for Intensity Transformation
c_ad_rMSE = getRMSE(double(im2bw(cout)), double(im2bw(cout_imadjust))); %Root Mean Square Error (defined function)
c_ad_pSNR = getPSNR(double(im2bw(cout)), double(im2bw(cout_imadjust))); %Signal to noise Ratio (defined function)
c_ad_ssim = getMSSIM(double(im2bw(cout)), double(im2bw(cout_imadjust))); %Structural Similarity (building function)

l_ad_rMSE = getRMSE(double(im2bw(lout)), double(im2bw(lout_imadjust))); %Root Mean Square Error
l_ad_pSNR = getPSNR(double(im2bw(lout)), double(im2bw(lout_imadjust))); %Signal to noise Ratio
l_ad_ssim = getMSSIM(double(im2bw(lout)), double(im2bw(lout_imadjust))); %Structural Similarity

%%
%Measurement Matrics for Histohram Processing
c_he_rMSE = getRMSE(double(im2bw(cout)), double(im2bw(cout_histeq))); %Root Mean Square Error 
c_he_pSNR = getPSNR(double(im2bw(cout)), double(im2bw(cout_histeq))); %Signal to noise Ratio 
c_he_ssim = getMSSIM(double(im2bw(cout)), double(im2bw(cout_histeq))); %Structural Similarity 

l_he_rMSE = getRMSE(double(im2bw(lout)), double(im2bw(lout_histeq))); %Root Mean Square Error
l_he_pSNR = getPSNR(double(im2bw(lout)), double(im2bw(lout_histeq))); %Signal to noise Ratio
l_he_ssim = getMSSIM(double(im2bw(lout)), double(im2bw(lout_histeq))); %Structural Similarity

%Contrast limited adaptive histogram equalization
c_adhe_rMSE = getRMSE(double(im2bw(cout)), double(im2bw(cout_adapthisteq))); %Root Mean Square Error
c_adhe_pSNR = getPSNR(double(im2bw(cout)), double(im2bw(cout_adapthisteq))); %Signal to noise Ratio
c_adhe_ssim = getMSSIM(double(im2bw(cout)), double(im2bw(cout_adapthisteq))); %Structural Similarity

l_adhe_rMSE = getRMSE(double(im2bw(lout)), double(im2bw(lout_adapthisteq))); %Root Mean Square Error
l_adhe_pSNR = getPSNR(double(im2bw(lout)), double(im2bw(lout_adapthisteq))); %Signal to noise Ratio
l_adhe_ssim = getMSSIM(double(im2bw(lout)), double(im2bw(lout_adapthisteq))); %Structural Similarity
%%
%Measurement Matrics for Linear Spatial Filter, mean/average/box
c_mean_rMSE = getRMSE(double(im2bw(cout)), double(im2bw(cout_meanFilter))); %Root Mean Square Error
c_mean_pSNR = getPSNR(double(im2bw(cout)), double(im2bw(cout_meanFilter))); %Signal to noise Ratio
c_mean_ssim = getMSSIM(double(im2bw(cout)), double(im2bw(cout_meanFilter))); %Structural Similarity

l_mean_rMSE = getRMSE(double(im2bw(lout)), double(im2bw(lout_meanFilter))); %Root Mean Square Error
l_mean_pSNR = getPSNR(double(im2bw(lout)), double(im2bw(lout_meanFilter))); %Signal to noise Ratio
l_mean_ssim = getMSSIM(double(im2bw(lout)), double(im2bw(lout_meanFilter))); %Structural Similarity
%%
%Measurement Matrics for Non Linear Spatial Filter, median
c_med_rMSE = getRMSE(double(im2bw(cout)), double(im2bw(cout_medFilter))); %Root Mean Square Error
c_med_pSNR = getPSNR(double(im2bw(cout)), double(im2bw(cout_medFilter))); %Signal to noise Ratio
c_med_ssim = getMSSIM(double(im2bw(cout)), double(im2bw(cout_medFilter))); %Structural Similarity

l_med_rMSE = getRMSE(double(im2bw(lout)), double(im2bw(lout_medFilter))); %Root Mean Square Error
l_med_pSNR = getPSNR(double(im2bw(lout)), double(im2bw(lout_medFilter))); %Signal to noise Ratio
l_med_ssim = getMSSIM(double(im2bw(lout)), double(im2bw(lout_medFilter))); %Structural Similarity
