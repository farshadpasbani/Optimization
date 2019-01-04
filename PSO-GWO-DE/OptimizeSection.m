function [Population,Violation] = OptimizeSection...
    (UpperBound,LowerBound,MaxNFE,Function_number,Process,Dimension,No_SearchAgents,minF)

global initial_flag FunctionEvaluation
 % In this attempt Domain is divided into several parts
 % and each domain is given to a specific method to run
 % at the end of each run, most promising area is found
 % we continue to do a proper search in it.
 % For testing D=10 No_SearchAgents=20 MaxNFE = 1e5
%% Initialization Parameters

% Inputs

% End Inputs

% Fetching Cost Function Details
Fobj = @(x) benchmark_func(x,Function_number);


% PSO Parameters

c1=2;
c2=2;
w=1;
wdamp=0.99;
GAMMA = 1;
Gdamp = 1;

G_best.Position = [];
G_best.Cost = inf;

% GWO Parameters

Alpha.Position = zeros(1,Dimension);
Alpha.Cost = inf;

Beta.Position = zeros(1,Dimension);
Beta.Cost = inf;

Delta.Position = zeros(1,Dimension);
Delta.Cost = inf;

% DE Parameters

Cr = 0.7;   % crossover constant Cr

% Velocity Bounds
MaxVelocity = 0.035*(UpperBound-LowerBound);
MinVelocity = -MaxVelocity;

%% Initialize Positions And Evaluate Costs

[Population,G_best] = InitializePopulation(No_SearchAgents,...
    Dimension,LowerBound,UpperBound,G_best,Fobj);
for i = 1:No_SearchAgents
    Trial_Member_Positon(i,:) = Population(i).Position;
end
% Mark Alpha, Beta, Delta For GWO

for i = 1:No_SearchAgents
    [Alpha,Beta,Delta] = SortAndMark(Population(i),Alpha,Beta,Delta);
end

%% Main Loop
Max_Iteration = MaxNFE;
initialPSO = 0;
for Iteration=1:Max_Iteration
    
    a=2-Iteration*((2)/Max_Iteration);
    Flag = ' ';
    
    
    [w,GAMMA] = PSO_Modifier(w,wdamp,GAMMA,Gdamp);
    % Function Evaluation
    Trial_Member_Cost = Fobj(Trial_Member_Positon);
    
    for i=1:No_SearchAgents
        
        switch Process
            case 1
                % Process 1
                
                method = 'average';

            case 2
                % Process 2
                
                
                if Iteration<= 1/3*Max_Iteration
                    
                    method = 'GWO';

                elseif Iteration<= 2/3*Max_Iteration
                    method = 'DE';
                    
                else
                    if initialPSO==0
                        w=2;
                        GAMMA=2;
                        initialPSO=1;
                    end
                    method = 'PSO';                    
                    
                    
                end
                
            case 3
                % Process 3
                if i<= No_SearchAgents/3
                    method = 'GWO';
                    a=2-Iteration*((2)/Max_Iteration);
                elseif i<(2*No_SearchAgents/3) && i> No_SearchAgents/3
                    method = 'PSO';
                else
                    method = 'DE';
                end
                
            case 4
                % Process 4
                random1 = randi([No_SearchAgents/2,No_SearchAgents]);
                if i<= random1/3
                    method = 'GWO';
                    a=2-Iteration*((2)/Max_Iteration);
                elseif i<(2*random1/3) && i> random1/3
                    method = 'DE';
                else
                    method = 'PSO';
                end
            case 5
                method = 'DE';
            case 6
                method = 'GWO';
                
            case 7
                method = 'PSO';
        end
        %
        if Trial_Member_Cost(i)<Population(i).Cost
            if strcmp(method,'DE')
                Population(i).Position = Trial_Member_Positon(i,:);
                Population(i).Cost = Trial_Member_Cost(i);
            end
        end
        if Trial_Member_Cost(i)<Population(i).BestCost
            Population(i).BestCost = Population(i).Cost;
            Population(i).BestPosition = Population(i).Position;
            if Trial_Member_Cost(i)<G_best.Cost
                G_best.Cost = Trial_Member_Cost(i);
                G_best.Position = Trial_Member_Positon(i,:);
                Flag = ' G_best';
            end
            
        end
        if strcmp(method,'PSO') || strcmp(method,'GWO')
            Population(i).Position = Trial_Member_Positon(i,:);
            Population(i).Cost = Trial_Member_Cost(i);
        end
        
        % GWO
        [Alpha,Beta,Delta] = SortAndMark(Population(i),Alpha,Beta,Delta);
        if strcmp(method,'GWO')
        Population(i).GWOvelocity=...
            GWOvelocityF(a,Population(i).Position,...
            Alpha.Position,Beta.Position,Delta.Position,Dimension);
        end
        
        % PSO
        if strcmp(method,'PSO')
        R1 = rand(1,Dimension);
        R2 = rand(1,Dimension);
        Population(i).PSOvelocity = GAMMA*(w.*Population(i).PSOvelocity +...
            c1*(Population(i).BestPosition-Population(i).Position).*R1 +...
            c2*(G_best.Position-Population(i).Position).*R2);
        end
        % DE
        if strcmp(method,'DE')
        X = Random_choice( No_SearchAgents,Cr,LowerBound,UpperBound,...
            Population,i,Dimension );
        Population(i).DEvelocity = X-Population(i).Position;
        end
        % Determining Final Velocity For ith Search Agent
        switch method
            case 'average'
                Population(i).Velocity = 1/6*(Population(i).PSOvelocity+...
                    Population(i).GWOvelocity+Population(i).DEvelocity);
            case 'GWO'
                Population(i).Velocity = Population(i).GWOvelocity;
            case 'DE'
                Population(i).Velocity = Population(i).DEvelocity;
            case 'PSO'
                Population(i).Velocity = Population(i).PSOvelocity;
                
        end    
        
[Population,Trial_Member_Positon] = VelocityControl(Population,i,...
    MaxVelocity,MinVelocity,LowerBound,UpperBound,Trial_Member_Positon);
        
    end
    
    
    % Sort And Mark Alpha, Beta, Delta
    
    disp(['Ite ' num2str(Iteration) ': NFE = ' num2str(FunctionEvaluation) ', BestCost = ' num2str(G_best.Cost),'Violation=' num2str(G_best.Cost-minF),Flag]);
    G(Iteration) = G_best.Cost;
    Violation(Iteration) = G_best.Cost-minF;
end
end

