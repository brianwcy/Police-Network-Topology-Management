function [outputArg1] = instace1_normalize(inputArg1)
%不包括主对角线的上三角矩阵标准化
%   此处显示详细说明
[m,~]=size(inputArg1);
arg2=[];
for i=1:m-1
    arg2=[arg2,inputArg1(i,i+1:m)];
end
mean_arg2=mean(arg2);
std_arg2=std(arg2);
outputArg1 = (inputArg1-mean_arg2)./(std_arg2);
end

