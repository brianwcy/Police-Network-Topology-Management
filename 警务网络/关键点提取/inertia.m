function [serial] = inertia(serial,du,node)
%UNTITLED12 此处显示有关此函数的摘要
%   此处显示详细说明
[~,m]=size(serial);
node_num=zeros(node,1);
for i=1:m
    node_num(serial(i))=node_num(serial(i))+1;
end
node_0=find(node_num<du-1);
insert_num=randsample(node_0,1);
b=round(rand()*(m-1)+1);
serial(b)=insert_num;
end

