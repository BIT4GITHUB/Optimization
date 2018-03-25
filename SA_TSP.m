%----------SA���TSP------------
clc,clear;   
%----------TSP������31�����е�����--------------
City=[1304 2312;3639 1315;4177 2244;3712 1399;3488 1535;3326 1556;...
    3238 1229;4196 1044;4312 790;4386 570;3007 1970;2562 1756;...
    2788 1491;2381 1676;1332 695;3715 1678;3918 2179;4061 2370;...
    3780 2212;3676 2578;4029 2838;4263 2931;3429 1908;3507 2376;...
    3394 2643;3439 3201;2935 3240;3140 3550;2545 2357;2778 2826;2370 2975];

city_num=length(City(:,1));
%-------�����е�ķֲ�ͼ-----------------
figure; scrsz = get(0,'ScreenSize');set(gcf,'Position',scrsz);
for i=1:city_num-1
    plot([City(i,1),City(i+1,1)],[City(i,2),City(i+1,2)],'ro');hold on
end
%pause(1);close

%-------SA�ؼ�����------------
T = 1000;      %----��ʼ�¶�------
Loop = 1000;    %----ѭ������------
alpha = 0.98;   %-----��ȴ����------
tf = 0.0001;    %-----��ֹ�¶�-----

%------X=[1,2,3,4,5,...,31]------
X = zeros(1,city_num);  
for i = 1:city_num  
    X(1,i) = i;  
end  

%----scatter:��ɢ��ͼ-----
%scatter(City(:,1),City(:,2),'p')  
%hold on;  
  
sumarray = zeros(1,Loop);  
sumarrayx = zeros(1,Loop);  
    
for i = 1:Loop  
    %------���¶Ƚ���tfʱֹͣ--------
    if T<tf  
        break  
    end  
    %����k�ĵ����������迼��-----------
    for k = 1:2000  
        index1 = 0;  
        index2 = 0;  
        %-------���ѡ������ָ�����֮��Ľ���--------------
        while index1<1 || index1>city_num  
            index1 = round(city_num*rand);  
        end  
        while index2<1 || index2>city_num  
            index2 = round(city_num*rand);  
        end  
        Y = X;  
        %-------�ȽϽ���֮���Ч����ѡ�����·��----------
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
    %------�¶ȵ��½���ʽ��T=T*alpha^k-----------
    T = T*alpha;  
    sumarray(1,i) = Sum(City,X);  
    sumarrayx(1,i) = i;  
end  

%---------������Ѱ�ҵ���·��������---------------
figure;
scatter(City(:,1),City(:,2),'ro')  
hold on; 
for i = 1:30  
    line([City(X(1,i),1) City(X(1,i+1),1)],[City(X(1,i),2) City(X(1,i+1),2)])  
    hold on;  
end  
line([City(X(1,1),1) City(X(1,city_num),1)],[City(X(1,1),2) City(X(1,city_num),2)])  
%----------���������̵������仯������ֳ���-------------
len=length(nonzeros(sumarrayx));
%----------ʹ��figure������ͼ-----------
figure;
scatter(sumarrayx(1,1:len),sumarray(1,1:len));
%---------�����������ġ���͡�����ֵ
Sum(City,X)