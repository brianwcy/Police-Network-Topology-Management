function [gbest] = instace1_lmst(node,du,w_range,uav_dis,uav_pos,uav_islink)
%instace1_lmst LMST算法中，以链路长度作为权重,每个节点首先都以最大功率发射信号探
% 测周围拓扑信息，构建局部最小生成树，接着选择生成树中的单跳邻节点作为它的逻辑邻
% 节点，然后调整自身发射功率使其可以满足覆盖最远的逻辑邻节点，最后节点间再通过交
% 换信息去除单向边，得到最终的拓扑优化图。
%   此处显示详细说明
[gbest] = instace1_pso(node,du,w_range,uav_dis,uav_pos,uav_islink);
end

