function z = HilbertTransforCoordinate(DataSetName)
%HILBERT Hilbert Curve
%   Z = HILBERT(N) is a continuous curve in the complex plane
%   with 4^N points. N is a nonnegative integer.

a = 1 + 1i;
b = 1 - 1i;

% Generate point sequence
z = 0;

load (DataSetName);
[row, column]=size(X);
rank=log2(column);
n=ceil(rank/2);  % upper obtain ingteger

%{
for k = 1:n
    w = 1i*conj(z);             
    z = [w-a; z-b; z+a; b-w]/2;  
    % y = z;
end
%}

for k = 1:n
    w = 1i*conj(z); % conj(z), conjugate function, i.e. x=a+bi, x'=a-bi          
    z = [w-a; z-b; z+a; b-w]/2;
    y = conj(z);
end

plot(y, 'clipping', 'off')
axis equal, axis off  % axis equal, axis off

m=2^n;
radix = abs (real (max (y))); % obtain the maxium abs value of real part

coordinateX = real (y);
coordinateY = imag (y);

for i=1:(m^2)
    imageX(i) = abs((coordinateY(i) - radix)) * 2^(n-1) + 1; % coordinateY is the column of real image
    imageY(i) = (coordinateX(i) + radix) * 2^(n-1) + 1;  % coordinateX is the row of real image
end

InitializeImage_Hilbert_full( imageX, imageY, X, Y, n, column, row, DataSetName, GenoNameReliefF);

end
