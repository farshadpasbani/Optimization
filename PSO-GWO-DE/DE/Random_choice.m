function ChildPosition = Random_choice( NP,Cr,VarMin,VarMax,Population,j,D )
r = randperm( NP );
r(r==j) = [];


% Creation of the trial individual X

Rnd = randi([1 D],1,1);
F = unifrnd(0.2,0.8,[1 1]);
ChildPosition = Population(r(1)).Position+F.*(Population(r(2)).Position-Population(r(3)).Position);
    ChildPosition = max(VarMin',ChildPosition);
    ChildPosition = min(VarMax',ChildPosition);
for i = 1:D
    if rand<Cr || i==Rnd
        
    else
        ChildPosition(i) = Population(j).Position(i);
    end
end

end
% end

