%��������Ŀ�꺯������ͼ�񡪡�����
a = -0.5; b = 2; step=0.05;
iter=(b-a)/step; %��������
xx1 = a:step:b; xx2 = a:step:b;
[x1,x2]=meshgrid(xx1,xx2);
y = (x1-1).^2 + 4.* (x2-x1.^2).^2;
figure; scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz); % ����һ��������󻯵�figure
surf(x1,x2,y,'EdgeColor','none');pause(0.2);
title('f(x_1,x_2)=(x_1-1)^2 + 4(x_2-x_1^2)^2','FontSize',20)

v=0:0.1:2;
figure; scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz);
contour(x1,x2,y,v,'ShowText','on')
hold on