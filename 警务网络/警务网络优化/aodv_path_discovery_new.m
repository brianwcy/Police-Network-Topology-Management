function [path,hop] = aodv_path_discovery_new(nodes_number,nodes_link,s,d,Fload ,PLest ,BREAK);


visited(1:nodes_number)  = 0;   
distance(1:nodes_number) = inf;  
parent(1:nodes_number)   = 0;
distance(s)              = 0; 
Fs(1:nodes_number)       = 0;  
Ps(1:nodes_number)       = 0;  
Bs(1:nodes_number)       = 0;  

Gs(1:nodes_number) = inf;  
Gs(s)              = 0; 

for i = 1:nodes_number   
    temp = [];  
    for h = 1:nodes_number   
        if visited(h) == 0 
           temp=[temp Gs(h)];  
        else
           temp=[temp inf];
        end
    end;   
    
    
    %����temp����Сֵ������
    [t,u]      = min(temp); 
    visited(u) = 1;  
    for v = 1:nodes_number 
        if ((nodes_link(u,v) + distance(u)) < distance(v)) 
            distance(v) = distance(u) + nodes_link(u,v); 
            Fs(v)       = Fs(u) + Fload(v);
            Ps(v)       = Ps(u) + 1/PLest(v);
            
              if BREAK(v) == 1
                 Gs(v) = (distance(v) + Fs(v) + Ps(v))/3;
              else
                 Gs(v) = inf; 
              end
            
            parent(v)   = u; 
        end;             
    end;
end;

path = [];
if parent(d) ~= 0 
    t = d;
    path = [d];
    while t ~= s
        p = parent(t);
        path = [p path];
        t = p;      
    end;
end;

hop = distance(d);

return;

