%% 最速下降法
% f_change为改变前后的y值变化，仅设置了一个退出条件。
clear;clc
%————目标函数及其图像————
a = -1.5; b = 1.5; step=0.05;
iter=(b-a)/step; %迭代次数
xx1 = a:step:b; xx2 = a:step:b;
[x1,x2]=meshgrid(xx1,xx2);
y = 0.2.*(x1).^2+(x2).^2;
figure; scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz); % 生成一个窗口最大化的figure
surf(x1,x2,y,'EdgeColor','none');pause(0.2);
figure; scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz);
contour(x1,x2,y,20,'ShowText','on')
hold on
title('f(x_1,x_2)=0.2(x_1)^2+(x_2)^2','FontSize',20)
%————设置算法的步长,初始值,迭代记录数————
x=[2, 2];
Q=[0.4, 0; 0, 2];
k=0; 
%————停止规则的参数————
f_change  = 0.2*x(1)^2+x(2)^2;              % 初始化差值
f_current = 0.2*x(1)^2+x(2)^2;              % 计算当前函数值
%————最速下降法————
while f_change>0.000000001              % 设置条件，两次计算的值之差小于某个数，跳出循环
    gf=[0.2*2*x(1), 2*x(2)];     %一阶导数
    Qg=[dot(Q(1,:),gf), dot(Q(2,:),gf)];
    alpha=dot(gf,gf)/dot(gf,Qg); % 下降步长
    x = x - alpha.*gf;                  % 梯度下降法迭代公式
    f_new = 0.2*x(1)^2+x(2)^2;              % 计算下一个迭代点的函数值
    f_change = f_current - f_new;       % 计算两次函数值之差
    f_current = f_new;                  % 重新计算当前的函数值
    plot(x(1),x(2),'ro','markersize',7) % 标记当前的位置
    drawnow;pause(0.2);
    k=k+1;x_record(k,:)=x;
end
plot(x_record(:,1),x_record(:,2),'m')
hold off
fprintf('在迭代%d次后找到函数最小值为%e，对应的x值为[%e,%e].\n',k,f_current,x(1),x(2))