clear all

Data1 = load ('anxiomdata');

[row, column]=size(Data1.aaa);

GenoNameReliefF=Data1.aaa;
GenoWeightsSort=Data1.bbb;

X_FS=Data1.X_a;
Y_FS=Data1.Y_a;

filename=strcat('anxiom_relieff_GA_10_32');
save (filename, 'GenoNameReliefF', 'GenoWeightsSort', 'X_FS', 'Y_FS', '-V7.3');

clear