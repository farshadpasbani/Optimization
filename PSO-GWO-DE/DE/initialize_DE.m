function Population = initialize_DE( NP,VarMin,VarMax,CostFunction,D )

Individual.Position = [];
Individual.Cost = [];

%PSO
Individual.Velocity = ones(1,D);
Individual.Best.Position = zeros(1,D);
Individual.Best.Cost = inf;
Population = repmat(Individual,NP,1);
for i = 1:NP
    
    % Population creation
    Population(i).Position = unifrnd(VarMin,VarMax,1,D);
    Population(i).Best.Position=Population(i).Position;
    
    % Population Evaluation
    Population(i).Cost = CostFunction(Population(i).Position);
    Population(i).Best.Cost=Population(i).Best.Cost;

end
% Sorting Population And Costs

Costs = [Population.Cost];
[~,SortOrder] = sort(Costs);
Population=Population(SortOrder);

