function [gbest] = instance1_lsp(node,uav_dis,uav_pos,uav_islink)
%instance1_lsp LSP算法中，在局部拓扑图中，以自身为根，得到遍及所有可达节点的最
% 短路径树，该过程可通过Dijkstra算法或者Bellman-Ford算法实现，接着节点将最短路径
% 树上的一跳邻节点作为逻辑邻节点，最后每个节点根据结果自行调整发射功率。
%   此处显示详细说明

for i=1:node
    
    s=i;
    uav_i_islink=uav_islink(i,:);
    t=find(uav_i_islink==1);
    names=[i t];
    m=length(names);
    A=zeros(m,m);
    for j=1:m-1
        for k=j+1:m

            A(j,k)=uav_dis(names(1,j),names(1,k));
            A(k,j)=A(j,k);
        end
    end
    xlabel=zeros(m,1);
    ylabel=zeros(m,1);
    for j=1:m
        xlabel(j)=uav_pos(names(j),1);
        ylabel(j)=uav_pos(names(j),2);
    end
    b={};
    for j=1:m
        b(j)={num2str(names(j))};
    end
    figure
    G = graph(A);
    p = plot(G,'LineWidth',2);% p = plot(G,'LineWidth',2);
    p.XData = xlabel;
    p.YData = ylabel;
    
    figure
    TR = shortestpathtree(G,[1],[2:m]);%以自身为根，得到遍及所有可达节点的最短路径树
    h = plot(TR,'LineWidth',2);
    h.XData = xlabel;
    h.YData = ylabel;
    %合成
end

gbest=[];
end
