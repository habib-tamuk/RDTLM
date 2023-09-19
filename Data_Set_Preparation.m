%%Process with Normal Image (With Clustering)
clc;
clear all;
close all; 
iFolder='C:\Users\Lenovo\Downloads\Covid-19\Matlab\Tawshif\Normal';  
I=dir(fullfile(iFolder,'*.png'));

fnum = 1:10192;
ext = '.png';

for i=1:numel(I)
  ifilename = fullfile(iFolder,I(i).name);
  J{i} = imread(ifilename);
  %K{i} = rgb2gray(J{i}); %Used for RGB Image
  L{i} = imresize(J{i}, [256 256]);
  M{i} = medfilt2(L{i});
  N{i} = water_shed(M{i}); 
  path ='C:\Users\Lenovo\Downloads\Covid-19\Matlab\Image\Healthy\Healthy';
  dir(path);
  imwrite(N{i},[path, num2str(fnum(i)) ext]);
end
%%
%%Process with Covid Image (With Clustering)
clc;
clear all;
close all; 
iFolder='C:\Users\Lenovo\Downloads\Covid-19\Matlab\Tawshif\COVID';  
I=dir(fullfile(iFolder,'*.png'));

fnum = 1:3616;
ext = '.png';

for i=1:numel(I)
  ifilename = fullfile(iFolder,I(i).name);
  J{i} = imread(ifilename);
  %K{i} = rgb2gray(J{i}); %Used for RGB Image
  L{i} = imresize(J{i}, [256 256]);
  M{i} = medfilt2(L{i});
  N{i} = water_shed(M{i}); 
  path ='C:\Users\Lenovo\Downloads\Covid-19\Matlab\Image\COVID\COVID';
  dir(path);
  imwrite(N{i},[path, num2str(fnum(i)) ext]);
end
%%
%%Process with Pneumonia Image (With Clustering)
clc;
clear all;
close all; 
iFolder='C:\Users\Lenovo\Downloads\Covid-19\Matlab\Tawshif\Viral Pneumonia';  
I=dir(fullfile(iFolder,'*.png'));

fnum = 1:1345;
ext = '.png';

for i=1:numel(I)
  ifilename = fullfile(iFolder,I(i).name);
  J{i} = imread(ifilename);
  %K{i} = rgb2gray(J{i}); %Used for RGB Image
  L{i} = imresize(J{i}, [256 256]);
  meanFilter = fspecial('average', [3 3]);    %Linear Spatial Filter, mean/average/box
  M{i} = imfilter(L{i}, meanFilter);        %Mean Filter
  
  %M{i} = medfilt2(L{i});
  N{i} = water_shed(M{i}); 
  path ='C:\Users\Lenovo\Downloads\Covid-19\Matlab\Image\Pneumonia\Pneumonia';
  dir(path);
  imwrite(N{i},[path, num2str(fnum(i)) ext]);
end
