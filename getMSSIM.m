%%https://www.mathworks.com/matlabcentral/fileexchange/64151-structure-similarity-ssim-and-psnr
%%https://www.mathworks.com/help/images/ref/ssim.html
%%https://medium.com/srm-mic/all-about-structural-similarity-index-ssim-theory-code-in-pytorch-6551b455541e
function mssim = getMSSIM(inputImage,observedImage)
%Written by: Mahmoud Afifi ~ Assiut University, Egypt
%Reference: Z. Wang, A. C. Bovik, H. R. Sheikh and E. P. Simoncelli,
%�Image quality assessment: From error visibility to structural similarity,�
%IEEE Transactions on Image Processing, vol. 13, no. 4, pp. 600-612, Apr. 2004
%///////////////////////////////// INITS  ////////////////////////////////
C1 = 6.5025;
C2 = 58.5225;
inputImage=double(inputImage);
observedImage=double(observedImage);
inputImage_2=inputImage.^2;
observedImage_2=observedImage.^2;
inputImage_observedImage=inputImage.*observedImage;
%///////////////////////////////// PRELIMINARY COMPUTING ////////////////////////////////
mu1=imgaussfilt(inputImage,1.5);
mu2=imgaussfilt(observedImage,1.5);
mu1_2=mu1.^2;
mu2_2=mu2.^2;
mu1_mu2=mu1.*mu2;
sigma1_2=imgaussfilt(inputImage_2,1.5);
sigma1_2=sigma1_2-mu1_2;
sigma2_2=imgaussfilt(observedImage_2,1.5);
sigma2_2=sigma2_2-mu2_2;
sigma12=imgaussfilt(inputImage_observedImage,1.5);
sigma12=sigma12-mu1_mu2;
%///////////////////////////////// FORMULA ////////////////////////////////
t3 = ((2*mu1_mu2 + C1).*(2*sigma12 + C2));
t1 =((mu1_2 + mu2_2 + C1).*(sigma1_2 + sigma2_2 + C2));
ssim_map =  t3./t1;
ssim = mean2(ssim_map); mssim=mean(ssim(:));
end