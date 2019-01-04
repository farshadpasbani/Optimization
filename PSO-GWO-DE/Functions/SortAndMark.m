function [Alpha,Beta,Delta] = SortAndMark(Population,Alpha,Beta,Delta)

% Sorting Population And Costs

Position = Population.Position;
Cost = Population.Cost;
if Cost<Alpha.Cost
    Alpha.Position = Position;
    Alpha.Cost = Cost;
end

if Cost<Beta.Cost && Cost>Alpha.Cost
    Beta.Position = Position;
    Beta.Cost = Cost;
end

if Cost<Delta.Cost && Cost>Beta.Cost && Cost>Alpha.Cost
    Delta.Position = Position;
    Delta.Cost = Cost;
end

end

