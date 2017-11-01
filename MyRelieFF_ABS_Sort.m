function [ output_args ] = MyRelieFF_ABS_Sort
%MyRelieFF_ABS Summary of this function goes here
%   Detailed explanation goes here

load anxiom_GA_transfor;

[m,n]=size(Xvalue)

[ranked,weights] = FilterRelieff(Xvalue,Yvalue,10);
bar(weights(ranked))
xlabel('Predictor rank');
ylabel('Predictor importance weight');
fprintf('ReliefF filter processing over!!');

weight_limitation = 32; %weight_limitation = v
fprintf('The weight limitation value is %d', weight_limitation);
fprintf('\n');
[row, column]=size(weights)

for sizeN=1:4
    [B,INDEX] = sort(abs(weights));
    j=1;
    FS=weight_limitation*2^(sizeN-1);
    for i=column:-1:((column-FS*FS)+1)
        feature_relieff_selection_localvalue(j)=INDEX(i);
        %% feature_relieff_selection_weightvalue(j)=B(i);
        j=j+1;
    end
    
    FSamount = j-1;
    
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
    MyGAdata(feature_relieff_selection_localvalue, Xvalue, Yvalue, m, FSamount, FS);
end

clear

end

