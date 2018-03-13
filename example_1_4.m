% example 2 
clear;clc;
%————可行集————
a = 100;
b = 4500;
%————作图精度————
step=1;
iter=(b-a)/step; %迭代次数
x = a:step:b;

%————目标函数————
N=200099;
y = mod(N,x);
%————作图————
figure
plot(x,y,'r--o','LineWidth',1,'MarkerSize',5)
xlabel('x')
set(gca, 'XTick', a:10*step:b) %设置X坐标轴刻度数据点位置 
ylabel('f')
grid on

title('f(x)=Nmodx','FontSize',20)

