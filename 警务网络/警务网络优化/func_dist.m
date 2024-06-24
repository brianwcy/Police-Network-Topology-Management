function [xs,ys,d,iscom]=func_dist(POS,N_node,R);
xs     = 0;
ys     = 0;
d      = zeros(N_node,N_node);
iscom  = zeros(N_node,N_node);

for i=1:1:N_node
    for j=1:1:N_node
        if i == j 
           d(i,j) = 0;
        else
           xs     =(POS(i,1)-POS(j,1))*(POS(i,1)-POS(j,1));
           ys     =(POS(i,2)-POS(j,2))*(POS(i,2)-POS(j,2));
           d(i,j) = sqrt(xs+ys);
        end
        %判断是否在通信范围之内
        if d(i,j) <= R & d(i,j) > 0
           iscom(i,j) = 1;
        else
           iscom(i,j) = 0; 
        end
    end
end