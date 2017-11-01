function Feat_Index =  Binary_Genetic_Algorithm (p,e,s)

% clear all
global Data 
% load ionosphere.mat  % This contains X (Features field) and Y (Class Information)
Data  = load('anxiom_relieff_GA_10_32.mat'); % This is available in Mathworks, ionosphere.mat
[m,n] = size (Data.X);
GenomeLength =1024; % This is the number of features in the dataset
tournamentSize = 4; %% the tournament size must be at least 2, default is 4
Psize=p;
Ecount=e;
seedn=s;
knn1=11;

options = gaoptimset('CreationFcn', {@PopFunction},...
                     'PopulationSize',Psize,...
                     'Generations',300,...
                     'PopulationType', 'bitstring',... 
                     'SelectionFcn',{@selectiontournament,tournamentSize},...
                     'MutationFcn',{@mutationuniform, 0.1},...
                     'CrossoverFcn', {@crossoverarithmetic,0.8},...
                     'EliteCount',Ecount,...
                     'StallGenLimit',300,...
                     'Display', 'iter');
                     %{'PlotFcns',{@gaplotbestf},...%}
                       %% EliteCount is a positive interger less than or equal to the population size, default value is 0.05*populationsize
                      %% 'UseParallel',true,...
rand('seed',seedn)
nVars = 1024; %
FitnessFcn = @FitFunc_KNN;
[chromosome,~,~,~,~,~] = ga(FitnessFcn,nVars,options);
Best_chromosome = chromosome; % Best Chromosome
Feat_Index = find(Best_chromosome==1); % Index of Chromosome

[p,q] = size (Feat_Index);
FinalFeatureSelection (p,:) = Data.GenoNameReliefF(p, Feat_Index(:));
FinalWeightSort (p,:) = Data.GenoWeightsSort(p, Feat_Index(:));
FinalChroName(p,:) = Data.ChroNameReliefF(p, Feat_Index(:));
X_FS = Data.X(:,Feat_Index(:));
%{
for a=1:q
    FinalFeatureSelection (p,a) = Data.GenoNameReliefF(p, Feat_Index(a));
    FinalFeatureSelectionWeightSort (p,a) = Data.GenoWeightsSort(p, Feat_Index(a));
end

for i=1:m
    for j=1:q
        X_FS(i,j) = Data.X(i,Feat_Index(j));
    end
end
%}
Y_FS = Data.Y;

filename=strcat('FinalFeatureSelection', num2str(GenomeLength), '_', 'p',num2str(Psize), '_', 'e',num2str(Ecount), '_', 'seed',num2str(seedn), '_', 'k', num2str(knn1));
save (filename, 'FinalFeatureSelection', 'FinalWeightSort', 'FinalChroName', 'X_FS', 'Y_FS', '-V7.3')
fprintf ('\n');
fprintf ('The dataset had been processed over, the final Features selected by Genetic Algorithm is:');
fprintf ('\n');

end

%%% POPULATION FUNCTION
function [pop] = PopFunction(GenomeLength,~,options)
RD = rand;  
pop = (rand(options.PopulationSize, GenomeLength)> RD); % Initial Population
end

%%% FITNESS FUNCTION   You may design your own fitness function here
function [FitVal] = FitFunc_KNN(pop)
global Data
knn=11;

FeatIndex = find(pop==1); %Feature Index
X1 = Data.X;% Features Set
Y1 = grp2idx(Data.Y);% Class Information
X1 = X1(:,[FeatIndex]);
NumFeat = numel(FeatIndex);
Compute = fitcknn(X1,Y1,'NSMethod','exhaustive','Distance','euclidean');
Compute.NumNeighbors = knn; % kNN = 3
%% testLoss = resubLoss(Compute);
FitVal = resubLoss(Compute)/(1024-NumFeat);
end

