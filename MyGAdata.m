 function [ output_args ] = MyGAdata( feature_relieff_selection_localvalue, Xvalue, Yvalue, m, FSamount, FS)
%MY Summary of this function goes here
%   Detailed explanation goes here

%readmap;
load datamap;

X=[0,0];

anxiom_corect_GA=struct('rsID', 0, 'genotype', 0);

[B1,INDEX1] = sort(feature_relieff_selection_localvalue);

for row2=1:m
    for column2=1:FSamount
        anxiom_corect_GA(row2, column2).genotype= Xvalue(row2,B1(1,column2));
        X(row2,column2)=anxiom_corect_GA(row2, column2).genotype;
    end
    
    Y(row2, 1)=Yvalue(row2, 1);
end

for column3=1:FSamount
    GenoNameReliefF(1, column3) = GenoName(1, B1(1,column3));
    ChroNameReliefF(1, column3) = ChroName(1, B1(1,column3));
    GenoWeightsSort(1, column3) = INDEX1(column3);
    %% anxiom_corect_GA(1, column3).rsID= map_dataset.textdata(feature_relieff_selection_localvalue(1,column3),2);
    %% GenoNameReliefF(1, column3)=anxiom_corect_GA(1, column2).rsID;
end

fprintf('the GA data input over')
fprintf('\n')
fprintf('start process the GA mat file')
fprintf('\n')
fprintf('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@')
fprintf('\n')

filename = ['anxiom_relieff_GA_10_', num2str(FS)];

save (filename, 'X',  'Y',  'GenoNameReliefF', 'ChroNameReliefF', 'GenoWeightsSort', '-v7.3');
fprintf('the Demo Genetic Algorithm data processing over')
fprintf('\n')
fprintf('******************************************************************')
fprintf('\n')

clear

end

