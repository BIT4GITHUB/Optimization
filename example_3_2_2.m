%% �����½���ͼʾ
% f_changeΪ�ı�ǰ���yֵ�仯����������һ���˳�������
clear;clc
%��������Ŀ�꺯������ͼ�񡪡�����
a = -2; b = 2; step=0.05;
iter=(b-a)/step; %��������
xx1 = a:step:b; xx2 = a:step:b;
[x1,x2]=meshgrid(xx1,xx2);
y = 0.2.*(x1).^2+(x2).^2;
%�������������㷨�Ĳ���,��ʼֵ,������¼����������
x=[2, 2];
Q=[0.4, 0; 0, 2];
k=0; 
%��������ֹͣ����Ĳ�����������
f_change  = 0.2*x(1)^2+x(2)^2;              % ��ʼ����ֵ
f_current = 0.2*x(1)^2+x(2)^2;              % ���㵱ǰ����ֵ
%�������������½�����������
while f_change>0.000000001              % �������������μ����ֵ֮��С��ĳ����������ѭ��
    gf=[0.2*2*x(1), 2*x(2)];     %һ�׵���
    Qg=[dot(Q(1,:),gf), dot(Q(2,:),gf)];
    alpha=dot(gf,gf)/dot(gf,Qg); % �½�����
    x = x - alpha.*gf;                  % �ݶ��½���������ʽ
    f_new = 0.2*x(1)^2+x(2)^2;              % ������һ��������ĺ���ֵ
    f_change = f_current - f_new;       % �������κ���ֵ֮��
    f_current = f_new;                  % ���¼��㵱ǰ�ĺ���ֵ
    k=k+1;
    f_record(k)=f_current;
    x_record(k,:)=x;
end

figure; scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz);
contour(x1,x2,y,f_record,'LineWidth',1,'ShowText','on')
hold on
title('f(x_1,x_2)=0.2(x_1)^2+(x_2)^2','FontSize',20)
plot(x_record(:,1),x_record(:,2),'m','LineWidth',1)
hold off
fprintf('�ڵ���%d�κ��ҵ�������СֵΪ%e����Ӧ��xֵΪ[%e,%e].\n',k,f_current,x(1),x(2))