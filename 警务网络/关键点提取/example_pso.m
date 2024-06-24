%粒子群 PSO  线性递减权重
clear 
clc
close all
%%预设参数
n=100;%种群初始大小
node=5;%节点个数
du=4;%度约束

c1=2;
c2=2;
K=800;
w_range=[0.4 0.8];
wcom=[];
%%分布粒子
population=zeros(1,(du-1)*node);
for i=1:node
    for j=1:du-1
        population(1,(i-1)*(du-1)+j)=i;
    end
end
for i=1:n
    x=[x;randsample(population,node-2)];
end


%计算适应度
fit=zeros(n,1);
for j=1:n
    fit(j) = fitness(x(j,:),wcom);
end
%计算个体极值
pbest=x;
ind=find(min(fit)==fit);
gbest=x(ind,:);

%%更新速度与位置
for i=1:K
    for m=1:n
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
        fit(m) = fitness(x(m,:),wcom);
        if fit(m)<fitness(pbest(m,:))
            pbest(m,:)=x(m,:);
        end
        if fitness(pbest(m,:))<fitness(gbest)
            gbest=pbest(m,:);
        end
    end
    fitnessbest(i)=fitness(gbest);
end
plot(fitnessbest);
xlabel('迭代次数');
ylabel('适应度值');
title('迭代优化过程');
