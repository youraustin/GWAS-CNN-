load anxiom_GA;

map_dataset=importdata('anxiom_final_decoding.map')
map_dataset.textdata(:,1);
map_dataset.textdata(:,2);
map_dataset.data(:,1);
map_dataset.data(:,2); 
 
[m,n]=size(X)

Yvalue=cell(m,1);
for row1=1:n
    GenoNameValue(1,row1)= map_dataset.textdata(n,2);
end


for row=1:m
    for column=1:n
        Xvalue(row, column)=X(row, column);
    end
    switch Y(row, 1)
        case {0}
            Yvalue(row, 1)=cellstr('missing') ;
        case {1}
            Yvalue(row, 1)=cellstr('control');
        case {2}
            Yvalue(row, 1)=cellstr('uncontrol');
    end 
    %%Yvalue(row, 1)=Y(row, 1);
end
fprintf('the data input over')
fprintf('\n')
save anxiom_GA_transfor Xvalue Yvalue GenoNameValue -v7.3
fprintf('\n')

fprintf('the mat data processing over')






 

 
 

 