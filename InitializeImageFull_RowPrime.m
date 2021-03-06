function [ output_args ] = InitializeImage_RowPrime(DataSetName1, Sizek)
%INITIALIZEIMAGE Summary of this function goes here
%   Detailed explanation goes here

FullLimitation = Sizek;
%load ImageMap_RowPrime1024.mat;
mapname = strcat('ImageMap_RowPrime', num2str(Sizek));
load (mapname);
%load ImageMap_RowPrime64.mat;

load (DataSetName1);
DataSetName = strcat(char('RowPrime_GA_'), DataSetName1);
[row, column]=size(X_FS)

myroot1 = strcat('E:\', num2str(Sizek), '\', 'Training\', 'RowPrime\', 'train_ctrl');
if ~isdir(myroot1) 
    mkdir(myroot1);
end

myroot2 = strcat('E:\', num2str(Sizek), '\', 'Training\', 'RowPrime\', 'train_unctrl');
if ~isdir(myroot2) 
    mkdir(myroot2);
end
%% [row, column]=size(X)

for k=1:column
    %% [u,v]=find(strcmp(ImageMap, GenoNameReliefF(1,k)));
    [u,v]=find(strcmp(ImageMap, FinalFeatureSelection(1, k)));
    locaX(k)=u;
    locaY(k)=v;
end

for i=1:row
    
    matrixImage=zeros(FullLimitation,FullLimitation);
    arrayImage=X_FS(i,:);
    %%arrayImage=X(i,:); 
   
    for k=1:column
        %% [u,v]=find(strcmp(ImageMap, GenoNameReliefF(1,k)));
        matrixImage(locaX(k), locaY(k)) = (arrayImage(1, k)+1)*20;
    end
    
    fprintf('********** No. %d  RowPrime Sample had been finished imagilization!! ********** \n', i);
    fprintf('\n');
    
    final_image=ImageRGB(matrixImage, locaX, locaY, column);
    switch (char(Y_FS(i,1)))
        case 'control' %% control
            imwrite(final_image, strcat(myroot1, '\', DataSetName, '_', num2str(Sizek), '_', char(Y_FS(i,1)), num2str(i), '.png'));
        case 'uncontrol' %% uncontrol
            imwrite(final_image, strcat(myroot2, '\', DataSetName, '_', num2str(Sizek), '_', char(Y_FS(i,1)), num2str(i), '.png'));
    end
    %% imwrite(final_image, strcat('D:\final results\space\', num2str(Sizek), '\', DataSetName, num2str(Sizek), '_', char(Y_FS(i,1)), num2str(i), '.png'));
    fprintf('RowPrime Outputting and Writing image has been over:  \n')
    fprintf('\n')
end



