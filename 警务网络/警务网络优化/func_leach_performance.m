function [Throughput,Power,Loads,droprate,death] = func_leach_performance(Radius,A,PACK,nodes_number,Times,X,Y,Channel_Sel,POWERS,POWERS2,SNRs);
 
%%
%1.��ʼ�����趨ģ��
%�ڵ��������
xm     = A;
ym     = A;
%��۽��������
sink.x = xm/2;
sink.y = ym/2;
%�����ڽ���
n      = nodes_number-1;
%��ͷ�Ż�����
P      = 0.2;
%��ʼ������ģ��
Eo     = 0.5;
%Eelec=Etx=Erx
ETX    = POWERS*1e-9;
ERX    = POWERS*1e-9;
%Transmit Amplifier types
Efs    = 10    *1e-12;
Emp    = 0.0013*1e-12;
%Data Aggregation Energy
EDA    = 5*1e-9;
%�������ڵ㳬��һ�ڵ������İٷֱ�
a      = 1;
%���ѭ������
rmax   = Times;
%������� do
do     = Radius;
Et     = 0;

%%
%2.����ģ�Ͳ���ģ��
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
%3.��������ģ��
%��ͷ�ڵ���
countCHs3         = 0;
cluster3          = 1; 
flag_first_dead3  = 0;
flag_teenth_dead3 = 0;
flag_all_dead3    = 0;
%�����ڵ���
dead3             = 0;
first_dead3       = 0;
teenth_dead3      = 0;
all_dead3         = 0;
%��ڵ���
allive3           = n;
packets_TO_BS3    = 0;
packets_TO_CH3    = 0;

for r=0:1:rmax
    r
    if mod(r,round(1/P))==0 
       for i=1:1:n
           S3(i).G  = 0;
           S3(i).cl = 0;
       end
    end
    
    Ea       = Et*(1-r/rmax)/n;
    El3(r+1) = 0;
    for i=1:n
        El3(r+1) = S3(i).E+El3(r+1);
    end
    Ec3(r+1) = Et-El3(r+1);
    
    %(2)�����ڵ���ģ��
    dead3 = 0;
    for i=1:n
        %������������ڵ�
        if S3(i).E <= 0 
           dead3 = dead3 + 1; 
           %��һ�������ڵ�Ĳ���ʱ��(���ִα�ʾ)
           if dead3 == 1%��һ���ڵ�����ʱ��
              if flag_first_dead3 == 0
                 first_dead3      = r;
                 flag_first_dead3 = 1;
              end
           end
           %20%�ڵ�����ʱ��
           if dead3 == 0.2*n 
              if flag_teenth_dead3 == 0 
                 teenth_dead3      = r;
                 flag_teenth_dead3 = 1;
              end
           end
           if dead3 == n 
              if flag_all_dead3 == 0
                 all_dead3      = r;
                 flag_all_dead3 = 1;
              end
           end
        end
        if S3(i).E > 0
           S3(i).type = 'N';
        end
    end
    STATISTICS.DEAD3(r+1)  = dead3;
    STATISTICS.ALLIVE3(r+1)= allive3 - dead3;
    
    %��ͷѡ��ģ��
    countCHs3 = 0;
    cluster3  = 1;
    for i = 1:n
        if Ea > 0
           p(i) = P*n*S3(i).E*E3(i)/(Et*Ea);
           if S3(i).E > 0 
              temp_rand = rand;     
              if (S3(i).G) <= 0  
              %��ͷ��ѡ�٣���ѡ�Ĵ�ͷ��Ѹ�������Ŵ�����������������ı�����
                 if temp_rand<= (p(i)/(1-p(i)*mod(r,round(1/p(i)))))
                    countCHs3             = countCHs3+1;
                    packets_TO_BS3        = packets_TO_BS3+1;
                    PACKETS_TO_BS3(r+1)   = packets_TO_BS3;
                    S3(i).type            = 'C';
                    S3(i).G               = round(1/p(i))-1;
                    C3(cluster3).xd       = S3(i).xd;
                    C3(cluster3).yd       = S3(i).yd;
                    
                    distance              = sqrt((S3(i).xd-(S3(n+1).xd) )^2 + (S3(i).yd-(S3(n+1).yd))^2 );
                    C3(cluster3).distance = distance;
                    C3(cluster3).id       = i;
                    X3(cluster3)          = S3(i).xd;
                    Y3(cluster3)          = S3(i).yd;
                    cluster3              = cluster3+1;
                    %�����ͷ����4000bit���ݵ���������
                    if distance > do  
                       S3(i).E = S3(i).E - 2*((ETX+EDA)*(PACK) + Emp*PACK*(distance*distance*distance*distance)); 
                    end
                    if distance <= do  
                       S3(i).E = S3(i).E - 2*((ETX+EDA)*(PACK) + Efs*PACK*(distance * distance)); 
                    end
                 end
              end
           end
        end
    end
    STATISTICS.COUNTCHS3(r+1) = countCHs3;
    %(5)���ڳ�Աѡ���ͷģ��(���ص��γ�ģ��)
    for c=1:cluster3-1
        x3(c)=0;
    end
    y3 = 0;
    z3 = 0;
    Drop_rate0 = zeros(1,n);
    for i=1:n
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
              %���ڽڵ㣨����4000bit���ݣ���������
              if min_dis > do 
                 S3(i).E=S3(i).E- 2*(ETX*(PACK) + Emp*PACK*( min_dis * min_dis * min_dis * min_dis)); 
              end
              if min_dis <= do 
                 S3(i).E=S3(i).E- 2*(ETX*(PACK) + Efs*PACK*( min_dis * min_dis)); 
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
              packets_TO_BS3=packets_TO_BS3+1;
           end
        end
       %���㶪����
       if Channel_Sel == 1
          L = 38.5 + 20*log10(min_dis); 
       else
          R  = 1; 
          dd2= min_dis;
          fai= pi/3;
          dd = min_dis;
          lemda= 150;
          ge1= 1;
          ge2= 1;
          dr = 4;
          Cs = pi/8;
          a  = 6370000*(1-0.04665*exp(0.005577))^(-1);
          D  = (1+2*d1*d2/a/dd2/tan(fai))^(-0.5); 
          Re = D*R*exp(-0.6*dd*sin(fai)/lemda); 
          Gp = 23;
          Aa = 18;
          L  =-10*log10(ge1*ge2*(1+Re^2 - 2*Re*cos(2*pi*dr/lemda-Cs))) + Gp + Aa;
       end
       %ͳ�ƶ�����   
       if rand < 0.2
           Drop_rate0(i) = 0.5*erfc(sqrt(2*(SNRs+10^(-L/20))));  
       end
    end

    if countCHs3~=0
        %ͳ��
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
    Drop_rate(r+1)                 = mean(Drop_rate0);
    else
    Drop_rate(r+1)                 = 0;
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
   save data_save\r0_1.mat Throughput Power Loads droprate death
end
%two-ray
if Channel_Sel == 2
   save data_save\r0_2.mat Throughput Power Loads droprate death
end


