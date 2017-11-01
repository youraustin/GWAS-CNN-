function [ output_args ] = MyRelieFF_ORI( v )
%MYRELIEFF_ORI Summary of this function goes here
%   Detailed explanation goes here

load anxiom_GA_transfor;

[m,n]=size(Xvalue)
  
[ranked,weights] = FilterRelieff(Xvalue,Yvalue,10);
bar(weights(ranked))
xlabel('Predictor rank');
ylabel('Predictor importance weight');
fprintf('ReliefF filter processing over!!');

weight_limitation = v;
fprintf('The weight limitation value is %d', weight_limitation);
fprintf('\n');
[row, column]=size(weights);

j=1; 
for i=1:column
    if weights(i)>weight_limitation
        feature_relieff_selection_localvalue(j)=i;
        feature_relieff_selection_weightvalue(j)=weights(i);
        j=j+1;
    end

end

fprintf('data transfor over')
fprintf('\n')

%{
fprintf('start processing FBFS DATA')
fprintf('\n')
fprintf('******************************************************************')
MyFBFSdata(feature_relieff_selection_localvalue, Xvalue, Yvalue, m, j);
fprintf('\n')
fprintf('\n')
%}

fprintf('start processing GA DATA')
fprintf('\n')
fprintf('******************************************************************')
MyGAdata(feature_relieff_selection_localvalue, Xvalue, Yvalue, m, j);

clear

end

