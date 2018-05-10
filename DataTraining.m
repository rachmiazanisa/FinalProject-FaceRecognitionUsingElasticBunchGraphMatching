clear all; close all;clc;

path = ('D:\Telkom University\semester 7\Bismillah 3.5\ALLAHUAKBAR\DATATRAINING');
%load('Gabor.mat');
dataSet = dir(path);
allData = [];

for ii=3:length(dataSet)
    folderPath = strcat(path,'/',dataSet(ii).name);
    folder = dir(strcat(folderPath,'/*.pgm'));
    label = dataSet(ii).name;
    
    for jj=1:length(folder)
        imageName = folder(jj).name;
        imageFile = strcat(folderPath,'/',imageName);
        imageData.image = imread(imageFile);
        imageData.label = (label);
        allData= [allData; imageData];
    end
end
%%
% EkstraksiGabor2;
