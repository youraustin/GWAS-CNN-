function [ output_args ] = InitializeImage_Hilbert_filling_due( imageX, imageY, n, DataSetName )
%INITIALIZEIMAGE Summary of this function goes here
%   Detailed explanation goes here

load (DataSetName);
[row, column]=size(X_FS);

FullLimitation=(2^n);
Sizek=n;
DataSetName1 = strcat(char('Hilbert_GA_'), DataSetName);

myroot1 = strcat('E:\final_results\filling\', num2str(FullLimitation), '\', DataSetName, '\', 'Hilbert\', 'control');
if ~isdir(myroot1)
    mkdir(myroot1);
end

myroot2 = strcat('E:\final_results\filling\', num2str(FullLimitation), '\', DataSetName, '\', 'Hilbert\', 'uncontrol');
if ~isdir(myroot2)
    mkdir(myroot2);
end

for k=1:row
    
    % visualization based full matrix
    matrixImage=zeros(FullLimitation,FullLimitation);
    
    for i=1:(2^(n*2))
        if i<=column
            matrixImage(imageX(1,i), imageY(1,i))= ((X_FS(k, i)+1) * 20); %% input the pixel value into the matrixImage
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
    if ((2^n) <= FullLimitation)
        for q=1:(2^n)
            for p=1:(2^n)
                matrixImageOptimization(p,q) = matrixImage(p,q);
            end
        end
        
        final_image_optimization=ImageRGBFilling(matrixImageOptimization);
        %%final_image_optimization=mat2gray(matrixImageOptimization);
        switch (char(Y_FS(k,1)))
            case 'control' %% control
                imwrite(final_image_optimization, strcat(myroot1, '\', DataSetName1, num2str(FullLimitation), '_', char(Y_FS(k,1)), num2str(k), '.png'));
            case 'uncontrol' %% uncontrol
                imwrite(final_image_optimization, strcat(myroot2, '\', DataSetName1, num2str(FullLimitation), '_', char(Y_FS(k,1)), num2str(k), '.png'));
        end
        
        fprintf('Hilbert Outputting and Writing image has been over:  \n')
        fprintf('\n')
        
    else
        if ((RowZeroNum ~= 0) || (ColumnZeroNum ~=0))
            if ((2^n - RowZeroNum)<FullLimitation)
                for q=1:FullLimitation
                    for p=1:FullLimitation
                        matrixImageOptimization(p,q) = matrixImage(p,q);
                    end
                end
                
                final_image_optimization=ImageRGBFilling(matrixImageOptimization);
                %%final_image_optimization=mat2gray(matrixImageOptimization);
                switch (char(Y_FS(k,1)))
                    case 'control' %% control
                        imwrite(final_image_optimization, strcat(myroot1, '\', DataSetName1, num2str(FullLimitation), '_', char(Y_FS(k,1)), num2str(k), '.png'));
                    case 'uncontrol' %% uncontrol
                        imwrite(final_image_optimization, strcat(myroot2, '\', DataSetName1, num2str(FullLimitation), '_', char(Y_FS(k,1)), num2str(k), '.png'));
                end
                
                fprintf('Hilbert Outputting and Writing image has been over:  \n')
                fprintf('\n')
            end
        end
        
    end
    
end

end

