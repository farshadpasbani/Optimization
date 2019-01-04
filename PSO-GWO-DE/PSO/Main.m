clc
clear
close all
addpath('test function matlab files')
global initial_flag FunctionEvaluation
initial_flag = 0;
FunctionEvaluation = 0;
nfe = 0;
% PSO
%% Algorithm Parameters

No_SearchAgents = 20;
w=1;
wdamp=0.99;
%% Problem Parameters

FunctionNumber=9;
VarMin = -5;
VarMax = 5;
D = 10;
Max_nfe = 3e5;
fobj = @(x) benchmark_func(x,FunctionNumber);
MaxVelocity = 0.1*(VarMax-VarMin);
MinVelocity = -MaxVelocity;

% Initialize search agents
Population.Position = [];
Population.Cost = [];
Population.Velocity = ones(1,D);
Population.Best.Position = zeros(1,D);
Population.Best.Cost = inf;

Pop = repmat(Population,No_SearchAgents,1);

% P_best = 
% xP_best = 
G_best.Position = [];
G_best.Cost = inf;
for i = 1:No_SearchAgents
    Pop(i).Position = unifrnd(VarMin,VarMax,1,D); 
    Pop(i).Cost = fobj(Pop(i).Position);
    if Pop(i).Cost<Pop(i).Best.Cost
        Pop(i).Best.Cost = Pop(i).Cost;
        Pop(i).Best.Position = Pop(i).Position;
    end
    if Pop(i).Cost<G_best.Cost
        G_best.Cost = Pop(i).Cost;
        G_best.Position = Pop(i).Position;
    end
end

% Main Loop
Iteration = 1;
c1 = 2;
c2 = 2;
tic
% nfe = zeros(Max_Iteration,1);
while FunctionEvaluation<Max_nfe
    

    for i = 1:No_SearchAgents
        
        R1 = rand(1,D);
        R2 = rand(1,D);
        Pop(i).Velocity = w.*Pop(i).Velocity +...
            c1*(Pop(i).Best.Position-Pop(i).Position).*R1 +...
            c2*(G_best.Position-Pop(i).Position).*R2;
        Pop(i).Velocity = min(MaxVelocity,Pop(i).Velocity);
        Pop(i).Velocity = max(MinVelocity,Pop(i).Velocity);
        Pop(i).Position = Pop(i).Position+Pop(i).Velocity;
        
        IsOutside=(Pop(i).Position<VarMin | Pop(i).Position>VarMax);
        Pop(i).Velocity(IsOutside)=-Pop(i).Velocity(IsOutside);
%         plot(Pop(i).Position(1),Pop(i).Position(2),'ro')
%         hold on
        Pop(i).Cost = fobj(Pop(i).Position);
        if Pop(i).Cost<Pop(i).Best.Cost
            Pop(i).Best.Cost = Pop(i).Cost;
            Pop(i).Best.Position = Pop(i).Position;
            if Pop(i).Cost<G_best.Cost
                G_best.Cost = Pop(i).Cost;
                G_best.Position = Pop(i).Position;
            end
        end

    end
    w=w*wdamp;
    if w<0.2
        w=1;
    else
        w=w*wdamp;
    end
    nfe(Iteration) = FunctionEvaluation;
    disp(['Iteration ' num2str(Iteration) ': NFE = ' num2str(nfe(Iteration)) ', Best Cost = ' num2str(G_best.Cost)]);

%     i = 0.001*Iteration;
%     plot(G_best.Position(1),G_best.Position(2),'bs','color',[rand,rand,rand])
%     surf(G_best.Position(1),G_best.Position(2),G_best.Cost)
%     hold on
%     pause(0.001)
    Iteration = Iteration+1;
end


toc

