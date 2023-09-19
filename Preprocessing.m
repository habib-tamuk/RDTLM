%%
%Preprocessing without clustering
clc;
clear all;
close all;
in = imread('C:\Users\Lenovo\Downloads\Covid-19\Matlab\COVID_13.png');
pout = rgb2gray(in); %used for RGB image
cout=imresize(pout, [256 256]);
cout_imadjust = imadjust(cout); %Intensity Transformation
cout_histeq = histeq(cout);     %Histohram Equalization
%cout_histeq = hisequ(cout); %User Defined Function
cout_histeq = im2uint8(mat2gray(cout_histeq)); %mat2gray used to convert grayscale image
cout_adapthisteq = adapthisteq(cout);       %Contrast limited adaptive histogram equalization
meanFilter = fspecial('average', [3 3]);    %Linear Spatial Filter, mean/average/box
cout_meanFilter = imfilter(cout, meanFilter);
cout_medFilter = medfilt2(cout); %Non linear Spatial Filter, median

figure, subplot(2,1,1),montage({in,cout_imadjust,cout_histeq},'Size',[1 3])
% title("Original Image, Intensity Transformation, Histogram Equalization");
subplot(2,1,2),montage({cout_adapthisteq,cout_meanFilter, cout_medFilter},'Size',[1 3])
%title("CLA Histogram Equalization, Mean Filter and Median Filter");

figure, subplot(2,3,1), imshow(in), title("Original Image",'FontName','times', 'FontSize', 8);
        subplot(2,3,2), imshow(cout_imadjust), title("Intensity Transformation",'FontName','times','FontSize', 8);
        subplot(2,3,3), imshow(cout_histeq), title("Histogram Equalization",'FontName','times', 'FontSize', 8);
        subplot(2,3,4), imshow(cout_adapthisteq),title("CLAHE",'FontName','times', 'FontSize', 8);
        subplot(2,3,5), imshow(cout_meanFilter), title("Mean Filter",'FontName','times', 'FontSize', 8);
        subplot(2,3,6), imshow(cout_medFilter),title("Median Filter",'FontName','times', 'FontSize', 8);

figure, subplot(2,3,1), imhist(in), title("Original Image",'FontName','times', 'FontSize', 8);
        subplot(2,3,2), imhist(cout_imadjust), title("Intensity Transformation",'FontName','times','FontSize', 8);
        subplot(2,3,3), imhist(cout_histeq), title("Histogram Equalization",'FontName','times', 'FontSize', 8);
        subplot(2,3,4), imhist(cout_adapthisteq),title("CLAHE",'FontName','times', 'FontSize', 8);
        subplot(2,3,5), imhist(cout_meanFilter), title("Mean Filter",'FontName','times', 'FontSize', 8);
        subplot(2,3,6), imhist(cout_medFilter),title("Median Filter",'FontName','times', 'FontSize', 8);

%%
%Measurement Matrics for Intensity Transformation
it_rMSE = getRMSE(double(im2bw(cout)), double(im2bw(cout_imadjust))); %Root Mean Square Error (defined function)
it_pSNR = getPSNR(double(im2bw(cout)), double(im2bw(cout_imadjust))); %Signal to noise Ratio (defined function)
it_mSSIM = getMSSIM(double(im2bw(cout)), double(im2bw(cout_imadjust))); %Structural Similarity (building function)

%%
%Measurement Matrics for Histohram Equalization
he_rMSE = getRMSE(double(im2bw(cout)), double(im2bw(cout_histeq))); %Root Mean Square Error 
%he_MSE = immse(double(im2bw(cout)), double(im2bw(cout_histeq))); %Mean Square Error use 10 * log10
%he_rMSE1 = sqrt(he_MSE);
%he_rMSE_1 = getRMSE_1(double(im2bw(cout)), double(im2bw(cout_histeq))); %Root Mean Square Error 
he_pSNR = getPSNR(double(im2bw(cout)), double(im2bw(cout_histeq))); %Signal to noise Ratio 
%he_peaksnr = psnr(double(im2bw(cout)), double(im2bw(cout_histeq)));
he_mSSIM = getMSSIM(double(im2bw(cout)), double(im2bw(cout_histeq))); %Structural Similarity 


%Contrast limited adaptive histogram equalization
clahe_rMSE = getRMSE(double(im2bw(cout)), double(im2bw(cout_adapthisteq))); %Root Mean Square Error
clahe_pSNR = getPSNR(double(im2bw(cout)), double(im2bw(cout_adapthisteq))); %Signal to noise Ratio
clahe_mSSIM = getMSSIM(double(im2bw(cout)), double(im2bw(cout_adapthisteq))); %Structural Similarity

%%
%Measurement Matrics for Linear Spatial Filter, mean/average/box
mean_rMSE = getRMSE(double(im2bw(cout)), double(im2bw(cout_meanFilter))); %Root Mean Square Error
mean_pSNR = getPSNR(double(im2bw(cout)), double(im2bw(cout_meanFilter))); %Signal to noise Ratio
mean_mSSIM = getMSSIM(double(im2bw(cout)), double(im2bw(cout_meanFilter))); %Structural Similarity

%%
%Measurement Matrics for Non Linear Spatial Filter, median
median_rMSE = getRMSE(double(im2bw(cout)), double(im2bw(cout_medFilter))); %Root Mean Square Error
median_pSNR = getPSNR(double(im2bw(cout)), double(im2bw(cout_medFilter))); %Signal to noise Ratio
median_mSSIM = getMSSIM(double(im2bw(cout)), double(im2bw(cout_medFilter))); %Structural Similarity
