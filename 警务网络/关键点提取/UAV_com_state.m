function [uav_islink,uav_dis,uav_rangecnt,w_link,wcom,uav_R_ij] = UAV_com_state(uav_amount,uav_pos,uav_max_er,uav_e0,alpha1,alpha2,alpha3,alpha,beta)
%UNTITLED3 此处显示有关此函数的摘要
%输出参数
% uav_islink:两个节点之间存在通信链路;0表示不存在，1表示存在
% uav_dis:两个节点之间距离
% uav_rangecnt:两个节点通信范围内的所有节点个数
% w_link:通信链路的权重函数
%uav_R_ij:通信链路的健壮性
uav_islink=zeros(uav_amount,uav_amount);%两个节点之间存在通信链路;0表示不存在，1表示存在
uav_dis=zeros(uav_amount,uav_amount);%两个节点之间距离
for i=1:uav_amount-1
    for j=i+1:uav_amount
        uav_dis(i,j)=sqrt(sumsqr(uav_pos(i,:)-uav_pos(j,:)));
        uav_dis(j,i)=uav_dis(i,j);
        if(uav_dis(i,j)<=uav_max_er)
            uav_islink(i,j)=1;
            uav_islink(j,i)=1;
        end
    end
end

uav_rangecnt=zeros(uav_amount,uav_amount);%两个节点通信范围内的所有节点个数;0表示不存在
for i=1:uav_amount-1
    for j=i+1:uav_amount
        
        uav_rangecnt(i,j)=interfere_node(i,j,uav_dis);
        uav_rangecnt(j,i)=uav_rangecnt(i,j);
        
%         aa=uav_islink(i,:)+uav_islink(j,:);
%         aa(aa~=0)=1;
%         if(~uav_islink(i,j))            
%             uav_rangecnt(i,j)=sum(aa);
%             uav_rangecnt(j,i)=uav_rangecnt(i,j);
%         else
%             uav_rangecnt(i,j)=sum(aa)-2;
%             uav_rangecnt(j,i)=uav_rangecnt(i,j);
%         end

    end
end

%标准化
nor_uav_dis=instace1_normalize(uav_dis.^alpha);

nor_uav_rangecnt=instace1_normalize(uav_rangecnt);

uav_Rij=zeros(uav_amount,uav_amount);
for i=1:uav_amount-1
    for j=i+1:uav_amount
        uav_Rij(i,j)=uav_e0(i).*uav_e0(j)./sqrt(uav_e0(i).^2+uav_e0(j).^2);
        uav_Rij(j,i)=uav_Rij(i,j);
    end
end
uav_R_ij=uav_Rij;
uav_Rij(uav_Rij~=0)=1./(uav_Rij(uav_Rij~=0).^beta);
uav_Rij=instace1_normalize(uav_Rij);

w_link=zeros(uav_amount,uav_amount);%通信链路的权重函数
for i=1:uav_amount-1
    for j=i+1:uav_amount
        %uav_Rij=uav_e0(i).*uav_e0(j)./sqrt(uav_e0(i).^2+uav_e0(j).^2);
        %w_link(i,j)=alpha1.*uav_dis(i,j).^alpha+alpha2.*uav_rangecnt(i,j)+alpha3./uav_Rij.^beta;%没有归一化
        w_link(i,j)=alpha1.*nor_uav_dis(i,j)+alpha2.*nor_uav_rangecnt(i,j)+alpha3.*uav_Rij(i,j);
        w_link(j,i)=w_link(i,j);
    end
end
wcom=uav_islink.*w_link;
end

