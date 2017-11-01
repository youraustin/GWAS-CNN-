clear all

fprintf('Two Optiones of size of images will be designed:');
fprintf('~~> 16, 32, 64, 128, 256, 512, 1024 <~~')
fprintf('\n');
            
input('Please Choose the size of Images: ', 's')
u = ans;
Sizek = str2num(u);

for p=20:10:50
    for k=5:2:11
        for s=1:2:7
            parfor e=2:1:4
                
                DataSetName1= strcat('FinalFeatureSelection1024', '_p', num2str(p), '_e', num2str(e), '_seed', num2str(s), '_k', num2str(k));
                
                SetDatabase_Cantor(DataSetName1, Sizek);
                SetDatabase_Hilbert(DataSetName1, Sizek);
                SetDatabase_Row(DataSetName1, Sizek);
                SetDatabase_RowPrime(DataSetName1, Sizek);
                SetDatabase_Spiral(DataSetName1, Sizek);
                
            end
        end
        fprintf('********** No. %d  Dataset had been processed!! ********** \n', k);
        fprintf('\n');
    end
end

clear all
