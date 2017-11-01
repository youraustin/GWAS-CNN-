clear

parfor i=6:8
    
    DataSetName = strcat('anxiom_relieff_GA_10_', num2str(2^i));
    
    CantorTransforCoordinate(DataSetName);
    HilbertTransforCoordinate(DataSetName);
    RowPrimeTransforCoordinate(DataSetName);
    RowTransforCoordinate(DataSetName);
    SpiralTransforCoordinate(DataSetName);
end

clear all