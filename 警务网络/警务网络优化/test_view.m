% str1='\fontsize{14}\fontname{����}�·�12345\fontname{Euclid}(12345)';
% str2='\fontsize{14}\fontname{����}��Ӫҵ��\fontname{Time New Roman}($)';
% xlabel(str1)
% ylabel(str2)


clc;
clear;
% close all;
warning off;
addpath(genpath(pwd));
rng('default')


figure;
load data_save\r2_1.mat
plot(Throughput,'LineWidth', 1.5,'Color',[239,0,0]/255);
hold on
load data_save\r1_1.mat
plot(Throughput,'-.','linewidth',1.5,'Color',[51,102,153]/255);
hold on
load data_save\r0_1.mat
plot(Throughput,'--','linewidth',1.5,'Color',[254,194,17]/255);
hold on

%legend('HSL-DQN','Double DQN','ACO-RB');
legend1={'\fontsize{10.5}\fontname{Times New Roman}HSL-DQN','\fontsize{10.5}\fontname{Times New Roman}Double DQN','\fontsize{10.5}\fontname{Times New Roman}ACO-RB'};
h =legend(legend1,'Location','Best','AutoUpdate','off');
set(h,'FontName','����','FontSize',10.5,'FontWeight','normal')
% h.ItemTokenSize = [6,4];%����ͼ�������ĳ���
legend boxoff;

grid on;
str1='\fontsize{10.5}\fontname{����}ʱ��\fontsize{10.5}\fontname{Times New Roman}(s)';
str2='\fontsize{10.5}\fontname{����}ƽ��������\fontsize{10.5}\fontname{Times New Roman}/Mbps';
xlabel(str1);
ylabel(str2);
xlim([0 5000])


figure;
load data_save\r0_1.mat
plot(Power,'linewidth',1.5,'Color',[239,0,0]/255);
hold on
load data_save\r1_1.mat
plot(Power,'-.','linewidth',1.5,'Color',[51,102,153]/255);
hold on
load data_save\r2_1.mat
plot(Power,'--','linewidth',1.5,'Color',[254,194,17]/255);
hold on


h =legend(legend1,'Location','Best','AutoUpdate','off');
set(h,'FontName','����','FontSize',10.5,'FontWeight','normal')
% h.ItemTokenSize = [6,4];%����ͼ�������ĳ���
legend boxoff;

grid on;
str2='\fontsize{10.5}\fontname{����}ƽ���ӳ�\fontsize{10.5}\fontname{Times New Roman}(ms)';
xlabel(str1);
ylabel(str2);%������������
xlim([0 5000])


figure;
load data_save\r1_1.mat
plot(Loads,'linewidth',1,'Color',[239,0,0]/255);
hold on
load data_save\r0_1.mat
plot(Loads,'-.','linewidth',1,'Color',[51,102,153]/255);
hold on
load data_save\r2_1.mat
plot(Loads,'--','linewidth',1,'Color',[254,194,17]/255);
hold on


h =legend(legend1,'Location','Best','AutoUpdate','off');
set(h,'FontName','����','FontSize',10.5,'FontWeight','normal')
% h.ItemTokenSize = [6,4];%����ͼ�������ĳ���
legend boxoff;

grid on;
str2='\fontsize{10.5}\fontname{����}���ؾ����\fontsize{10.5}\fontname{Times New Roman}';
xlabel(str1);
ylabel(str2);
xlim([0 2500])


figure;
load data_save\r0_1.mat
plot(droprate,'linewidth',1,'Color',[239,0,0]/255);
hold on
load data_save\r1_1.mat
plot(droprate,'-.','linewidth',1,'Color',[51,102,153]/255);
hold on
load data_save\r2_1.mat
plot(droprate,'--','linewidth',1,'Color',[254,194,17]/255);
hold on


h =legend(legend1,'Location','Best','AutoUpdate','off');
set(h,'FontName','����','FontSize',10.5,'FontWeight','normal')
% h.ItemTokenSize = [6,4];%����ͼ�������ĳ���
legend boxoff;

grid on;
str2='\fontsize{10.5}\fontname{����}ƽ��������\fontsize{10.5}\fontname{Times New Roman}(%)';
xlabel(str1);
ylabel(str2);
xlim([0 5000])


figure;
load data_save\r2_1.mat
plot(death,'linewidth',1,'Color',[239,0,0]/255);
hold on
load data_save\r1_1.mat
plot(death,'-.','linewidth',1,'Color',[51,102,153]/255);
hold on
load data_save\r0_1.mat
plot(death,'--','linewidth',1,'Color',[254,194,17]/255);
hold on

h =legend(legend1,'Location','Best','AutoUpdate','off');
set(h,'FontName','����','FontSize',10.5,'FontWeight','normal')
%h.ItemTokenSize = [6,4];%����ͼ�������ĳ���
legend boxoff;

grid on;
str2='\fontsize{10.5}\fontname{����}ƽ����·����\fontsize{10.5}\fontname{Times New Roman}';
xlim([0 5000])

xlabel(str1);
ylabel(str2);%�����ڵ���