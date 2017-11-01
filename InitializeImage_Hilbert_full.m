function [ output_args ] = InitializeImage_Hilbert_full( imageX, imageY, X, Y, n, column, row, DataSetName, GenoNameReliefF )
%INITIALIZEIMAGE Summary of this function goes here
%   Detailed explanation goes here

FullLimitation = (2^n);

for i=1:(2^(n*2))
    if i<=column
        ImageMap(imageX(1,i), imageY(1,i)) = (GenoNameReliefF(1, i));
    else %% the pixel value of matrixImage is 0 if it is blank
        ImageMap(imageX(1,i), imageY(1,i)) = {'none'};
    end
end

filename = ['ImageMap_Hilbert', num2str(FullLimitation)];
save (filename, 'ImageMap', '-v7.3');
fprintf('Hilbert ImageMap file has been saved');
fprintf('\n');

myroot1 = strcat('E:\final_results\full\', num2str(FullLimitation), '\', 'Hilbert\', 'train_ctrl\');
if ~isdir(myroot1)
    mkdir(myroot1);
end

myroot2 = strcat('E:\final_results\full\', num2str(FullLimitation), '\', 'Hilbert\', 'train_unctrl\');
if ~isdir(myroot2)
    mkdir(myroot2);
end

for k=1:row
    for i=1:(2^(n*2))
        if i<=column
            matrixImage(imageX(1,i), imageY(1,i))= ((X(k, i)+1) * 20); %% input the pixel value into the matrixImage
        else %% the pixel value of matrixImage is 0 if it is blank
            matrixImage(imageX(1,i), imageY(1,i))= 0;
        end
    end
    
    fprintf('********** No. %d  Hilbert Sample had been finished imagilization!! ********** \n', k)
    fprintf('\n')
    
    RowZeroNum=0;
    for h=1:(2^n)
        if matrixImage(:,h) == 0
            RowZeroNum=RowZeroNum+1;
        end
    end
    
    ColumnZeroNum=0;
    for h=1:(2^n)
        if matrixImage(h,:) == 0
            ColumnZeroNum=ColumnZeroNum+1;
        end
    end
    
    matrixImageOptimization=zeros(FullLimitation,FullLimitation);
    if ((2^n) < FullLimitation)
        for q=1:(2^n)
            for p=1:(2^n)
                matrixImageOptimization(p,q) = matrixImage(p,q);
            end
        end
        
        final_image_optimization=ImageRGB(matrixImageOptimization);
        %%final_image_optimization=mat2gray(matrixImageOptimization);
        switch (char(Y(k,1)))
            case 'control' %% control
                imwrite(final_image_optimization, strcat(myroot1, DataSetName, '_Hilbert_FillSpace_', char(Y(k,1)), '_', num2str(k), '.png'));
            case 'uncontrol' %% uncontrol
                imwrite(final_image_optimization, strcat(myroot2, DataSetName, '_Hilbert_FillSpace_', char(Y(k,1)), '_', num2str(k), '.png'));
        end
        
        fprintf('Hilbert Outputting and Writing Optimization image has been over:  \n')
        fprintf('\n')
        
    else
        if ((RowZeroNum ~= 0) || (ColumnZeroNum ~=0))
            if ((2^n - RowZeroNum)<FullLimitation)
                for q=1:FullLimitation
                    for p=1:FullLimitation
                        matrixImageOptimization(p,q) = matrixImage(p,q);
                    end
                end
                
                final_image_optimization=ImageRGB(matrixImageOptimization);
                %%final_image_optimization=mat2gray(matrixImageOptimization);
                switch (char(Y(k,1)))
                    case 'control' %% control
                        imwrite(final_image_optimization, strcat(myroot1, DataSetName, '_Hilbert_FillSpace_', char(Y(k,1)), '_', num2str(k), '.png'));
                    case 'uncontrol' %% uncontrol
                        imwrite(final_image_optimization, strcat(myroot2, DataSetName, '_Hilbert_FillSpace_', char(Y(k,1)), '_', num2str(k), '.png'));
                end
                
                fprintf('Hilbert Outputting and Writing Optimization image has been over:  \n')
                fprintf('\n')
            end
        end
        
        final_image=ImageRGBFilling(matrixImage);
        %%final_image=mat2gray(matrixImage);
        %% figure;
        %% imshow(final_image)
        %% saveas(gcf, strcat('C:\MATLAB\Deep Learning Neural Network Feature Selection\CNN Feature Selection\FeatureSelectionCNN\initialize imagilize SNP Sequence\image\axiom_corect', num2str(column), '.fig'), 'fig')
        switch (char(Y(k,1)))
            case 'control' %% control
                imwrite(final_image, strcat(myroot1, DataSetName, '_Hilbert_full_', char(Y(k,1)), num2str(k), '.png'));
            case 'uncontrol' %% uncontrol
                imwrite(final_image, strcat(myroot2, DataSetName, '_Hilbert_full_', char(Y(k,1)), num2str(k), '.png'));
        end

        fprintf('Hilbert Outputting and Writing image has been over:  \n')
        fprintf('\n')
        
    end
    
end

end
