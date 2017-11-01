function [ output_args ] = SpiralTransforCoordinate(DataSetName)
%SPIRALTRANSFORCOORDINATE Summary of this function goes here
%   Detailed explanation goes here

load (DataSetName)
[row, column]=size(X)

InitializeImage_Spiral_full(X, Y, row, column, DataSetName, GenoNameReliefF);

end

