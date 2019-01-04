function GWOvelocity = GWOvelocityF(a,Position,...
    Alpha_pos,Beta_pos,Delta_pos,D)
            r1=rand(1,D); 
            r2=rand(1,D); 
            
            A1=2*a.*r1-a; 
            C1=2.*r2;     
            
            D_alpha=abs(C1.*Alpha_pos-Position); 
            X1=Alpha_pos-A1.*D_alpha; 
                       
            r1=rand(1,D);
            r2=rand(1,D);
            
            A2=2*a.*r1-a;
            C2=2.*r2;
            
            D_beta=abs(C2.*Beta_pos-Position);
            X2=Beta_pos-A2.*D_beta;   
            
            r1=rand(1,D);
            r2=rand(1,D); 
            
            A3=2*a.*r1-a; 
            C3=2.*r2; 
            
            D_delta=abs(C3.*Delta_pos-Position);
            X3=Delta_pos-A3.*D_delta;  
            
            GWOvelocity=(X1+X2+X3)/3-Position;
end

