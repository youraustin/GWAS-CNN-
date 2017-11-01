function [ output_args ] = InitializeImage_Row_full( X, Y, row, column, DataSetName, GenoNameReliefF)
%INITIALIZEIMAGE4 Summary of this function goes here
%   Detailed explanation goes here

rank=log2(column);
n=ceil(rank/2);
FullLimitation=(2^n);

myroot1 = strcat('E:\final_results\full\', num2str(FullLimitation), '\', 'Row\', 'train_ctrl\');
if ~isdir(myroot1)
    mkdir(myroot1);
end

myroot2 = strcat('E:\final_results\full\', num2str(FullLimitation), '\', 'Row\', 'train_unctrl\');
if ~isdir(myroot2)
    mkdir(myroot2);
end

for u=1:FullLimitation
    for v=1:FullLimitation
        if ((u-1)*FullLimitation+v)<= column
            ImageMap(u,v) = GenoNameReliefF(1,(u-1)*FullLimitation+v);  %% vector to matrix
        else
            ImageMap(u,v) = {'none'};
        end
    end
end
filename = ['ImageMap_Row', num2str(FullLimitation)];
save (filename, 'ImageMap', '-v7.3');

fprintf('Row ImageMap file has been saved');
fprintf('\n');


for i=1:row
    % visualization based full matrix
    matrixImage=zeros(FullLimitation,FullLimitation);
    arrayImage=X(i,:);
    for u=1:FullLimitation
        for v=1:FullLimitation
            if ((u-1)*FullLimitation+v)<= column
                matrixImage(u,v)=((arrayImage(1,(u-1)*FullLimitation+v)+1)*20);  %% vector to matrix
            else
                matrixImage(u,v)= 0;
            end
        end
    end
    
    fprintf('********** No. %d  Row Sample had been finished imagilization!! ********** \n', i)
    fprintf('\n')
    final_image=ImageRGBFilling(matrixImage);
    %%final_image=mat2gray(matrixImage);
    %% figure;
    %% imshow(final_image)
    %% saveas(gcf, strcat('C:\MATLAB\Deep Learning Neural Network Feature Selection\CNN Feature Selection\FeatureSelectionCNN\initialize imagilize SNP Sequence\image\axiom_corect', num2str(column), '.fig'), 'fig')
    switch (char(Y(i,1)))
        case 'control' %% control
            imwrite(final_image, strcat(myroot1, DataSetName, '_Row_full_', char(Y(i,1)), num2str(i), '.png'));
        case 'uncontrol' %% uncontrol
            imwrite(final_image, strcat(myroot2, DataSetName, '_Row_full_', char(Y(i,1)), num2str(i), '.png'));
    end
    
    fprintf('Row Outputting and Writing image has been over:  \n')
    fprintf('\n')
end

end



