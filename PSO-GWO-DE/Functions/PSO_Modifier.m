function [w,GAMMA] = PSO_Modifier(w,wdamp,GAMMA,Gdamp)
%PSO_MODIFIER this function modifies PSO parameters like w and GAMMA

    if w<0.4
        w=0.9;
    else
        w=w*wdamp;
    end 
    if GAMMA<0.2
        GAMMA=0.9;
    else
        GAMMA=GAMMA*Gdamp;
    end
    
end

