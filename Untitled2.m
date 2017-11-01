clear all

Data1 = load ('anxiom_relieff_GA_10_32a.mat');
Data2 = load ('anxiom_relieff_GA_10_512.mat');

[row, column]=size(Data1.GenoNameReliefF);

for k=1:column
    aaa(1,k) = Data1.GenoNameReliefF(1,k);
    [a,b]=find(strcmp(Data2.GenoNameReliefF, Data1.GenoNameReliefF(1, k)));
    bbb(1,k)=Data2.GenoWeightsSort(a,b);
    if bbb(1,k)==1020
        bbb(1,k)=1019;
    end
    if bbb(1,k)==1025
        bbb(1,k)=1021;
    end
    if bbb(1,k)==1027
        bbb(1,k)=1023;
    end
    if bbb(1,k)==1028
        bbb(1,k)=1024;
    end
end

bbb(1,943)=1022;
bbb(1,573)=1020;

X_a=Data1.X;
Y_a=Data1.Y;

filename=strcat('anxiomdata');
save (filename, 'aaa', 'bbb', 'X_a', 'Y_a', '-V7.3');

clear