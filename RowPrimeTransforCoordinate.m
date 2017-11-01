function [ output_args ] = RowPrimeTransforCoordinate(DataSetName)
%SCANSNAKETRANSFORCOORDINATE Summary of this function goes here
%   Detailed explanation goes here

load (DataSetName)
[row, column]=size(X)

InitializeImage_RowPrime_full(X, Y, column, row, DataSetName, GenoNameReliefF);


end

