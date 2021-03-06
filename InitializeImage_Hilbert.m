function [ output_args ] = InitializeImage_Hilbert(DataSetName1, Sizek)
%INITIALIZEIMAGE Summary of this function goes here
%   Detailed explanation goes here

FullLimitation = Sizek;  %% 1024, 128, 64
%load ImageMap_Hilbert1024.mat;
mapname = strcat('ImageMap_Hilbert', num2str(Sizek));
load (mapname)
%load ImageMap_Hilbert64.mat;

load (DataSetName1);
DataSetName = strcat(char('Hilbert_GA_'), DataSetName1);
[row, column]=size(X_FS)
%% [row, column]=size(X)

myroot1 = strcat('E:\final_results\space\', num2str(Sizek), '\', DataSetName1, '\', 'Hilbert\', 'control');
if ~isdir(myroot1) 
    mkdir(myroot1);
end

myroot2 = strcat('E:\final_results\space\', num2str(Sizek), '\', DataSetName1, '\', 'Hilbert\', 'uncontrol');
if ~isdir(myroot2) 
    mkdir(myroot2);
end

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
    
    fprintf('********** No. %d  Hilbert Sample had been finished imagilization!! ********** \n', i);
    fprintf('\n');
    
    final_image=ImageRGB(matrixImage, locaX, locaY, column);
    switch (char(Y_FS(i,1)))
        case 'control' %% control
            imwrite(final_image, strcat(myroot1, '\', DataSetName, num2str(Sizek), '_', char(Y_FS(i,1)), num2str(i), '.png'));
        case 'uncontrol' %% uncontrol
            imwrite(final_image, strcat(myroot2, '\', DataSetName, num2str(Sizek), '_', char(Y_FS(i,1)), num2str(i), '.png'));
    end
    %% imwrite(final_image, strcat('D:\final results\space\', num2str(Sizek), '\', DataSetName, num2str(Sizek), '_', char(Y_FS(i,1)), num2str(i), '.png'));
    fprintf('Hilbert Outputting and Writing image has been over:  \n')
    fprintf('\n')
end



