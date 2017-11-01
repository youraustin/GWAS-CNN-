function [ output_args ] = SetDatabase_Row( DataSetName1, Sizek )
%SETDATABASE_ROW Summary of this function goes here
%   Detailed explanation goes here

myrootC = strcat('E:\final_results\space\', num2str(Sizek), '\', DataSetName1, '\', 'Row\', 'control');
myrootU = strcat('E:\final_results\space\', num2str(Sizek), '\', DataSetName1, '\', 'Row\', 'uncontrol');
dc=dir(myrootC);
du=dir(myrootU);
c=size(dc);
u=size(du);

myroot1 = strcat('E:\final_results\space\', num2str(Sizek), '\', DataSetName1, '\', 'Row\', 'train_ctrl');
if ~isdir(myroot1)
    mkdir(myroot1);
end

myroot2 = strcat('E:\final_results\space\', num2str(Sizek), '\', DataSetName1, '\', 'Row\', 'test_ctrl');
if ~isdir(myroot2)
    mkdir(myroot2);
end
cd(myrootC);
for i=3:c
    if mod((i-2),4)==0
        movefile(dc(i).name, myroot2);
    else
        movefile(dc(i).name, myroot1);
    end
end

myroot3 = strcat('E:\final_results\space\', num2str(Sizek), '\', DataSetName1, '\', 'Row\', 'train_unctrl');
if ~isdir(myroot3)
    mkdir(myroot3);
end

myroot4 = strcat('E:\final_results\space\', num2str(Sizek), '\', DataSetName1, '\', 'Row\', 'test_unctrl');
if ~isdir(myroot4)
    mkdir(myroot4);
end
cd(myrootU);
for j=3:u
    if mod((j-2),4)==0
        movefile(du(j).name, myroot4);
    else
        movefile(du(j).name, myroot3);
    end
end

end
