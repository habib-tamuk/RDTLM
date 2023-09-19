% Read and pre-process images
% Copyright 2016 The MathWorks, Inc.
function Iout = readAndPreprocessImage(I)

%I = imread('C:\Users\AKM Rahmatullah Clg\Documents\MATLAB\patches\1185.jpg');

% Some images may be grayscale. Replicate the image 3 times to
% create an RGB image.

if ismatrix(I)
 I = cat(3,I,I,I);
 end
%%I=rgb2gray(I);
Iout = imresize(I, [224 224]); 
Iout = permute(Iout,[2 1 3]);
end

%224 x 224 is used for Resnet18, Resnet50, VGG16 and VGG19
%227 x 227 is used for Alexnet
%255 x 255 is used for Darknet19
%299 x 299 is used for Xception
