function [eva1,eva2,eva3,eva4,eva5,eva6] = instance1_evalution(gbest,uav_pos,uav_rangecnt,uav_islink,uav_dis,uav_R_ij,uav_amount)
%instance1_evalution pso性能评估指标
%eva1 平均节点度
%eva2 平均干扰度
%eva3 平均路径长度
%eva4 平均链路长度
%eva5 连通率
%eva6 链路鲁棒性



[ni1,nf1]=prufer_decod(gbest);
[~,n]=size(ni1);
weights=zeros(n);
for i=1:n
    weights(i)=uav_dis(ni1(i),nf1(i));
end

figure
G = graph(ni1,nf1,weights);
p = plot(G);% p = plot(G,'LineWidth',2)
p.XData = uav_pos(:,1);
p.YData = uav_pos(:,2);

%1.平均节点度
eva1=mean(degree(G));
%2.平均干扰度

sum_interfere=0;
for i=1:n
    sum_interfere=sum_interfere+uav_rangecnt(ni1(i),nf1(i));
end
all_interfere=0;
for i=1:uav_amount
    for j=i+1:uav_amount
        all_interfere=all_interfere+uav_islink(i,j);
    end
end
eva2=sum_interfere/all_interfere;
%3.平均路径长度
eva3=distances(G);%如果图进行了加权（即 G.Edges 包含变量 Weight），则这些权重用作沿图中各边的距离。否则，所有边距离都视为 1。
%4.平均链路长度
eva4=distances(G);
%5.连通率
eva5=sum(sum(uav_islink))/(uav_amount*(uav_amount-1));
%6.链路鲁棒性
eva6=0;
for i=1:uav_amount
    for j=i+1:uav_amount
        eva6=eva6+uav_R_ij(i,j);
    end
end
eva6=2*eva6/(uav_amount*(uav_amount-1));
end

