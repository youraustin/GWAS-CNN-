function [ output_args ] = ImageRGBVaries_Cantor( DataSetName1, Sizek )
%IMAGERGBVARIES_CANTOR Summary of this function goes here
%   Detailed explanation goes here

FullLimitation = Sizek;
%load ImageMap_Cantor1024.mat;
mapname = strcat('ImageMap_Cantor', num2str(Sizek));
load (mapname);
%load ImageMap_Cantor64.mat;


load (DataSetName1);
DataSetName = strcat(char('Cantor_GA_'), DataSetName1);
%%[row, column]=size(X)
[row, column]=size(X_FS)

myroot1 = strcat('E:\final_results\space_RGB\', num2str(Sizek), '\', DataSetName1, '\', 'Cantor\', 'control');
if ~isdir(myroot1)
    mkdir(myroot1);
end

myroot2 = strcat('E:\final_results\space_RGB\', num2str(Sizek), '\', DataSetName1, '\', 'Cantor\', 'uncontrol');
if ~isdir(myroot2)
    mkdir(myroot2);
end

locaX=zeros(1,column);
locaY=zeros(1,column);

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
  
    fprintf('********** No. %d  Cantor Sample had been finished imagilization!! ********** \n', i);
    fprintf('\n');
    
    lab=char(Y_FS(i,1));
    switch (char(Y_FS(i,1)))
        case 'control' %% control
            for vc=1:5
                final_image=ImageRGBVaries(matrixImage, lab, vc, locaX, locaY, column);
                imwrite(final_image, strcat(myroot1, '\', DataSetName, num2str(Sizek), '_', num2str(vc), '_', char(Y_FS(i,1)), num2str(i), '.png'));
            end
        case 'uncontrol' %% uncontrol
            for vc=1:3
                final_image=ImageRGBVaries(matrixImage, lab, vc, locaX, locaY, column);
                imwrite(final_image, strcat(myroot2, '\', DataSetName, num2str(Sizek), '_', num2str(vc), '_', char(Y_FS(i,1)), num2str(i), '.png'));
            end
    end
    
    %% imwrite(final_image, strcat('D:\final results\space\', num2str(Sizek), '\', DataSetName, num2str(Sizek), '_', char(Y_FS(i,1)), num2str(i), '.png'));
    fprintf('Cantor Outputting and Writing image has been over:  \n')
    fprintf('\n')
end
