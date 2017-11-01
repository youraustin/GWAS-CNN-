clear

fprintf('Two Optiones of size of images will be designed:');
fprintf('~~> 16, 32, 64, 128, 256, 512, 1024 <~~')
fprintf('\n');

input('Please Choose the size of Images: ', 's')
u = ans;

SizeLimitation = str2num(u);

for p=20:10:50
    for k=5:2:11
        for s=1:2:7
            parfor e=2:1:4
                
                DataSetName= strcat('FinalFeatureSelection1024', '_p', num2str(p), '_e', num2str(e), '_seed', num2str(s), '_k', num2str(k));
                %load (DataSetName);
                %[row, column]=size(X_FS);
                
                %if (SizeLimitation*SizeLimitation) >= column
                    
                    %InitializeImage_Cantor_Filling( SizeLimitation, X_FS, Y_FS, row, column, DataSetName);
                    InitializeImage_Cantor_Filling( SizeLimitation, DataSetName);
                    InitializeImage_Hilbert_Filling( SizeLimitation, DataSetName);
                    InitializeImage_RowPrime_Filling( SizeLimitation, DataSetName);
                    InitializeImage_Row_Filling( SizeLimitation, DataSetName);
                    InitializeImage_Spiral_Filling( SizeLimitation, DataSetName);
                    
                %end
                
            end
        end
        fprintf('********** No. %d  Dataset had been processed!! ********** \n', k);
        fprintf('\n');
    end
end

clear all