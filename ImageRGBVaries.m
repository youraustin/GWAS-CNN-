function [ ImageMatrixRGBVaries ] = ImageRGBVaries( input_args, lab, vc,locaX, locaY, column)
%IMAGERGBVARIES Summary of this function goes here
%   Detailed explanation goes here

%% matrixImage;
[c,r]=size(input_args);

%ImageMatrixRGB(:,:,1)=  input_args;
%% A = vc+1; %% A means Contrast
switch (lab)
    case 'control'
        B = vc*48; %% B means Brightness
    case 'uncontrol'
        B = vc*16; %% B means Brightness
end

outImage=zeros(c,c,3);
%{
outImage1=ones(c,c,3);
outImage=outImage1*B;
%}


%% M = 127; %% M means middle-value
for i=1:column
    switch (input_args(locaX(i),locaY(i)))
        case 20 %% make the color for this snp to blue
            outImage(locaX(i),locaY(i),1)= (0+B)/255;
            outImage(locaX(i),locaY(i),2)= (0+B)/255;
            outImage(locaX(i),locaY(i),3)= 255/255;
        case 40 %% make the color for this snp to yellow
            outImage(locaX(i),locaY(i),1)= 255/255;
            outImage(locaX(i),locaY(i),2)= 255/255;
            outImage(locaX(i),locaY(i),3)= (0+B)/255;
        case 60 %% make the color for this snp to red
            outImage(locaX(i),locaY(i),1)= 255;
            outImage(locaX(i),locaY(i),2)= (0+B)/255;
            outImage(locaX(i),locaY(i),3)= (0+B)/255;
        case 80 %% make the color for this snp to green
            outImage(locaX(i),locaY(i),1)= (0+B)/255;
            outImage(locaX(i),locaY(i),2)= 255/255;
            outImage(locaX(i),locaY(i),3)= (0+B)/255;
    end
end

ImageMatrixRGBVaries = outImage;
%ImageMatrixRGBVaries = ImageMatrixRGBVaries./255; %% ./ means every element

%{
ImageMatrixRGB = cat(3, input_args, input_args, input_args);
ImageMatrixRGB = ImageMatrixRGB./255; %% ./ means every element
%}

end

