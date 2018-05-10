clear all;
close all;
clc;

path = ('D:\Telkom University\semester 7\Bismillah 3.5\ALLAHUAKBAR\DATATESTING');

dataTes = dir(path);
allData = [];

for ii=3:length(dataTes)
    folderPath = strcat(path,'/',dataTes(ii).name);
    folder = dir(strcat(folderPath,'/*.pgm'));
    label = dataTes(ii).name;
    
    for jj=1:length(folder)
        imageName = folder(jj).name;
        imageFile = strcat(folderPath,'/',imageName);
        imageData.image = imread(imageFile);
        imageData.label = (label);
        allData = [allData; imageData];
    end
end
%%
% EkstraksiTesting2;

% for ii=14:14
%     imageTerang{ii} = allData(ii).image + 20;
%     imageGelap{ii} = allData(ii).image - 20;
% end