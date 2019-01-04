function [ fobj,dimension,lb,ub ] = Function_details( F )

switch F
    case 'Fun1'
        fobj = @F1;
        dimension = 1;
        lb = -10;
        ub = 10;
    case 'Fun2'
        fobj = @F2;
        dimension = 2;
        lb = -20;
        ub = 20;
    case 'F20'
        fobj = @F20;
        lb=0;
        ub=1;
        dimension=6; 
end

end

function f = F1(x)
    f = 2*x.^2+3*x-5;
end

function f = F2(x)
    f = sin(x(1)) + cos(x(2));
end

function f = F20(x)
aH=[10 3 17 3.5 1.7 8;.05 10 17 .1 8 14;3 3.5 1.7 10 17 8;17 8 .05 10 .1 14];
cH=[1 1.2 3 3.2];
pH=[.1312 .1696 .5569 .0124 .8283 .5886;.2329 .4135 .8307 .3736 .1004 .9991;...
.2348 .1415 .3522 .2883 .3047 .6650;.4047 .8828 .8732 .5743 .1091 .0381];
f=0;
for i=1:4
    f=f-cH(i)*exp(-(sum(aH(i,:).*((x(i)-pH(i,:)).^2))));
end
end