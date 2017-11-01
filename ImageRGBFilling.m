function [ ImageMatrixRGB ] = ImageRGBFilling( input_args )
%IMAGERGBFILLING Summary of this function goes here
%   Detailed explanation goes here
[c,r]=size(input_args);

%ImageMatrixRGB(:,:,1)=  input_args;

outImage=zeros(c,c,3);
%{
outImage1=ones(c,c,3);
outImage=outImage1*B;
%}


%% M = 127; %% M means middle-value
for i=1:c
    for j=1:r
        switch (input_args(i,j))
            case 20 %% make the color for this snp to blue
                outImage(i,j,1)= 0/255;
                outImage(i,j,2)= 0/255;
                outImage(i,j,3)= 255/255;
            case 40 %% make the color for this snp to yellow
                outImage(i,j,1)= 255/255;
                outImage(i,j,2)= 255/255;
                outImage(i,j,3)= 0/255;
            case 60 %% make the color for this snp to red
                outImage(i,j,1)= 255;
                outImage(i,j,2)= 0/255;
                outImage(i,j,3)= 0/255;
            case 80 %% make the color for this snp to green
                outImage(i,j,1)= 0/255;
                outImage(i,j,2)= 255/255;
                outImage(i,j,3)= 0/255;
        end
    end
end

ImageMatrixRGB = outImage;
%ImageMatrixRGBVaries = ImageMatrixRGBVaries./255; %% ./ means every element

%{
ImageMatrixRGB = cat(3, input_args, input_args, input_args);
ImageMatrixRGB = ImageMatrixRGB./255; %% ./ means every element
%}

end



