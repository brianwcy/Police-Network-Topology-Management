x = linspace(0, 40, 40);
%x的定义域（-2*pi, 2*pi），精度——共生成50个等间隔分布的点
y = linspace(0, 40, 40);
%同理，y的定义域（-pi, pi），生成40个等间隔分布的点
[X,Y] = meshgrid(x,y);

Z =X.*Y./sqrt(X.^2+Y.^2);
%给定的函数

%划分网格
surf(X,Y,Z);
% 绘制三维曲面图
