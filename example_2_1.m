% example 1_1
clear;clc;
%�����������м���������
a=0;
b=2;
%����������ͼ���ȡ�������
step=0.25;
iter=(b-a)/step; %��������
x = a:step:b;
%��������Ŀ�꺯����������
y = x.^4-14.*x.^3+60.*x.^2-70.*x;
%����������ͼ��������
figure
plot(x,y,'r--o','LineWidth',1,'MarkerSize',5)

title('f(x)=x^4-14x^3+60x^2-70x','FontSize',20)
xlabel('x')
set(gca, 'XTick', a:step:b) %����X������̶����ݵ�λ�� 
ylabel('f')
grid on