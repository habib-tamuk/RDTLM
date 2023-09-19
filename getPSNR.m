%%https://www.mathworks.com/matlabcentral/fileexchange/64151-structure-similarity-ssim-and-psnr
%%https://www.mathworks.com/help/vision/ref/psnr.html
%%https://www.mathworks.com/help/images/ref/psnr.html
function psnr = getPSNR(inputImage,observedImage)
%Written by: Mahmoud Afifi ~ Assiut University, Egypt
inputImage = double(inputImage);
observedImage = double(observedImage);

[row, column] = size(inputImage);

squareDifference = double(inputImage-observedImage).^2;

    
    sumOfSquareDifference = sum(sum(squareDifference)); 
    %sumOfSquareDifference = sum(squareDifference, 'all'); %"all" 
    %sumOfSquareDifference = sumOfSquareDifference(:,:,1);
    if( sumOfSquareDifference <= 1e-10) 
        psnr=0;
    else
        mse  = sumOfSquareDifference / (row * column);
        %psnr = 10.0 * log10((max(max(inputImage))) * (max(max(observedImage))) / mse);
        psnr = 10.0 * log10((max(inputImage,[], "all")) * (max(observedImage,[],'all')) / mse);        
    end
end