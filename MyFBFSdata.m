function [ output_args ] = MyFBFSdata(feature_relieff_selection_localvalue, Xvalue, Yvalue, m, j )
%MYFBFSDATA Summary of this function goes here
%   Detailed explanation goes here

readmap;

anxiom_corect_SFS=struct('rsID', 0, 'genotype', 0);

for row1=1:m
    for column1=1:(j-1)
        anxiom_corect_SFS(row1,column1).genotype= Xvalue(row1,feature_relieff_selection_localvalue(1,column1));
        anxiom_corect_SFS(row1, column1).rsID= map_dataset.textdata(feature_relieff_selection_localvalue(1,column1),2);
        anxiom_corect_FBFS_10(row1, column1)=anxiom_corect_SFS(row1,column1).genotype;
    end
    switch char(Yvalue(row1,1))
        case {'missing'}
            anxiom_corect_FBFS_10(row1,j)=0 ;
        case {'control'}
            anxiom_corect_FBFS_10(row1,j)=1;
        case {'uncontrol'}
            anxiom_corect_FBFS_10(row1,j)=2;
    end 
    %%anxiom_corect_FBFS_1000(row1,j)=Yvalue(row1,1);
end
fprintf('the FBFS data input over')
fprintf('\n')
fprintf('start process the FBFS mat file')
fprintf('\n')
fprintf('@@@@@@@@@@@@@@@@@@@@@@@@@@@')

save anxiom_corect_FBFS_10 anxiom_corect_FBFS_10 -v7.3
fprintf('the FBFS data processing over')
fprintf('\n')
fprintf('******************************************************************')

clear

end

