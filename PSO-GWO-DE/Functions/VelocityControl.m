function [Population,Trial_Member_Positon] = VelocityControl(Population,i,...
    MaxVelocity,MinVelocity,LowerBound,UpperBound,Trial_Member_Positon)
        % Velocity control
        Population(i).Velocity = min(MaxVelocity',Population(i).Velocity);
        Population(i).Velocity = max(MinVelocity',Population(i).Velocity);
        
        % Moving Search Agent
        Trial_Member_Positon(i,:) = Population(i).Position+Population(i).Velocity;
        
        % Bringing Out-Of-Boundary Search Agents Back
        IsOutside=(Trial_Member_Positon(i,:)<LowerBound' |...
            Trial_Member_Positon(i,:)>UpperBound');
        Population(i).Velocity(IsOutside)=-Population(i).Velocity(IsOutside);
        Trial_Member_Positon(i,IsOutside) = Population(i).Position(IsOutside)...
            +Population(i).Velocity(IsOutside);  
end

