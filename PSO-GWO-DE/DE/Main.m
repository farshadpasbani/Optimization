clc
clearvars
addpath('test function matlab files')
global initial_flag FunctionEvaluation DirFlag
initial_flag = 0;
FunctionEvaluation = 0;

%% Algorithm Parameters

F = 0.2;    % differentiation (or mutation) constant

Cr = 0.2;   % crossover constant Cr

NP = 20 ;    % size of population NP

Max_FE = 1e5; % maximal number of generations (or iterations) GEN

c1=2;
c2=2;
%% Problem parameters

FunctionNumber = 19;

D = 10;      % dimension of problem D

VarMin = -5;
VarMax = 5;

MaxVelocity = 0.01*(VarMax-VarMin);
MinVelocity = -MaxVelocity;
CostFunction = @(x) benchmark_func(x,FunctionNumber);
nfe = zeros(Max_FE,1);
%% Initialization
Pop = initialize_DE(NP,VarMin,VarMax,CostFunction,D);

nfe(1) = nfe(1)+FunctionEvaluation;
G_best.Position=Pop(1).Position;
G_best.Cost = inf;
%% Main loop
BestCost = nfe;
Loop_counter = 1;
tmp = 1;


while FunctionEvaluation<=Max_FE
    curveflag = 0;
    DirFlag = 0;
    for j = 1:NP
        
        % Mutation
        X = Random_choice( NP,Cr,VarMin,VarMax,Pop,j,D );
        if isequal(X,Pop(j).Position) == 0
            ChildCost = CostFunction(X);
            % Selection of the best individual
            if ChildCost<Pop(j).Cost
                
                Pop(j).Best.Position = X;
                Pop(j).Best.Cost = ChildCost;
                DIRECTION=X-Pop(j).Position;
                
                Pop(j).Position = X;
                Pop(j).Cost = ChildCost;
                if ChildCost<G_best.Cost
                    G_best.Position = Pop(j).Position;
                    G_best.Cost = Pop(j).Cost;
                    DirFlag = 1;
                end
            end
        end
    end
    % Sorting
    
    %     Costs = [Pop.Cost];
    %     [~,SortOrder] = sort(Costs);
    %     Pop = Pop(SortOrder);
    
    
    
    % Plot
    %     for i = 1:NP
    %         plot(Pop(i).Position(1),Pop(i).Position(2),'ro');
    %         hold on
    %
    %     end
    %     plot(Pop(1).Position(1),Pop(1).Position(2),'bs','color',[rand,rand,rand])
    %     hold on
    %     pause(0.1)
    % Curve
    BestCost(Loop_counter) = G_best.Cost;
    
    nfe(Loop_counter) = FunctionEvaluation;
    if FunctionEvaluation>100000
        Cr = 0.5;
        F = 0.9;
%         if FunctionEvaluation>150000
%             Cr = 0.2;
%             F=0.9;
%         end
    end
    
    disp(['Iteration ' num2str(Loop_counter) ': NFE = ' num2str(nfe(Loop_counter)) ', Best Cost = ' num2str(BestCost(Loop_counter))]);
    if curveflag==1
        tmp = tmp+1;
    end
    Loop_counter = Loop_counter+1;
    
end
semilogy(nfe,BestCost)



