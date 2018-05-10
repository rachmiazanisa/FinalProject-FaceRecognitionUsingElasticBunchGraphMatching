% lamda = [4 4*sqrt(2) 8 8*sqrt(2) 16];
% theta = [0 22.5 45 67.5 90 112.5 135 157.5];
% lamda = [4 8 16 32];
% theta = [0 45 90 135];
% 
% theta = [0 45 90 157.5];
% lamda = [4 8*sqrt(2) 16];

theta = [0 45 90 112.5 157.5];
lamda = [4 8*sqrt(2) 16];
g = gabor(lamda,theta);

for ii=1:length(g);
    kernel{ii,1} = g(1,ii).SpatialKernel(32:50,32:50);
end
%%
% kernel = load('kernelgabor.mat','kernel');
% kernel = kernel.kernel;
% saveX = {};
% saveY = {};
saveX = load('koorX 25titik 1-40 train theta optimal akhir.mat','saveX');
saveX = saveX.saveX;
saveY = load('koorY 25titik 1-40 train theta optimal akhir.mat','saveY');
saveY = saveY.saveY;
%%
% a = 46;
for nn=1:50
    image = allData(nn).image;
    disp(['data ',num2str(nn)])
    image = padarray(image,[20 20]);
    hasil = {};
%     im = imagesc(image);
% 
%     set(0,'CurrentFigure',1);
%     ax = gca;
%     [x, y] = getpts(ax);
%     saveX{nn} = x;
%     saveY{nn} = y;
    x = saveX{nn};
    y = saveY{nn};
    x = round(x);y=round(y);
    Ikonv = {};
    for jet=1:length(kernel)
        for ii=1:size(x,1)
           % Parameter Setting
           % ngambil image untuk konvolusi
           cx = y(ii)-20;cy=x(ii)-20;

           disp( [num2str(cx), ', ', num2str(y(ii)+20), ', ', num2str(cy), ', ', num2str(x(ii)+20)])
           Ikonv{ii} = image(cx:y(ii)+20, cy:x(ii)+20);
           %proses konvolusi
           fixGW = conv2(Ikonv{ii},kernel{jet,1},'valid');
           hasil{jet}{ii}=fixGW;
        end
    end
    ekstraksi{nn,1} = hasil; %ekstraksi
    ekstraksi{nn,2} = allData(nn).label; %ekstraksi
%     a = a+1;
end