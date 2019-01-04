clc
clearvars
close all
addpath('DE','GWO','PSO','Functions','test function matlab files');
global initial_flag FunctionEvaluation
initial_flag = 0;
FunctionEvaluation = 0;
No_SearchAgents = 5;

Dimension = 10;
No_cuts = 1;

MaxNFE = 15;

Function_number = 15;

Process = 6;

[startminx,startmaxx,LowerBound,UpperBound,minF]=...
    function_detils(Function_number);

% Make cuts
MiddlePoint = (UpperBound+LowerBound)/2;
for i = 1:Dimension
    Domain(i,1,:) = [LowerBound,MiddlePoint];
    Domain(i,2,:) = [MiddlePoint,UpperBound];    
end

Number_Of_Slices = 2^(Dimension);
j = 1;
Dims = zeros(Dimension,Number_Of_Slices);
while j<=Number_Of_Slices
    tmp = randi(2,Dimension,1);
    flag = 0;
    for i = 1:j
        if Dims(:,i) == tmp
            flag = 1;
        end
    end
    if flag == 0
        Dims(:,j) = tmp;
        j=j+1;
    end       
    
end

for i = 1:Number_Of_Slices
    for d = 1:Dimension
    Bound(d,1) = Domain(d,Dims(d,i),1);
    Bound(d,2) = Domain(d,Dims(d,i),2);
    end
    [Population,Violation] = OptimizeSection...
    (Bound(:,2),Bound(:,1),MaxNFE,Function_number,Process,Dimension,No_SearchAgents,minF);
    PromisingSec(i,:) = [i,min(Violation)];
end

temp = PromisingSec(:,2);
[Sorted,SortOrder] = sort(temp);

PromisingSec = PromisingSec(SortOrder,:);
for i = 1:6
    tmp = Dims(:,PromisingSec(i,1));
    if i == 1
        B(:,1) = tmp;
    elseif i == 2
        B(:,2) = tmp;
    elseif i == 3
        B(:,3) = tmp;
    elseif i == 4
        B(:,4) = tmp;
    elseif i == 5
        B(:,5) = tmp;
    elseif i == 6
        B(:,6) = tmp;
    end
end
No_SearchAgents = 30;
Process = 6;
MaxNFE = 500;
for i = 6:-1:1
    tmp = B(:,i);
    for d = 1:Dimension
    Bound(d,1) = Domain(d,B(d,i),1);
    Bound(d,2) = Domain(d,B(d,i),2);
    end
    [Population,Violation] = OptimizeSection...
    (Bound(:,2),Bound(:,1),MaxNFE,Function_number,Process,Dimension,No_SearchAgents,minF);
    PromisingSec(i,:) = [i,min(Violation)];
end

%     for d = 1:Dimension
%     Bound(d,1) = Domain(d,B(d,1),1);
%     Bound(d,2) = Domain(d,B(d,1),2);
%     end
%     [Population,Violation] = OptimizeSection...
%     (Bound(:,2),Bound(:,1),MaxNFE,Function_number,Process,Dimension,No_SearchAgents,minF);

    
    
    
    
    
    
    
    
    
    
    
    
    
