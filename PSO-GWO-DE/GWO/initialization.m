function Positions = initialization( No_searchagents,dimension,ub,lb )

Boundary_no= size(ub,2); 


if Boundary_no==1
    Positions=rand(No_searchagents,1).*(ub-lb)+lb;
end

if Boundary_no>1
    for i=1:dimension
        ub_i=ub(i);
        lb_i=lb(i);
        Positions(:,i)=rand(No_searchagents,1).*(ub_i-lb_i)+lb_i;
    end

end

