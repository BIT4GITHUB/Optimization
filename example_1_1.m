% example 1_1
clear;clc;
%�����������м���������
a=-5;
b=10;
%����������ͼ���ȡ�������
step=0.5;
iter=(b-a)/step; %��������
x = a:step:b;
%��������Ŀ�꺯����������
y = (x+1).^2+x;
%����������ͼ��������
figure
plot(x,y,'r--o','LineWidth',1,'MarkerSize',5)

title('f(x)=(x+1)^2+x','FontSize',20)
xlabel('x')
set(gca, 'XTick', a:step:b) %����X������̶����ݵ�λ�� 
ylabel('f')
grid on