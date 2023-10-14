%%https://www.mathworks.com/help/deeplearning/ug/extract-image-features-using-pretrained-network.html
clc;
clear all;
close all;
%imageDatastore load the image files to imds structure variable 
imds = imageDatastore('C:\Users\Lenovo\Downloads\Covid-19\Matlab\Image','IncludeSubfolders',true,'LabelSource','foldernames');
%splitEachLabel seperate the train and test imege from each category
[imdsTrain,imdsTest] = splitEachLabel(imds,0.8,'randomized');
%numel returns the number of elements 
numTrainImages = numel(imdsTrain.Labels);
numTestImages = numel(imdsTest.Labels);
%create the depp cnn vgg16
net = vgg16;
%InputSize returns the input image size 
inSize = net.Layers(1).InputSize;
%analyzeNetwork(net);
%augmentedImageDatastore specify the desired image size 
augimdsTrain = augmentedImageDatastore(inSize(1:2),imdsTrain,'ColorPreprocessing', 'gray2rgb');
augimdsTest = augmentedImageDatastore(inSize(1:2),imdsTest,'ColorPreprocessing', 'gray2rgb');
%Extract the higher-level features by activations on the fully connected layer, 'fc6'
layer = 'fc6'; %fc6, fc7 and fc8
featuresTrain = activations(net,augimdsTrain,layer,'OutputAs','rows','ExecutionEnvironment','cpu');
featuresTest = activations(net,augimdsTest,layer,'OutputAs','rows','ExecutionEnvironment','cpu');
%Extract the class labels from the training and test data.
YTrain = imdsTrain.Labels;
YTest = imdsTest.Labels;
%multiclass support vector machine (SVM) applied to fit with label and features using fitcecoc
%fitcecoc Fit multiclass models for support vector machines or other classifiers
classifier = fitcecoc(featuresTrain,YTrain);

%Decision tree(DT) applied to fit with label and features using fitctree
%fitctree Fit multiclass models for sDecision tree classifiers
%classifier = fitctree(featuresTrain,YTrain);
%classifier = fitcnn(featuresTrain,YTrain);
%opts = struct('Optimizer','bayesopt','ShowPlots',true,...
%    'AcquisitionFunctionName','expected-improvement-plus');
% classifier = fitcecoc(featuresTrain,YTrain,'Learners', t, 'Coding', 'onevsall', 'ObservationsIn', 'rows',...
%     'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts);
% classifier = fitcsvm(featuresTrain,YTrain,'Standardize',true,'KernelFunction','rbf',...
%     'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts);
%classifier = fitcknn(featuresTrain,YTrain,'NSMethod','exhaustive',...
%    'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',opts);
%NSMethod may be 'kdtree' or 'exhaustive' ....
% kdtree is valid for 'euclidean', 'cityblock', 'minkowski', 'chebychev'
%distance may be 'euclidean', 'cityblock', 'minkowski', 'chebychev', 'spearman' 
%'correlation', 'cosine', 'hamming', 'jaccard', 'mahalanobis', 'seuclidean'

%classifier = fitensemble(featuresTrain, YTrain,'TotalBoost',100,'Tree','Holdout',0.5);
%AdaBoostM1, AdaBoostM2,Subspace,LPBoost,RUSBoost,TotalBoost are also used for fitensemble  
%kloss = kfoldLoss(classifier,'mode','cumulative'); % Bag, AdaBoostM2, Subspace, RUSBoost,

%classifier = mnrfit(featuresTrain,YTrain,'model','ordinal'); %nominal, ordinal, hierarchical
%mnrfit used for Multinomial logistic regression

%Classify the test images using the features extracted
YPred = predict(classifier,featuresTest);

%Classify the test images using the features extracted for ensemble
%YPred = predict(classifier.Trained{1,1},featuresTest);

%Calculate the classification accuracy on the test set
classAccuracy = mean(YPred == YTest);

[confMat, category]= confusionmat(YPred, YTest);
%confMat = bsxfun(@rdivide,confMat,sum(confMat,2));
plotconfusion(YTest,YPred);
%confusionchart(confMat, classifier.ClassNames); %category
fig = figure;
cm = confusionchart(YPred, YTest,'RowSummary','row-normalized','ColumnSummary','column-normalized');

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
totalTestImage = countcats(YTest);
totalTrainImage = countcats(YTrain);
