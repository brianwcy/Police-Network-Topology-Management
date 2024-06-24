clc,clear,close all
%% 网络仿真参数
area=[1000 1000];%区域大小
uav_amount=30;%无人机数量15-55
uav_max_er=400;%最大发射半径
%RW移动模型
uav_v_range=[5,30];%速度【vmin，vmax】
dt_max=30;%间隔时间/s
dt=5;%间隔时间/s
du=5;%每个节点的度上限为 5
e0_min=10;e0_max=40;%每个节点 u 的剩余能量为 10~40 之间的随机值
alpha=2;%为路径损耗因子
alpha1=1;alpha2=1;alpha3=1;beta=1;%通信链路的权重函数使用到的权重因子

%% pso参数
iter=800;
w_range=[0.4,0.8];

%% 无人机节点生成

x1=rand(uav_amount,1)*area(1);  %横坐标在(0，1000)范围内，生成1*uav_amount的随机矩阵
y1=rand(uav_amount,1)*area(2);  %纵坐标在(0，1000)范围内，生成1*uav_amount的随机矩阵
uav_pos=[x1,y1];%无人机位置
uav_e0=rand(uav_amount,1)*(e0_max-e0_min)+e0_min;%无人机节点初始剩余能量

% uav_islink=zeros(uav_amount,uav_amount);%两个节点之间存在通信链路;0表示不存在，1表示存在
% uav_dis=zeros(uav_amount,uav_amount);%两个节点之间距离
% uav_rangecnt=zeros(uav_amount,uav_amount);%两个节点通信范围内的所有节点个数;0表示不存在
% w_link=zeros(uav_amount,uav_amount);%通信链路的权重函数
% wcom;带权邻接矩阵

%% 节点运动模型 随机游走模型

for i=1:1
    
    [uav_islink,uav_dis,uav_rangecnt,w_link,wcom,uav_R_ij] = UAV_com_state(uav_amount,uav_pos,uav_max_er,uav_e0,alpha1,alpha2,alpha3,alpha,beta);

    figure
    G = graph(wcom);
    p = plot(G,'LineWidth',2);% p = plot(G,'LineWidth',2);
    p.XData = uav_pos(:,1);
    p.YData = uav_pos(:,2);
    [bins,iC] =  biconncomp(G);
    highlight(p, iC);
    
    %[gbest] = instace1_pso(uav_amount,du,w_range,w_link,uav_pos,uav_islink);
    %[gbest] = instace1_lmst(uav_amount,du,w_range,uav_dis,uav_pos,uav_islink);
    [gbest] = instance1_lsp(uav_amount,uav_dis,uav_pos,uav_islink);
    
    %uav_pos = nodemobility(uav_pos,uav_amount,uav_v_range,dt,'RW');
    
%     figure
%     G = graph(wcom);
%     p = plot(G,'LineWidth',2);% p = plot(G,'LineWidth',2);
%     p.XData = uav_pos(:,1);
%     p.YData = uav_pos(:,2);
%     p.EdgeCData =  biconncomp(G);
end

%% 关键点判断和连通分量分割
%邻接矩阵转节点对组
% ni=[];
% nf=[];
% for i=1:uav_amount
%     for j=i+1:uav_amount
%         if(uav_islink(i,j))
%             ni0=[ni,i];
%             nf0=[nf,j];
%         end
%     end
% end

% Encoding
% ni=[1 2 3 4 5];
% nf=[4 4 4 5 6];
% sequence=prufer_encod(ni0,nf0);

% Decoding
% sequence=[4 4 4 5];
%[ni1,nf1]=prufer_decod(sequence);


%% pso构建最小生成树
% [gbest] = instace1_pso(uav_amount,du,[0.4 0.8],w_link);
% [ni1,nf1]=prufer_decod(gbest);
% 
% figure
% G = graph(ni1,nf1);
% p = plot(G);% p = plot(G,'LineWidth',2);
% p.XData = uav_pos(:,1);
% p.YData = uav_pos(:,2);


%% 网络拓扑图
% figure
% plot(x1,y1,'s','color','r')   %以x1为横坐标,y1为纵坐标绘制红色方块点图
% 
% for i=1:uav_amount
%     text(x1(i)+0.01,y1(i)+0.01,num2str(i)) ; %加上0.01使标号和点不重合，可以调整
% end
%  
% rectangle('position',[-area(1) -area(2) 3.*area(1) 3.*area(2)],'LineWidth',2,'LineStyle','--');  %中心区域的虚线框; [x y w h] 形式的四元素向量。x 和 y 元素定义矩形的左下角的坐标。w 和 h 元素定义矩形的维度。
% set(gca,'XLim',[-area(1) 2*area(1)]);        %X轴的数据显示范围
% set(gca,'XTick',[-area(1):100: 2*area(1)]);  %设置要显示的坐标刻度
% set(gca,'YLim',[-area(2) 2*area(2)]);        %Y轴的数据显示范围
% set(gca,'YTick',[-area(2):100: 2*area(2)]);  %设置要显示的坐标刻度

%% 性能评估指标
%[eva1,eva2,eva3,eva4,eva5,eva6] = instance1_evalution(gbest,uav_pos,uav_rangecnt,uav_islink,uav_dis,uav_R_ij,uav_amount);
