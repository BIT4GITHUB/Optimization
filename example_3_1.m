%% �ݶ��½����������½����������趨
% ���ò���Ϊ0.1��f_changeΪ�ı�ǰ���yֵ�仯����������һ���˳�������
clear;clc
%��������Ŀ�꺯������ͼ�񡪡�����
a = -1.5; b = 1.5; step=0.05;
iter=(b-a)/step; %��������
xx1 = a:step:b; xx2 = a:step:b;
[x1,x2]=meshgrid(xx1,xx2);
y = (x1).^2+(x2).^2;
figure; scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz); % ����һ��������󻯵�figure
surf(x1,x2,y,'EdgeColor','none');pause(0.3);
figure; scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz);
v=0:0.1:2;
contour(x1,x2,y,v,'ShowText','on')
hold on
title('f(x_1,x_2)=(x_1)^2+(x_2)^2','FontSize',20)
%�������������㷨�Ĳ���,��ʼֵ,������¼����������
alpha=0.5; % �½�����
x=[2 2];
k=0; 
%��������ֹͣ����Ĳ�����������
f_change  = x(1)^2+x(2)^2;              % ��ʼ����ֵ
f_current = x(1)^2+x(2)^2;              % ���㵱ǰ����ֵ
%���������ݶ��½�����������
while f_change>0.000000001              % �������������μ����ֵ֮��С��ĳ����������ѭ��
    gf=2.*x;     %һ�׵���
    x = x - alpha.*gf;                  % �ݶ��½���������ʽ
    f_new = x(1)^2+x(2)^2;              % ������һ��������ĺ���ֵ
    f_change = f_current - f_new;       % �������κ���ֵ֮��
    f_current = f_new;                  % ���¼��㵱ǰ�ĺ���ֵ
    plot(x(1),x(2),'ro','markersize',7) % ��ǵ�ǰ��λ��
    drawnow;pause(0.2);
    k=k+1;
end
hold off
fprintf('�ڵ���%d�κ��ҵ�������СֵΪ%e����Ӧ��xֵΪ[%e,%e].\n',k,f_current,x(1),x(2))