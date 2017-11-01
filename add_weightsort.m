clear all

fprintf('Start add Weight sort!!');
fprintf('\n');
input('Input the weight limitation (value = 16, 32, 64, 128, 256, 512, 1024): ', 's')
w = ans;
v = str2num(w);
GenomeLength = v^2;

Data1 = load ('anxiom_relieff_GA_10_32.mat');

for Psize=20:10:50
    for Seedn=1:2:7
        for Knn=5:2:11
            for Ecount=2:1:4
                filename=strcat('D:\MATLAB\Deep Learning Neural Network Feature Selection\CNN Feature Selection\FeatureSelectionCNN\initialize imagilize SNP Sequence\old_dataset\', 'FinalFeatureSelection', num2str(GenomeLength), '_', 'p',num2str(Psize), '_', 'e',num2str(Ecount), '_', 'seed',num2str(Seedn), '_', 'k', num2str(Knn));
                load (filename);
                [row, column]=size(FinalFeatureSelection)
                FFSSort=zeros(1,column);
                for k=1:column
                    [a,b]=find(strcmp(Data1.GenoNameReliefF, FinalFeatureSelection(1, k)));
                    s=Data1.GenoWeightsSort(a,b);
                    FFSSort(1,k)=s;
                end
                filename1=strcat('D:\MATLAB\Deep Learning Neural Network Feature Selection\CNN Feature Selection\FeatureSelectionCNN\initialize imagilize SNP Sequence\', 'FinalFeatureSelection', num2str(GenomeLength), '_', 'p',num2str(Psize), '_', 'e',num2str(Ecount), '_', 'seed',num2str(Seedn), '_', 'k', num2str(Knn));
                save (filename1, 'FinalFeatureSelection', 'FFSSort', 'X_FS', 'Y_FS', '-V7.3');
            end
        end
    end
end

clear