clear all;
clc;
close all;
tic
% lamda = [4 4*sqrt(2) 8 8*sqrt(2) 16];
% theta = [0 22.5 45 67.5 90 112.5 135 157.5];
% lamda = [4 8 16 32];
% theta = [0 45 90 135];
theta = [0 45 90 157.5];
lamda = [4 8*sqrt(2) 16];
kernel = 12;
titik = 1;
testing = load('EksraksiIllumination 15 titik.mat','ekstraksi');
testing = testing.ekstraksi;
training = load('Train 25titik 10Label Theta Optimal Akhir.mat','ekstraksi');
training = training.ekstraksi;
%%
% training = train;
% testing = test;
%classification
%phi
%%
for tt =1 :1
    ekstraksiTest = testing{tt,1};
    for ee=1:length(training)
        ekstraksiTrain = training{ee,1};
for ii = 1:kernel
    for jj = 1:titik
        aimagTrain{1,ii}{1,jj} = imag(ekstraksiTrain{1,ii}{1,jj});
        arealTrain{1,ii}{1,jj} = real(ekstraksiTrain{1,ii}{1,jj});
        for a=1:23
            for b=1:23
                if arealTrain{1,ii}{1,jj}(a,b) > 0
                    phiTrain{1,ii}{1,jj}(a,b) = atan(aimagTrain{1,ii}{1,jj}(a,b)/arealTrain{1,ii}{1,jj}(a,b))*180/pi;
                elseif arealTrain{1,ii}{1,jj}(a,b) < 0
                    phiTrain{1,ii}{1,jj}(a,b) = pi + atan(aimagTrain{1,ii}{1,jj}(a,b)/arealTrain{1,ii}{1,jj}(a,b))*180/pi;
                elseif (arealTrain{1,ii}{1,jj}(a,b) == 0) & (aimagTrain{1,ii}{1,jj}(a,b) >= 0)
                    phiTrain{1,ii}{1,jj}(a,b) = pi/2;
                else
                    phiTrain{1,ii}{1,jj}(a,b) = -(pi/2);
%                     ii
%                     jj
                end
            end
        end
    end
end
%%
%find imaginer & real value Test
%find phi for every Jet
for ii = 1:kernel
    for jj = 1:titik
        aimagTest{1,ii}{1,jj} = imag(ekstraksiTest{1,ii}{1,jj});
        arealTest{1,ii}{1,jj} = real(ekstraksiTest{1,ii}{1,jj});
        for a=1:23
            for b=1:23
                if arealTest{1,ii}{1,jj}(a,b) > 0
                    phiTest{1,ii}{1,jj}(a,b) = atan(aimagTest{1,ii}{1,jj}(a,b)/arealTest{1,ii}{1,jj}(a,b))*180/pi;
                elseif arealTest{1,ii}{1,jj}(a,b) < 0
                    phiTest{1,ii}{1,jj}(a,b) = pi + atan(aimagTest{1,ii}{1,jj}(a,b)/arealTest{1,ii}{1,jj}(a,b))*180/pi;
                elseif (arealTest{1,ii}{1,jj}(a,b) == 0) & (aimagTest{1,ii}{1,jj}(a,b) >= 0)
                    phiTest{1,ii}{1,jj}(a,b) = pi/2;
                else
                    phiTest{1,ii}{1,jj}(a,b) = -(pi/2);
%                     ii
%                     jj
                end
            end
        end
    end
end
%%
k=1;
for i=1:length(lamda)
    for j=1:length(theta)
        kx(1,k) = ((2*pi)*cos(theta(1,j)))/lamda(1,i);
        ky(1,k) = ((2*pi)*sin(theta(1,j)))/lamda(1,i);
        k=k+1;
    end
end
%%
%hitung jetTrain dan jetTest
for ii=1:kernel
    for jj=1:titik
        aTrain{1,ii}{1,jj} = sqrt(real(ekstraksiTrain{1,ii}{1,jj}).^2 + imag(ekstraksiTrain{1,ii}{1,jj}).^2);
        aTest{1,ii}{1,jj} = sqrt(real(ekstraksiTest{1,ii}{1,jj}).^2 + imag(ekstraksiTest{1,ii}{1,jj}).^2);
    end
end
%%
for i=1:kernel
   for j=1:titik
          xy{1,i} = sum(sum((aTrain{1,i}{1,j}.*aTest{1,i}{1,j}).*kx(1,i).*ky(1,i)));
          yy{1,i} = sum(sum((aTrain{1,i}{1,j}.*aTest{1,i}{1,j}).*ky(1,i).*ky(1,i)));
          yx{1,i} = sum(sum((aTrain{1,i}{1,j}.*aTest{1,i}{1,j}).*ky(1,i).*kx(1,i)));
          xx{1,i} = sum(sum((aTrain{1,i}{1,j}.*aTest{1,i}{1,j}).*kx(1,i).*kx(1,i)));
   end
end
%%
%find phi every kernel
for i=1:kernel
   for j=1:titik
          phix{1,i} = sum(sum(((aTrain{1,i}{1,j}).*(aTest{1,i}{1,j})).*kx(1,i).*((phiTrain{1,i}{1,j})-(phiTest{1,i}{1,j}))));
          phiy{1,i} = sum(sum(((aTrain{1,i}{1,j}).*(aTest{1,i}{1,j})).*ky(1,i).*((phiTrain{1,i}{1,j})-(phiTest{1,i}{1,j}))));
   end
end
%%
%find dx and dy value
for jj=1:kernel
   for j = 1:titik
        dx{1,jj} = (1./(xx{1,jj}.*yy{1,jj}-xy{1,jj}.*yx{1,jj})).*(yy{1,jj}.*phix{1,jj}+(-yx{1,jj}).*phiy{1,jj});
        dy{1,jj} = (1./(xx{1,jj}.*yy{1,jj}-xy{1,jj}.*yx{1,jj})).*(xy{1,jj}.*phix{1,jj}+(-xx{1,jj}).*phiy{1,jj});
        if isnan(dy{1,jj}) 
            dy{1,jj} = 0;
        end
        if isnan(dx{1,jj})
            dx{1,jj} = 0;
        end
        
        if dy{1,jj} == Inf
            dy{1,jj} = 1;
        end
        if dx{1,jj} == Inf
            dx{1,jj} = 1;
        end
        if dy{1,jj} == -Inf
            dy{1,jj} = -1;
        end
        if dx{1,jj} == -Inf
            dx{1,jj} = -1;
        end
   end
end
%%
pembilang = {};hasilpembilang={};nilaipembilang = [];
for ii=1:kernel
    for jj=1:titik
        for kk = 1:23
            for mm = 1:23
                kotak{1,ii}{1,jj}(kk,mm)= 1 - 0.5 *( phiTrain{1,ii}{1,jj}(kk,mm) - phiTest{1,ii}{1,jj}(kk,mm) - (dx{1,ii}*kx(1,ii)+ dy{1,ii}*ky(1,ii)) )^2;
                pembilang{1,ii}{1,jj}(kk,mm) = (aTrain{1,ii}{1,jj}(kk,mm)*aTest{1,ii}{1,jj}(kk,mm)*kotak{1,ii}{1,jj}(kk,mm));
            end 
        end
        pembilang{1,ii}{1,jj} = sum(sum(pembilang{1,ii}{1,jj}));
    end
    hasilpembilang{1,ii} = cell2mat(pembilang{1,ii});
    nilaipembilang(1,ii) = sum(hasilpembilang{1,ii});
end
%%
temp = {};
aj1 = {};
for ii = 1:kernel
    for jj = 1:titik
        temp = ((aTrain{1,ii}{1,jj}.^2));
        aj1{1,ii}{1,jj} = temp;
    end
    aj1{1,ii} = sum(sum(aj1{1,ii}{1,jj}));
end
%%
aj2 = {};
for ii = 1:kernel
    for jj = 1:titik
        temp = ((aTest{1,ii}{1,jj}.^2));
        aj2{1,ii}{1,jj} = temp;
    end
    aj2{1,ii} = sum(sum(aj2{1,ii}{1,jj}));
end
%%
penyebut = {};
for ii =1:kernel
    penyebut{1,ii} = sqrt(aj1{1,ii} * aj2{1,ii});
    
end
nilaipenyebut = cell2mat(penyebut);
%%
Similarity = [];
for ii=1:kernel
    Similarity(1,ii) = (nilaipembilang(1,ii)/nilaipenyebut(1,ii));
end
    KumpulanSimilarity{tt,ee} = Similarity;
    end
end
HitungMaxSimilarity2
toc
runningtime = toc