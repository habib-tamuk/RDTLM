%%https://www.mathworks.com/matlabcentral/fileexchange/27022-image-segmentation-using-fuzzy-c-means-with-two-image-inputs
function fuzzyc = cmeans(I)

I = im2double(I);
I = imadjust(I);

data = [I(:)]; % data array
[center,U] = fcm(data,7); % Fuzzy C-means classification with 7 classes
         
% Finding the pixels for each class
maxU = max(U);
index1 = find(U(1,:) == maxU);
index2 = find(U(2,:) == maxU);
index3 = find(U(3,:) == maxU);
index4 = find(U(4,:) == maxU);
index5 = find(U(5,:) == maxU);
index6 = find(U(6,:) == maxU);
index7 = find(U(7,:) == maxU);
 
% Assigning pixel to each class by giving them a specific value
fcmImage(1:length(data))=0;       
fcmImage(index1)= 1;
fcmImage(index2)= 0.8;
fcmImage(index3)= 0.6;
fcmImage(index4)= 0.4;
fcmImage(index5)= 0.2;
fcmImage(index6)= 0.1;
fcmImage(index7)= 0.0;
% Reshapeing the array to a image
imagNew = reshape(fcmImage,[256, 256]);
fuzzyc = mat2gray(imagNew);
fuzzyc = im2uint8(imagNew);
end

