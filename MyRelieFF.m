load anxiom_GA_transfor;
 
[m,n]=size(Xvalue)
  
[ranked,weights] = FilterRelieff(Xvalue,Yvalue,10);
bar(weights(ranked))
xlabel('Predictor rank');
ylabel('Predictor importance weight');

[row, column]=size(weights);
j=1;
 
for i=1:column
    if weights(i)>0.015
        feature_relieff_selection_localvalue(j)=i;
        feature_relieff_selection_weightvalue(j)=weights(i);
        j=j+1;
    end

end

feature_relieff_selection_localvalue
feature_relieff_selection_weightvalue
fprintf('data transfor over')
fprintf('\n')

fprintf('start processing FBFS DATA')
fprintf('\n')
fprintf('******************************************************************')
MyFBFSdata(feature_relieff_selection_localvalue, Xvalue, Yvalue, m, j);
fprintf('\n')
fprintf('\n')

fprintf('start processing GA DATA')
fprintf('\n')
fprintf('******************************************************************')
MyGAdata(feature_relieff_selection_localvalue, Xvalue, Yvalue, m, j);

clear
