clear

fprintf('Two Optiones of size of images will be designed:');
fprintf('~~> 16, 32, 64, 128, 256, 512, 1024 <~~')
fprintf('\n');

input('Please Choose the size of Images: ', 's')
temp = ans;

Sizek = str2num(temp);

for p=20:10:50
    for k=5:2:11
        for s=1:2:7
            parfor e=2:1:4
                DataSetName1= strcat('FinalFeatureSelection1024', '_p', num2str(p), '_e', num2str(e), '_seed', num2str(s), '_k', num2str(k));
                
                InitializeImage_Cantor(DataSetName1, Sizek);
                InitializeImage_Hilbert(DataSetName1, Sizek);
                InitializeImage_Row(DataSetName1, Sizek);
                InitializeImage_RowPrime(DataSetName1, Sizek);
                InitializeImage_Spiral(DataSetName1, Sizek);
                
            end
        end
    end
end

clear all