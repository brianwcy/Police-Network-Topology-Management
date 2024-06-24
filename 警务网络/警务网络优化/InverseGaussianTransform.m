clear all;
clc;
format long
[filename,pathname]=uigetfile('*.*');%文件查找窗口
file=fullfile(pathname,filename);%合并路径文件名
A=importdata(file);%将生成的文件导入工作空间，变量名为A
A.data(:,3)=177*ones(10051632,1);
[L,B]=GaussianMapInverse(A.data(:,1),A.data(:,2),dms2rad(A.data(:,3)));
C=[L,B];%C为重组矩阵
[filename_out,pathname_out]=uiputfile('*.txt','请输入文件名');
%文件查找窗口
fileout=fullfile(pathname_out,filename_out);%合并路径文件名
fid=fopen(fileout,'wt');%新建打开txt文件
[a b]=size(C);
for i=1:a
    fprintf(fid,'%.10f %.10f\n',C(i,:));
end
fclose(fid);