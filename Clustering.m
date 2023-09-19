%%
%Preprocessing without clustering
clc;
clear all;
close all;
in = imread('C:\Users\Lenovo\Downloads\Covid-19\Matlab\COVID_13.png');
pout = rgb2gray(in); %used for RGB image
%pout = in;
%center oriented croping

cout=imresize(pout, [256 256], 'bicubic'); %image interpolation

cout_medFilter = medfilt2(cout); %Non linear Spatial Filter, median

[counts,x] = imhist(cout_medFilter,16); %Threshold based otsu's method with 16-bit histogram
T = otsuthresh(counts);
th = im2bw(cout_medFilter,T);

%Th = otsu(cout_medFilter); %User Defined Function

[ed, t] = edge(cout_medFilter, 'canny'); %edge based with canny approximation

ws = water_shed(cout_medFilter); %User Defined Function

km = kmeans(cout_medFilter); %User Defined Function

rg = regiongrow(cout_medFilter, 1, .26); %User Defined Function

ml = bwmorph(cout_medFilter,'thin', Inf); %Morphology Based Clustering

cm = cmeans(cout_medFilter); %User Defined 7 cluster Based Fuzzy Clustering

fc = fuzzy_c(cout_medFilter); %User Defined 10 cluster Based Fuzzy Clustering

figure, subplot(3,1,1),montage({in, th, ed},'Size',[1 3]) %Three row, One column and Sirst Position
%title("Original Image, Threshold Based, Edge Based");
subplot(3,1,2),montage({ws, km, rg},'Size',[1 3]) %%Three row, One column and Second Position
%title("Watershed Based (otsu), K-means Based (10), Region Based");
subplot(3,1,3),montage({ml, cm, fc},'Size',[1 3]) %%Three row, One column and Third Position
%title("Morphology Based, Fuzzy C-means (7), Fuzzy C-means (10)");


figure, subplot(3,3,1), imshow(in), title("Original Image",'FontName','times', 'FontSize', 8);
        subplot(3,3,2), imshow(th), title("Threshold Based",'FontName','times', 'FontSize', 8);
        subplot(3,3,3), imshow(ed), title("Edge Based",'FontName','times', 'FontSize', 8);
        subplot(3,3,4), imshow(ws), title("Watershed",'FontName','times', 'FontSize', 8);
        subplot(3,3,5), imshow(km), title("K-means (10 cluster)",'FontName','times', 'FontSize', 8);
        subplot(3,3,6), imshow(rg), title("Region Growing",'FontName','times', 'FontSize', 8);
        subplot(3,3,7), imshow(ml), title("Morphology Based",'FontName','times', 'FontSize', 8);
        subplot(3,3,8), imshow(cm), title("C-means (7 cluster)",'FontName','times', 'FontSize', 8);
        subplot(3,3,9), imshow(fc), title("C-means (10 cluster)",'FontName','times', 'FontSize', 8);

figure, subplot(3,3,1), imhist(in), title("Original Image",'FontName','times', 'FontSize', 8);
        subplot(3,3,2), imhist(th), title("Threshold Based",'FontName','times', 'FontSize', 8);
        subplot(3,3,3), imhist(ed), title("Edge Based",'FontName','times', 'FontSize', 8);
        subplot(3,3,4), imhist(ws), title("Watershed",'FontName','times', 'FontSize', 8);
        subplot(3,3,5), imhist(km), title("K-means C-means (10 cluster)",'FontName','times', 'FontSize', 8);
        subplot(3,3,6), imhist(rg), title("Region Growing",'FontName','times', 'FontSize', 8);
        subplot(3,3,7), imhist(ml), title("Morphology Based",'FontName','times', 'FontSize', 8);
        subplot(3,3,8), imhist(cm), title("C-means (7 cluster)",'FontName','times', 'FontSize', 8);
        subplot(3,3,9), imhist(fc), title("C-means (10 cluster)",'FontName','times', 'FontSize', 8);
%%
%Measurement Matrics 
%Threshold based
% Th_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(Th)); %Root Mean Square Error (defined function)
% Th_pSNR = getPSNR(double(im2bw(cout_medFilter)), double(Th)); %Signal to noise Ratio (defined function)
% Th_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(Th)); %Structural Similarity (building function)

th_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(th)); %Root Mean Square Error (defined function)
%th_MSE = immse(double(im2bw(cout_medFilter)), double(th)); %Mean Square Error use 10 * log10
%th_rMSE1 = sqrt(th_MSE);
%th_rMSE_1 = getRMSE_1(double(im2bw(cout_medFilter)), double(th)); %Root Mean Square Error 
th_pSNR = getPSNR(double(im2bw(cout_medFilter)), double(th)); %Signal to noise Ratio (defined function)
%th_peaksnr = psnr(double(im2bw(cout_medFilter)), double(th)); 
th_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(th)); %Structural Similarity (building function)

%%
%edge based
ed_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(ed)); %Root Mean Square Error (defined function)
ed_pSNR = getPSNR(double(im2bw(cout_medFilter)), double(ed)); %Signal to noise Ratio (defined function)
ed_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(ed)); %Structural Similarity (building function)

%%
%watershed based
ws_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(im2bw(ws))); %Root Mean Square Error (defined function)
ws_pSNR = getPSNR(double(im2bw(cout_medFilter)), double(im2bw(ws))); %Signal to noise Ratio (defined function)
ws_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(im2bw(ws))); %Structural Similarity (building function)

%%
%k-means k=10 clustering
km_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(im2bw(km))); %Root Mean Square Error 
km_pSNR = getPSNR(double(im2bw(cout_medFilter)), double(im2bw(km))); %Signal to noise Ratio 
km_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(im2bw(km))); %Structural Similarity 
%%
%region based
rg_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(im2bw(rg))); %Root Mean Square Error (defined function)
rg_pSNR = getPSNR(double(im2bw(cout_medFilter)), double(im2bw(rg))); %Signal to noise Ratio (defined function)
rg_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(im2bw(rg))); %Structural Similarity (building function)
%%
%morphology based
ml_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(ml)); %Root Mean Square Error (defined function)
ml_pSNR = getPSNR(double(im2bw(cout_medFilter)), double(ml)); %Signal to noise Ratio (defined function)
ml_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(ml)); %Structural Similarity (building function)

%%
%fuzzy c means for 7 cluster
cm_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(im2bw(cm))); %Root Mean Square Error 
cm_pSNR = getPSNR(double(im2bw(cout_medFilter)), double(im2bw(cm))); %Signal to noise Ratio 
cm_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(im2bw(cm))); %Structural Similarity 
%fuzzy c means for 10 cluster
fc_rMSE = getRMSE(double(im2bw(cout_medFilter)), double(im2bw(fc))); %Root Mean Square Error 
fc_pSNR = getPSNR(double(im2bw(cout_medFilter)), double(im2bw(fc))); %Signal to noise Ratio 
fc_mSSIM = getMSSIM(double(im2bw(cout_medFilter)), double(im2bw(fc))); %Structural Similarity 