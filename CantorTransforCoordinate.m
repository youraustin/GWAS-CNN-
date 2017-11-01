function [ output_args ] = CantorTransforCoordinate(DataSetName)
%CANTORTRANSFORCOORDINATE Summary of this function goes here
%   Detailed explanation goes here

load (DataSetName)
[row, column]=size(X)

InitializeImage_Cantor_full(X, Y, row, column, DataSetName, GenoNameReliefF);

end

