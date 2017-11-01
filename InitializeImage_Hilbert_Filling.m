function [ output_args ] = InitializeImage_Hilbert_Filling( SizeLimitation, DataSetName)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

a = 1 + 1i;
b = 1 - 1i;
z = 0;
n=log2(SizeLimitation); 

for k = 1:n
    w = 1i*conj(z); % conj(z), conjugate function, i.e. x=a+bi, x'=a-bi          
    z = [w-a; z-b; z+a; b-w]/2;
    y = conj(z);
end

plot(y, 'clipping', 'off')
axis equal, axis off  % axis equal, axis off

m=2^n;
radix = abs (real (max (y))) % obtain the maxium abs value of real part

coordinateX = real (y);
coordinateY = imag (y);

for i=1:(m^2)
    imageX(i) = abs((coordinateY(i) - radix)) * 2^(n-1) + 1; % coordinateY is the column of real image
    imageY(i) = (coordinateX(i) + radix) * 2^(n-1) + 1;  % coordinateX is the row of real image
end

InitializeImage_Hilbert_filling_due( imageX, imageY, n, DataSetName);

end

