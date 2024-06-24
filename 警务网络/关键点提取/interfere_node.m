function [inter] = interfere_node(u,v,uav_dis)
%UNTITLED20 此处显示有关此函数的摘要
%   此处显示详细说明
dis_u=uav_dis(u,:);
dis_u(dis_u<dis_u(v))=0;


dis_v=uav_dis(v,:);
dis_v(dis_v<dis_v(u))=0;

aa=union(find(dis_u==0),find(dis_v==0));
inter=length(aa)-2;
end

