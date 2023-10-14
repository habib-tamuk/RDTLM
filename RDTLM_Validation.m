clc;
clear all;
close all;
%imageDatastore load the image files to imds structure variable 
imds = imageDatastore('K:\Covid-19_Revision\chest_xray\train','IncludeSubfolders',true,'LabelSource','foldernames');
%splitEachLabel seperate the train and test imege from each category
[imdsTrain,imdsTest] = splitEachLabel(imds,0.8,'randomized');
%numel returns the number of elements 
%imdsTrain = imageDatastore('K:\Covid-19_Revision\chest_xray\train','IncludeSubfolders',true,'LabelSource','foldernames');
%imdsTest = imageDatastore('K:\Covid-19_Revision\chest_xray\test','IncludeSubfolders',true,'LabelSource','foldernames');
numTrainImages = numel(imdsTrain.Labels);
numTestImages = numel(imdsTest.Labels);
%create the depp cnn darknet19
net = darknet19;
%InputSize returns the input image size 
inSize = net.Layers(1).InputSize;
%analyzeNetwork(net);
%augmentedImageDatastore specify the desired image size 
augimdsTrain = augmentedImageDatastore(inSize(1:2),imdsTrain,'ColorPreprocessing', 'gray2rgb');
augimdsTest = augmentedImageDatastore(inSize(1:2),imdsTest,'ColorPreprocessing', 'gray2rgb');
%Extract the higher-level features by activations on the fully connected layer, 'conv16'
layer = 'avg1'; %conv16, conv17, conv18, conv19 and avg1
featuresTrain = activations(net,augimdsTrain,layer,'OutputAs','rows','ExecutionEnvironment','cpu');
featuresTest = activations(net,augimdsTest,layer,'OutputAs','rows','ExecutionEnvironment','cpu');
%Extract the class labels from the training and test data.
YTrain = imdsTrain.Labels;
YTest = imdsTest.Labels;

%https://www.mathworks.com/help/stats/fscmrmr.html
%Rank the predictors based on importance.
%idx represents the index of the features in decending order
%scores represents the feature importance value of the curresponding
%feature index
[idx,scores] = fscmrmr(featuresTrain,YTrain); 
figure;
bar(scores(idx));
xlabel('Predictor rank');
ylabel('Predictor importance score');
MRMRfeaturesTrain = featuresTrain(:,idx(1:400));
MRMRfeaturesTest = featuresTest(:,idx(1:400));

%multiclass support vector machine (SVM) applied to fit with label and features using fitcecoc
%fitcecoc Fit multiclass models for support vector machines or other classifiers
classifier = fitcecoc(MRMRfeaturesTrain,YTrain);

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
YPred = predict(classifier,MRMRfeaturesTest);

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

%%
%Covid CT image Test
Precision = confMat(1,1) / (confMat(1,1) + confMat(2,1));
Recall = confMat(1,1) / (confMat(1,1) + confMat(1,2));
Efficiency = (confMat(2,2))/(confMat(2,2)+ confMat(2,1));
NPV = (confMat(2,2))/(confMat(2,2)+ confMat(1,2));
F1score = (2 * Precision * Recall) / (Precision + Recall);
Accuracy = (confMat(1,1) + confMat(2,2)) / sum(confMat, 'all');
