function [gbest] = instace1_pso(node,du,w_range,wcom,uav_pos,uav_islink)
%UNTITLED15 此处显示有关此函数的摘要
%   此处显示详细说明

%%预设参数
n=100;%种群初始大小
K=800;%迭代次数

% node=5;%节点个数
% du=4;%度约束
% w_range=[0.4 0.8];

%%分布粒子
population=zeros(1,(du-1)*node);
for i=1:node
    for j=1:du-1
        population(1,(i-1)*(du-1)+j)=i;
    end
end
x=[];
for i=1:n
    x=[x;randsample(population,node-2)];
end


%计算适应度
fit=zeros(n,1);
for j=1:n
    fit(j) = fitness(x(j,:),wcom,uav_islink);
end
%计算个体极值
pbest=x;
ind=find(min(fit)==fit);
gbest=x(ind(1),:);

%%更新速度与位置
for i=1:K
    [n_k,~]=size(x);
    for m=1:n_k
        w=(w_range(2)-w_range(1))*(K-i)/K+w_range(1);
        c1=1-i/K;
        c2=1-c1;
        if(rand<w) 
            x(m,:)=inertia(x(m,:),du,node);
        end
        if(rand<c1) 
            x(m,:)=self_awareness(x(m,:),du,node,pbest(m,:),population);
        end
        if(rand<c2) 
            x(m,:)=social_consciousness(x(m,:),du,node,gbest,population);
        end
        
        %重新计算适应度
        fit(m) = fitness(x(m,:),wcom,uav_islink);
        if fit(m)<fitness(pbest(m,:),wcom,uav_islink)
            pbest(m,:)=x(m,:);
        end
        if fitness(pbest(m,:),wcom,uav_islink)<fitness(gbest,wcom,uav_islink)
            gbest=pbest(m,:);
        end
    end
    fitnessbest(i)=fitness(gbest,wcom,uav_islink);
end

[ni1,nf1]=prufer_decod(gbest);

figure
G = graph(ni1,nf1);
p = plot(G);% p = plot(G,'LineWidth',2)
p.XData = uav_pos(:,1);
p.YData = uav_pos(:,2);


figure
plot(fitnessbest);
xlabel('迭代次数');
ylabel('适应度值');
title('迭代优化过程');

end

