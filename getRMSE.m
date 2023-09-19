%%https://www.mathworks.com/matlabcentral/answers/81048-mse-mean-square-error
%%https://www.mathworks.com/matlabcentral/answers/4064-rmse-root-mean-square-error
%%https://www.mathworks.com/help/vision/ref/psnr.html
function M = getRMSE(inputImage,observedImage)

inputImage = double(inputImage);
observedImage = double(observedImage);

[row, column] = size(inputImage);

squareDifference = double(inputImage-observedImage).^2;
    
    %sumOfSquareDifference = sum(sum(squareDifference)); 
    sumOfSquareDifference = sum(squareDifference, 'all'); %"all" 
    %sumOfSquareDifference = sumOfSquareDifference(:,:,1);
     mse  = sumOfSquareDifference / (row * column);
     M = mse^.5;
end
