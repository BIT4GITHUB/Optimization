%----------SA求解TSP------------
clc,clear;   
%----------TSP参数：31个城市的坐标--------------
City=[1304 2312;3639 1315;4177 2244;3712 1399;3488 1535;3326 1556;...
    3238 1229;4196 1044;4312 790;4386 570;3007 1970;2562 1756;...
    2788 1491;2381 1676;1332 695;3715 1678;3918 2179;4061 2370;...
    3780 2212;3676 2578;4029 2838;4263 2931;3429 1908;3507 2376;...
    3394 2643;3439 3201;2935 3240;3140 3550;2545 2357;2778 2826;2370 2975];

city_num=length(City(:,1));
%-------各城市点的分布图-----------------
figure; scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz);
for i=1:city_num-1
    plot([City(i,1),City(i+1,1)],[City(i,2),City(i+1,2)],'ro');hold on
end
%pause(1);close

%-------SA关键参数------------
T = 1000;      %----初始温度------
Loop = 1000;    %----循环次数------
alpha = 0.98;   %-----冷却因子------
tf = 0.0001;    %-----终止温度-----

%------X=[1,2,3,4,5,...,31]------
X = zeros(1,city_num);  
for i = 1:city_num  
    X(1,i) = i;  
end  

%----scatter:画散点图-----
%scatter(City(:,1),City(:,2),'p')  
%hold on;  
  
sumarray = zeros(1,Loop);  
sumarrayx = zeros(1,Loop);  
    
for i = 1:Loop  
    %------当温度降至tf时停止--------
    if T<tf  
        break  
    end  
    %关于k的迭代次数还需考虑-----------
    for k = 1:2000  
        index1 = 0;  
        index2 = 0;  
        %-------随机选择两个指标进行之后的交叉--------------
        while index1<1 || index1>city_num  
            index1 = round(city_num*rand);  
        end  
        while index2<1 || index2>city_num  
            index2 = round(city_num*rand);  
        end  
        Y = X;  
        %-------比较交叉之后的效果，选择更优路径----------
        Y(1,index1) = X(1,index2);  
        Y(1,index2) = X(1,index1);  
        dsum = Sum(City,Y)-Sum(City,X);  
        if dsum<0  
            X = Y;  
        else  
            accept = rand; 
            %if accept < exp(-dsum/(k*T))  
            if accept < exp(-dsum/T)  
                X = Y;  
            end  
        end         
    end 
    %------温度的下降方式：T=T*alpha^k-----------
    T = T*alpha;  
    sumarray(1,i) = Sum(City,X);  
    sumarrayx(1,i) = i;  
end  

%---------将最终寻找到的路径画出来---------------
figure;
scatter(City(:,1),City(:,2),'ro')  
hold on; 
for i = 1:30  
    line([City(X(1,i),1) City(X(1,i+1),1)],[City(X(1,i),2) City(X(1,i+1),2)])  
    hold on;  
end  
line([City(X(1,1),1) City(X(1,city_num),1)],[City(X(1,1),2) City(X(1,city_num),2)])  
%----------将搜索过程的能量变化情况呈现出来-------------
len=length(nonzeros(sumarrayx));
%----------使用figure画多张图-----------
figure;
scatter(sumarrayx(1,1:len),sumarray(1,1:len));
%---------最终搜索到的“最低”能量值
Sum(City,X)