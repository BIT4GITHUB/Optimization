% 基于Armijo非精确一维搜索的梯度下降算法,求解复杂函数
function example_3_5()
%————初始点————
x=[2,1.5];
k=0;
%————停止规则的参数————
f_current = fun(x);              % 计算当前函数值
f_change  = f_current;              % 初始化差值
%————梯度下降法————
while f_change>0.000000001       %设置条件，两次计算的值之差小于某个数，跳出循环
    k=k+1;
    alpha(k)=Armijo(x); % 下降步长    
    x = x - alpha(k).*gfun(x);                  % 梯度下降法迭代公式
    f_new = fun(x);              % 计算下一个迭代点的函数值
    f_change = f_current - f_new;       % 计算两次函数值之差
    f_current = f_new;                  % 赋给当前的函数值
    plot(x(1),x(2),'ro','markersize',7) % 标记当前的位置
    drawnow;pause(0.2);    
    x_record(k,:)=x;
end
plot(x_record(:,1),x_record(:,2),'m')
hold off
fprintf('在迭代%d次后找到函数最小值为%e，对应的x值为[%e,%e].\n',k,f_current,x(1),x(2))
alpha
%————定义目标函数————
    function y=fun(x)
        y = (x(1)-1)^2 + 4* (x(2)-x(1)^2)^2;
    end
%————定义目标函数的一阶导数————
    function y=gfun(x)
        y =[2*x(1)-2-16*(x(2)-x(1)^2)*x(1), 8*(x(2)-x(1)^2)]; 
    end
%————定义非精确一维搜索————
    function a=Armijo(x)
        e=0.5;         %Armijo判断条件参数
        tau=0.5;       %缩小参数          
        m=0;           %初始的缩小幂次
        alpha0=0.5;    %初始 步长
        a = alpha0;
        gf=gfun(x);
        %while fun(x - alpha0*gf) > fun(x)
        while fun(x - a*gf) > fun(x)+e*a*(-1*dot(gf,gf))
            m=m+1;
            a=alpha0*(tau^m);
            if m>20
                break;
            end
        end        
    end
end

