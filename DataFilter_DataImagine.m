clear

fprintf('Two Optiones of solution for ReliefF:');
fprintf('\n');
fprintf('1: original value sort');
fprintf('\n');
fprintf('2: absolute value sort');
fprintf('\n');
fprintf('3: original value');
fprintf('\n');
fprintf('4: absolute value');
fprintf('\n');

fprintf('\n');

input('Please Choose the option parameters of ReliefF: ', 's')
u = ans;

k = str2num(u);

switch k
    case 1
        fprintf('Start ReliefF filter Processing with original weight value!!');
        fprintf('\n');
        %{
        input('Input the weight limitation (value = 16, 32, 64, 128, 256, 512, 1024): ', 's')
        w = ans;
        v = str2num(w);
        MyRelieFF_ORI_Sort(v);
        %}
        MyRelieFF_ORI_Sort;
        
    case 2
        fprintf('Start ReliefF filter Processing with absolute weight value!!');
        fprintf('\n');
        %{
        input('Input the weight limitation (value = 16, 32, 64, 128, 256, 512, 1024): ', 's')
        w = ans;
        v = str2num(w);
        MyRelieFF_ABS_Sort(v);
        %}
        MyRelieFF_ABS_Sort;
    
    case 3
        fprintf('Start ReliefF filter Processing with original weight value!!');
        fprintf('\n');
        input('Input the weight limitation (value<0.5): ', 's')
        w = ans;
        v = str2num(w);
        MyRelieFF_ORI(v);
        
    case 4
        fprintf('Start ReliefF filter Processing with absolute weight value!!');
        fprintf('\n');
        input('Input the weight limitation (value<0.5): ', 's')
        w = ans;
        v = str2num(w);
        MyRelieFF_ABS(v);
        
end

clear

