clear

fprintf('Two Optiones of size of images will be designed:');
fprintf('~~> 16, 32, 64, 128, 256, 512, 1024 <~~')
fprintf('\n');

input('Please Choose the size of Images: ', 's')
u = ans;

Sizek1 = str2num(u);

i=log2(Sizek1);
j=log2(256);

if i<=j
    for k=i:j
        DataSetName1= strcat('FinalFeatureSelectionFull', num2str(Sizek1));
        Sizek=(2^k);
        
        %InitializeImageFull_Cantor(DataSetName1, Sizek);
        InitializeImageFull_Hilbert(DataSetName1, Sizek);
        %InitializeImageFull_Row(DataSetName1, Sizek);
        %InitializeImageFull_RowPrime(DataSetName1, Sizek);
        %InitializeImageFull_Spiral(DataSetName1, Sizek);
        
    end
else
    Sizek=Sizek1;
    DataSetName1= strcat('FinalFeatureSelectionFull', num2str(Sizek1));
    
    InitializeImageFull_Cantor(DataSetName1, Sizek);
    InitializeImageFull_Hilbert(DataSetName1, Sizek);
    InitializeImageFull_Row(DataSetName1, Sizek);
    InitializeImageFull_RowPrime(DataSetName1, Sizek);
    InitializeImageFull_Spiral(DataSetName1, Sizek);
end

clear all