% example 2 
clear;clc;
%————可行集————
a = -5;
b = 5;
%————作图精度————
step=0.1;
iter=(b-a)/step; %迭代次数
xx1 = a:step:b;
xx2 = a:step:b;
[x1,x2]=meshgrid(xx1,xx2);
%————目标函数————
y = x1+x2.^2+3.*cos(x1.*x2);
%————作图————
figure
surf(x1,x2,y,'EdgeColor','none')

title('f(x_1,x_2)=x_1+x_2^2+3cos(x_1x_2)','FontSize',20)

