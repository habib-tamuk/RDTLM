%%
%Individual Image Test Purpose
testImage = imread('C:\Users\Lenovo\Downloads\Covid-19\Matlab\Image\COVID\COVID2.png');
%img = imresize(testImage, [224 224]);
img = readAndPreprocessImage(testImage); 
imageFeatures = activations(net, img, layer,'OutputAs','rows','ExecutionEnvironment','cpu');
%label = predict(classifier.Trained{1,1}, imageFeatures); %for ensemple classifier
label = predict(classifier, imageFeatures);