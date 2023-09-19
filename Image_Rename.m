clc;
clear all;
close all; 
iFolder='E:\BDU\Research\Alzheimers\Matlab\ADNI\AD\55-60';  
I=dir(fullfile(iFolder,'*.png'));

fnum = 414:599;
ext = '.png';

for i=1:numel(I)
  ifilename = fullfile(iFolder,I(i).name);
  J{i} = imread(ifilename);
  path ='E:\BDU\Research\Alzheimers\Matlab\ADNI\AD\';
  dir(path);
  imwrite(J{i},[path, num2str(fnum(i)) ext]);
end
