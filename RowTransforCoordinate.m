function [ output_args ] = RowTransforCoordinate(DataSetName)
%SCANLINETRANSFORCOORDINATE Summary of this function goes here
%   Detailed explanation goes here

load (DataSetName)
[row, column]=size(X)

InitializeImage_Row_full(X, Y, row, column, DataSetName, GenoNameReliefF);

end

