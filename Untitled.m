clear 


load anxiom_relieff_GA_10_256.mat
X_FS = X;
Y_FS = Y;
FinalFeatureSelection = GenoNameReliefF;
FeatureChroName = ChroNameReliefF;
FeatureWeightSort = GenoWeightsSort;
save FinalFeatureSelectionFull256 X_FS Y_FS FinalFeatureSelection FeatureChroName FeatureWeightSort -v7.3
clear all

load anxiom_relieff_GA_10_128.mat
X_FS = X;
Y_FS = Y;
FinalFeatureSelection = GenoNameReliefF;
FeatureChroName = ChroNameReliefF;
FeatureWeightSort = GenoWeightsSort;
save FinalFeatureSelectionFull128 X_FS Y_FS FinalFeatureSelection FeatureChroName FeatureWeightSort -v7.3
clear all

load anxiom_relieff_GA_10_64.mat
X_FS = X;
Y_FS = Y;
FinalFeatureSelection = GenoNameReliefF;
FeatureChroName = ChroNameReliefF;
FeatureWeightSort = GenoWeightsSort;
save FinalFeatureSelectionFull64 X_FS Y_FS FinalFeatureSelection FeatureChroName FeatureWeightSort -v7.3
clear all

load anxiom_relieff_GA_10_32.mat
X_FS = X;
Y_FS = Y;
FinalFeatureSelection = GenoNameReliefF;
FeatureChroName = ChroNameReliefF;
FeatureWeightSort = GenoWeightsSort;
save FinalFeatureSelectionFull32 X_FS Y_FS FinalFeatureSelection FeatureChroName FeatureWeightSort -v7.3

%{
load anxiom_relieff_GA_10_16.mat
X_FS = X;
Y_FS = Y;
FinalFeatureSelection = GenoNameReliefF;
save anxiom_relieff_GA_10_16_2 X_FS Y_FS FinalFeatureSelection -v7.3
%}
