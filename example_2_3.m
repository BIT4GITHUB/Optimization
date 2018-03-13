% example 1_1
clear;clc;
%�����������м���������
a=0;
b=1.5;
%����������ͼ���ȡ�������
step=0.01;
iter=(b-a)/step; %��������
x = a:step:b;
%��������Ŀ�꺯����������
y = 0.5.*x.^2-sin(x);
%�����������ƺ�����������
x0=0.5;
f0=0.5*x0^2-sin(x0);
df=x0-cos(x0);
ddf=1+sin(x0);
ynew=f0+df.*(x-x0)+0.5.*ddf.*(x-x0).^2;
%����������ͼ��������
figure
plot(x,y,'m','LineWidth',2);hold on;
plot(x,ynew,'b--','LineWidth',2,'MarkerSize',5);hold on;
title('��x_0=0.5����q(x)����f(x)','FontSize',20)
l=legend('f(x)=(1/2)x^2-sin(x)','q(x)=f(x_0)+f^{/}(x_0)(x-x_0)+(1/2)f^{//}(x_0)(x-x_0)^2');
set(l,'FontSize',20);
l.Location='best';
xlabel('x')
ylabel('f')
