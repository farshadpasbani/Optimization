function [Population,G_best] = InitializePopulation(No_SearchAgents,...
    Dimension,LowerBound,UpperBound,G_best,Fobj)

% Creating an Empty Individual
Individual.Position = zeros(1,Dimension);
Individual.Cost = inf;
Individual.Velocity = zeros(1,Dimension);
Individual.PSOvelocity = zeros(1,Dimension);
Individual.GWOvelocity = zeros(1,Dimension);
Individual.PSOvelocity = zeros(1,Dimension);
Individual.DEvelocity = zeros(1,Dimension);
Individual.BestPosition = zeros(1,Dimension);
Individual.BestCost = inf;

% Replicating Empty Individual
Population = repmat(Individual,No_SearchAgents,1);

% Generate points

for N = 1:No_SearchAgents
    for d = 1:Dimension
    Population(N).Position(d) = unifrnd(LowerBound(d),UpperBound(d),1,1);
    end
    Population(N).Cost = Fobj(Population(N).Position);
    
    if Population(N).Cost<Population(N).BestCost
        Population(N).BestCost = Population(N).Cost;
        Population(N).BestPosition = Population(N).Position;
    end
    if Population(N).Cost<G_best.Cost
        G_best.Cost = Population(N).Cost;
        G_best.Position = Population(N).Position;
    end
end

end

