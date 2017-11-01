load anxiom_GA_transfor;
 
[m,n]=size(Xvalue)

%% Yvalue=cell(m,1);

for row=1:m
    for column=1:n
        X(row, column)=Xvalue(row, column);
    end
    
    %{
    switch Y(row, 1)
        case {0}
            Yvalue(row, 1)=cellstr('missing') ;
        case {1}
            Yvalue(row, 1)=cellstr('control');
        case {2}
            Yvalue(row, 1)=cellstr('uncontrol');
    end 
    %}
    Y(row, 1)=Yvalue(row, 1);
end

GenoName=GenoNameValue;

fprintf('the data input over')
fprintf('\n')
save anxiom_GA_Original X Y GenoName -v7.3
fprintf('\n')

fprintf('the mat data processing over')

