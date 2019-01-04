clc
clearvars
close all
addpath('test function matlab files')

global initial_flag FunctionEvaluation
initial_flag = 0;
FunctionEvaluation=0;
nfe=0;
% GWO

No_searchagents = 20;
FunctionNumber = 9;
Max_nfe = 3e5;
D = 10;
L=-5*ones(1,D);
H=5*ones(1,D);
fobj = @(x) benchmark_func(x,FunctionNumber);

[Best_score,Best_pos,curve]=GWO(fobj,D,L,H,Max_nfe,No_searchagents);

X = zeros(size(curve));
for i = 1:numel(X)
    X(i) = i;
end
plot(X,curve)