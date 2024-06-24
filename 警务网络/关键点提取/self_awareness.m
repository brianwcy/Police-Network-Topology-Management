function [serial] = self_awareness(serial,du,node,pbest,population)
%UNTITLED13 此处显示有关此函数的摘要
%   此处显示详细说明
[~,m]=size(serial);
k1=round(rand()*(m-1)+1);
k2=round(rand()*(m-1)+1);
serial(k1:k2)=pbest(k1:k2);

node_num=zeros(node,1);
for i=1:m
    node_num(serial(i))=node_num(serial(i))+1;
end
node_0=find(node_num>du-1);
if ~isempty(node_0)
    serial=randsample(population,node-2);
end

end

