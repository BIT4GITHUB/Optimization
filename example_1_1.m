% example 1_1
clear;clc;
%————可行集————
a=-5;
b=10;
%————作图精度————
step=0.5;
iter=(b-a)/step; %迭代次数
x = a:step:b;
%————目标函数————
y = (x+1).^2+x;
%————作图————
figure
plot(x,y,'r--o','LineWidth',1,'MarkerSize',5)

title('f(x)=(x+1)^2+x','FontSize',20)
xlabel('x')
set(gca, 'XTick', a:step:b) %设置X坐标轴刻度数据点位置 
ylabel('f')
grid on