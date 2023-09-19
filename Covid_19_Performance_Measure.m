% clc;
% clear all;
% close all;

%confMat = 0;
%confMat = [1 2 3; 4 5 6; 7 8 9];

classsificationAccuracy = (confMat(1,1) + confMat(2,2) + confMat(3,3)) / sum(confMat, 'all');

covid1Precision = confMat(1,1) / (confMat(1,1) + confMat(2,1)+confMat(3,1));
covid3Recall= confMat(1,1) / (confMat(1,1) + confMat(1,2)+confMat(1,3));
covid4Efficiency = (confMat(2,2)+confMat(2,3)+confMat(3,2)+confMat(3,3))/(confMat(2,2)+confMat(2,3)+confMat(3,2)+confMat(3,3)+ confMat(2,1)+confMat(3,1));
covid2NPV = (confMat(2,2)+confMat(2,3)+confMat(3,2)+confMat(3,3))/(confMat(2,2)+confMat(2,3)+confMat(3,2)+confMat(3,3)+ confMat(1,2)+confMat(1,3));
covid5F1score = (2 * covid1Precision * covid3Recall) / (covid1Precision + covid3Recall);
covid6Accuracy = (confMat(1,1) + confMat(2,2) + confMat(2,3) + confMat(3,2) + confMat(3,3)) / sum(confMat, 'all');

healthy1Precision = confMat(2,2) / (confMat(1,2) + confMat(2,2)+confMat(3,2));
healthy3Recall= confMat(2,2) / (confMat(2,1) + confMat(2,2)+confMat(2,3));
healthy4Efficiency = (confMat(1,1)+confMat(1,3)+confMat(3,1)+confMat(3,3))/(confMat(1,1)+confMat(1,3)+confMat(3,1)+confMat(3,3)+ confMat(1,2)+confMat(3,2));
healthy2NPV = (confMat(1,1)+confMat(1,3)+confMat(3,1)+confMat(3,3))/(confMat(1,1)+confMat(1,3)+confMat(3,1)+confMat(3,3)+ confMat(2,1)+confMat(2,3));
healthy5F1score = (2 * healthy1Precision * healthy3Recall) / (healthy1Precision + healthy3Recall);
healthy6Accuracy = (confMat(2,2) + confMat(1,1) + confMat(1,3) + confMat(3,1) + confMat(3,3)) / sum(confMat, 'all');

pneumonia1Precision = confMat(3,3) / (confMat(1,3) + confMat(2,3)+confMat(3,3));
pneumonia3Recall= confMat(3,3) / (confMat(3,1) + confMat(3,2)+confMat(3,3));
pneumonia4Efficiency = (confMat(1,1)+confMat(1,2)+confMat(2,1)+confMat(2,2))/(confMat(1,1)+confMat(1,2)+confMat(2,1)+confMat(2,2)+ confMat(1,3)+confMat(2,3));
pneumonia2NPV = (confMat(1,1)+confMat(1,2)+confMat(2,1)+confMat(2,2))/(confMat(1,1)+confMat(1,2)+confMat(2,1)+confMat(2,2)+ confMat(3,1)+confMat(3,2));
pneumonia5F1score = (2 * pneumonia1Precision * pneumonia3Recall) / (pneumonia1Precision + pneumonia3Recall);
pneumonia6Accuracy = (confMat(3,3) + confMat(1,1) + confMat(1,2) +confMat(2,1) + confMat(2,2)) / sum(confMat, 'all');

avgAccuracy = (covid6Accuracy + healthy6Accuracy + pneumonia6Accuracy) / 3;

c1FDR = 1 - covid1Precision;
c2FOR = 1 - covid2NPV;
c3FNR = 1 - covid3Recall;
c4FPR = 1 - covid4Efficiency;
c5Error = 1 - covid6Accuracy;

h1FDR = 1 - healthy1Precision;
h2FOR = 1 - healthy2NPV;
h3FNR = 1 - healthy3Recall;
h4FPR = 1 - healthy4Efficiency;
h5Error = 1 - healthy6Accuracy;

p1FDR = 1 - pneumonia1Precision;
p2FOR = 1 - pneumonia2NPV;
p3FNR = 1 - pneumonia3Recall;
p4FPR = 1 - pneumonia4Efficiency;
p5Error = 1 - pneumonia6Accuracy;
avgError = (c5Error+h5Error+p5Error)/3;
totalImage = sum(confMat, 'all');