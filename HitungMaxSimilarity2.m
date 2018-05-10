train = 50;
test = 1;
%%
for ii = 1:train
    for jj = 1:test
        [HasilSimilarity(jj,ii) idx(jj,ii)] = max(KumpulanSimilarity{jj,ii});
    end
end
%%
for ii=1:train
    for kk=1:test
        temp(ii,kk) = HasilSimilarity(kk,ii);
    end
end
%%
[sortSimilarity classSimilarity] = sort(temp,'descend');
%%

for ii = 1:test
    if (classSimilarity(1,ii) <= 5 & classSimilarity(1,ii) >=1)
        Prediksi(1,ii) = 1;
    elseif (classSimilarity(1,ii) <= 10 & classSimilarity(1,ii) >= 6) 
        Prediksi(1,ii) = 2;
    elseif (classSimilarity(1,ii) <= 15 & classSimilarity(1,ii) >= 11)
        Prediksi(1,ii) = 3;
    elseif (classSimilarity(1,ii) <= 20 & classSimilarity(1,ii) >= 16)
        Prediksi(1,ii) = 4;
    elseif (classSimilarity(1,ii) <= 25 & classSimilarity(1,ii) >= 21)
        Prediksi(1,ii) = 5;
    elseif (classSimilarity(1,ii) <= 30 & classSimilarity(1,ii) >= 26)
        Prediksi(1,ii) = 6;
    elseif (classSimilarity(1,ii) <= 35 & classSimilarity(1,ii) >= 31)
        Prediksi(1,ii) = 7;
    elseif (classSimilarity(1,ii) <= 40 & classSimilarity(1,ii) >= 36)
        Prediksi(1,ii) = 8;
    elseif (classSimilarity(1,ii) <= 45 & classSimilarity(1,ii) >= 41)
        Prediksi(1,ii) = 9;
    elseif (classSimilarity(1,ii) <= 50 & classSimilarity(1,ii) >= 46)
        Prediksi(1,ii) = 10;
    end
end
%%
classAsli = [1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10];%pose
% classAsli = [1];%expresssion
cocok = 0;
for ii =1 : test
    if(Prediksi(1,ii) == classAsli(1,ii))
        cocok = cocok + 1;
    end
end

akurasi = (cocok/test)*100


