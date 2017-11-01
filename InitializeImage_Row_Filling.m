function [ output_args ] = InitializeImage_Row_Filling( SizeLimitation, DataSetName)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

load (DataSetName);
[row, column]=size(X_FS);

FullLimitation=SizeLimitation;
Sizek=SizeLimitation;
DataSetName1 = strcat(char('Row_GA_'), DataSetName);

myroot1 = strcat('E:\final_results\filling\', num2str(Sizek), '\', DataSetName, '\', 'Row\', 'control');
if ~isdir(myroot1)
    mkdir(myroot1);
end

myroot2 = strcat('E:\final_results\filling\', num2str(Sizek), '\', DataSetName, '\', 'Row\', 'uncontrol');
if ~isdir(myroot2)
    mkdir(myroot2);
end

for i=1:row
    % visualization based full matrix
    matrixImage=zeros(FullLimitation,FullLimitation);
    arrayImage=X_FS(i,:);
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
    
    switch (char(Y_FS(i,1)))
        case 'control' %% control
            imwrite(final_image, strcat(myroot1, '\', DataSetName1, num2str(Sizek), '_', char(Y_FS(i,1)), num2str(i), '.png'));
        case 'uncontrol' %% uncontrol
            imwrite(final_image, strcat(myroot2, '\', DataSetName1, num2str(Sizek), '_', char(Y_FS(i,1)), num2str(i), '.png'));
    end
    
    fprintf('Row Outputting and Writing image has been over:  \n')
    fprintf('\n')
end

end

