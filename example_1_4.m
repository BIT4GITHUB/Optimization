% example 2 
clear;clc;
%�����������м���������
a = 100;
b = 4500;
%����������ͼ���ȡ�������
step=1;
iter=(b-a)/step; %��������
x = a:step:b;

%��������Ŀ�꺯����������
N=200099;
y = mod(N,x);
%����������ͼ��������
figure
plot(x,y,'r--o','LineWidth',1,'MarkerSize',5)
xlabel('x')
set(gca, 'XTick', a:10*step:b) %����X������̶����ݵ�λ�� 
ylabel('f')
grid on

title('f(x)=Nmodx','FontSize',20)

