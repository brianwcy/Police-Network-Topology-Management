function [uav_pos] = nodemobility(uav_pos,uav_amount,uav_v_range,dt,node_mobility)
%UNTITLED4 此处显示有关此函数的摘要
%   此处显示详细说明
switch node_mobility
    case 'RW'
        dir=rand(uav_amount,1)*2*pi;
        v=rand(uav_amount,1)*(uav_v_range(2)-uav_v_range(1))+uav_v_range(1);
        uav_pos(:,1)=uav_pos(:,1)+v.*cos(dir).*dt;
        uav_pos(:,2)=uav_pos(:,2)+v.*sin(dir).*dt;
    case 'RWP'
    case 'RD'
    otherwise
end

% area=[1000 1000];%区域大小
% figure
% plot(uav_pos(:,1),uav_pos(:,2),'s','color','r')   %以x1为横坐标,y1为纵坐标绘制红色方块点图
% for i=1:uav_amount 
%     text(uav_pos(i,1)+0.01,uav_pos(i,2)+0.01,num2str(i)) ; %加上0.01使标号和点不重合，可以调整
% end
% rectangle('position',[0 0 area(1) area(2)],'LineWidth',2,'LineStyle','--');  %中心区域的虚线框
% set(gca,'XLim',[0 area(1)]);        %X轴的数据显示范围
% set(gca,'XTick',[0:100:area(1)]);  %设置要显示的坐标刻度
% set(gca,'YLim',[0 area(2)]);        %Y轴的数据显示范围
% set(gca,'YTick',[0:100:area(2)]);  %设置要显示的坐标刻度

end
