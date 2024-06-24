function [Throughput,Power,Loads,droprate,death] = func_AODV_performance(Radius,nodes_link,A,PACK,nodes_number,Times,X,Y,Channel_Sel,POWERS,POWERS2,SNRs);


%%
%1.初始参数设定模块
%节点区域界限
xm     = A;
ym     = A;
%汇聚节坐标给定
sink.x = xm/2;
sink.y = ym/2;
%区域内节数
n      = nodes_number;
%初始化能量模型
Eo     = 0.5;
%Eelec=Etx=Erx
ETX    = POWERS*1e-9;
ERX    = POWERS*1e-9;
%Transmit Amplifier types
Efs    = 10    *1e-12;
Emp    = 0.0013*1e-12;
%Data Aggregation Energy
EDA    = 5*1e-9;
%高能量节点超出一节点能量的百分比
a      = 1;
%最大循环次数
rmax   = Times;
%算出参数 do
do     = Radius;
Et     = 0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               

%%
%这个部分和LEACH的相同
%2.网络模型产生模块
for i=1:1:n
    S3(i).xd   = X(i);
    XR3(i)     = S3(i).xd;    
    S3(i).yd   = Y(i);
    YR3(i)     = S3(i).yd;
    S3(i).G    = 0;
    S3(i).E    = Eo*(1+rand*a);
    E3(i)      = S3(i).E;
    Et         = Et+E3(i);
    S3(i).type = 'N';
end

d1         = 0.765*xm/2;
K          = sqrt(2*n*do/pi)*xm/d1^2;
d2         = xm/sqrt(2*pi*K);
Er         = PACK*(2*n*ETX+n*EDA+K*Emp*d1^4+n*Efs*d2^2);
S3(n+1).xd = sink.x;
S3(n+1).yd = sink.y;


%%
%3.网络运行模块
countCHs3         = 0;
cluster3          = 1; 
flag_first_dead3  = 0;
flag_teenth_dead3 = 0;
flag_all_dead3    = 0;
%死亡节点数
dead3             = 0;
first_dead3       = 0;
teenth_dead3      = 0;
all_dead3         = 0;
%活动节点数
allive3           = n;
packets_TO_BS3    = 0;
packets_TO_CH3    = 0;


%%%%%%%%%%%%以上参数初始化三个程序都相同%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%以上参数初始化三个程序都相同%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


for r=0:1:rmax
    r
    Ea       = Et;
    El3(r+1) = 0;
    for i=1:nodes_number
        El3(r+1) = S3(i).E + El3(r+1);
    end
    Ec3(r+1) = Et-El3(r+1);
    
    %死亡节点检查
    Dead_time = 0;
    for i=1:n
        %节点能量用完，则说明节点死亡
        if S3(i).E <= 0 
           Dead_time = Dead_time + 1; 
        else
           S3(i).type = 'N';
           Dead_time = Dead_time; 
        end
    end
    
    STATISTICS.DEAD3(r+1)  = Dead_time;

    countCHs3 = 0;
    cluster3  = 1;
    for i = 1:n
        if Ea > 0 & S3(i).E > 0 & S3(i).G <= 0      
           if  rand<= 0.2
               countCHs3             = countCHs3+1;
               packets_TO_BS3        = packets_TO_BS3+1;
               PACKETS_TO_BS3(r+1)   = packets_TO_BS3;
               S3(i).type            = 'C';
               C3(cluster3).xd       = S3(i).xd;
               C3(cluster3).yd       = S3(i).yd;
               distance              = sqrt((S3(i).xd-(S3(n+1).xd) )^2 + (S3(i).yd-(S3(n+1).yd))^2 );
               C3(cluster3).distance = distance;
               C3(cluster3).id       = i;
               X3(cluster3)          = S3(i).xd;
               Y3(cluster3)          = S3(i).yd;
               cluster3              = cluster3+1;
               %计算簇头发送4000bit数据的能量消耗
               if distance > do  
                  S3(i).E = S3(i).E - ((ETX+EDA)*(PACK) + Emp*PACK*(distance*distance*distance*distance)); 
               end
               if distance <= do  
                  S3(i).E = S3(i).E - ((ETX+EDA)*(PACK) + Efs*PACK*(distance * distance)); 
               end
           end
        end
    end

    STATISTICS.COUNTCHS3(r+1) = countCHs3;

    x3 = zeros(1,cluster3-1);
    y3 = 0;
    z3 = 0;
    Drop_rate0 = zeros(1,n);
  
    %产生不同的路由路径，用来进行综合分析
    PATH = [];
    Nums = 1:n;
    nn   = n;
    for js = 1:n/2
        tmps = randperm(nn);
        if js > 1
           I1 = find(tmps == tmps1);
           I2 = find(tmps == tmps2);
           tmps(I1)=0;
           tmps(I2)=0;
           tmps(find(tmps==0)) = [];
        end
        SS   = tmps(1);
        DD   = tmps(2);
        %根据原节点和目标节点进行路由跟新
        [path,hop] = aodv_path_discovery(n,nodes_link,SS,DD);
        PATH     = [PATH,path];
        tmps1    = SS;
        tmps2    = DD;
    end
    
    for ind=1:length(PATH)
        i = PATH(ind);
        if S3(i).type=='N' && S3(i).E>0
           if cluster3-1 >= 1
              min_dis         = Inf;
              min_dis_cluster = 0;
              for c=1:cluster3-1
                  temp = min(min_dis,sqrt((S3(i).xd-C3(c).xd)^2 + (S3(i).yd-C3(c).yd)^2));
                  if temp < min_dis
                     min_dis         = temp;
                     min_dis_cluster = c;
                     x3(c)           = x3(c)+1;
                  end
              end
              %簇内节点能量消耗
              if min_dis > do 
                 S3(i).E=S3(i).E- (ETX*(PACK) + Emp*PACK*( min_dis * min_dis * min_dis * min_dis)); 
              end
              if min_dis <= do 
                 S3(i).E=S3(i).E- (ETX*(PACK) + Efs*PACK*( min_dis * min_dis)); 
              end
              S3(C3(min_dis_cluster).id).E = S3(C3(min_dis_cluster).id).E- ( (ERX + EDA)*PACK ); 
              packets_TO_CH3               = packets_TO_CH3+1;
              S3(i).min_dis                = min_dis;
              S3(i).min_dis_cluster        = min_dis_cluster;
           else
              y3      = y3+1;
              min_dis = sqrt( (S3(i).xd-S3(n+1).xd)^2 + (S3(i).yd-S3(n+1).yd)^2 );
              if min_dis > do 
                 S3(i).E=S3(i).E- ( ETX*(PACK) + Emp*PACK*( min_dis * min_dis * min_dis * min_dis)); 
              end
              if min_dis <= do 
                 S3(i).E=S3(i).E- ( ETX*(PACK) + Efs*PACK*( min_dis * min_dis)); 
              end
              if rand < 0.2
                 packets_TO_BS3=packets_TO_BS3+1;
              end
           end
        end
        
       %计算丢包率
       if Channel_Sel == 1
          L = 38.5 + 20*log10(min_dis); 
       else
          R     = 1; 
          fai   = pi/3;
          lemda = 150;
          ge1= 1;
          ge2= 1;
          dr = 4;
          Cs = pi/8;
          Gp = 23;
          Aa = 18;
          
          dd2= min_dis;
          dd = min_dis;
          a  = 6370000*(1-0.04665*exp(0.005577))^(-1);
          D  = (1+2*d1*d2/a/dd2/tan(fai))^(-0.5); 
          Re = D*R*exp(-0.6*dd*sin(fai)/lemda); 
          L  =-10*log10(ge1*ge2*(1+Re^2 - 2*Re*cos(2*pi*dr/lemda-Cs))) + Gp + Aa;
       end
       %统计丢包率 
       if rand < 0.2
           Drop_rate0(i) = 0.5*erfc(sqrt(2*(SNRs+10^(-L/20))));  
       end
    end


    if countCHs3~=0
        %统计
       for c=1:cluster3-1
           z3=z3+x3(c);
       end
       LBF3(r+1)=z3/countCHs3;
    else
       LBF3(r+1)=0;
    end

    STATISTICS.PACKETS_TO_CH3(r+1) = packets_TO_CH3;
    STATISTICS.PACKETS_TO_BS3(r+1) = packets_TO_BS3;
    if countCHs3~=0
       Drop_rate(r+1)  = mean(Drop_rate0);
    else
       Drop_rate(r+1)  = 0; 
    end
    if r <= 128
       LBF3t(r+1)      = mean(LBF3(1:r));
       Drop_ratet(r+1) = mean(Drop_rate(1:r));
    else
       LBF3t(r+1)      = mean(LBF3(r-127:r));
       Drop_ratet(r+1) = mean(Drop_rate(r-127:r));
    end
end

Throughput = STATISTICS.PACKETS_TO_BS3 + STATISTICS.PACKETS_TO_CH3;
Power      = Ec3;
Loads      = PACK*LBF3t;
droprate   = Drop_ratet;
death      = STATISTICS.DEAD3;

%free 
if Channel_Sel == 1
   save data_save\r1_1.mat Throughput Power Loads droprate death
end
%two-ray
if Channel_Sel == 2
   save data_save\r1_2.mat Throughput Power Loads droprate death
end