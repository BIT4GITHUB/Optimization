% 牛顿法：包含基本牛顿法和非精确一维搜索步长的修正牛顿法
function example_4_1()
%————初始点————
x=[1.6,1.5];
k=0;
print_index=0; % 程序结束后，输出文字的指示数
%————停止规则的参数————
f_current = fun(x);              % 计算当前函数值
f_change  = f_current;              % 初始化差值
%————梯度下降法————
while f_change>0.000000001       %设置条件，两次计算的值之差小于某个数，跳出循环
    k=k+1;
    
    F=hfun(x);
    if min(eig(F))<0
        print_index=1;
        fprintf('黑塞矩阵不正定\n')
        break
    end
    iF=inv(hfun(x));    %黑塞矩阵的逆矩阵
    dk=-[dot(iF(1,:),gfun(x)),dot(iF(2,:),gfun(x))]; %牛顿法的搜索方向
    alpha(k)=Armijo(x);          % 下降步长
    %x = x + dk;                  % 不含修正的牛顿法迭代公式
       x = x + alpha(k).*dk;        % 修正的牛顿法迭代公式
    f_new = fun(x);              % 计算下一个迭代点的函数值
    f_change = f_current - f_new;       % 计算两次函数值之差
    if f_change<0
        print_index=1;
        fprintf('目标函数不再下降\n')
        break
    end
    f_current = f_new;                  % 赋给当前的函数值
    plot(x(1),x(2),'ro','markersize',7) % 标记当前的位置
    drawnow;pause(0.2);    
    x_record(k,:)=x;
end
plot(x_record(:,1),x_record(:,2),'m')
hold off
if print_index==0
    fprintf('在迭代%d次后找到函数最小值为%e，对应的x值为[%e,%e].\n',k,f_current,x(1),x(2))
    alpha
end
%————定义目标函数————
    function y=fun(x)
        y = (x(1)-1)^2 + 4* (x(2)-x(1)^2)^2;
    end
%————定义目标函数的一阶导数————
    function y=gfun(x)
        y =[2*x(1)-2-16*(x(2)-x(1)^2)*x(1), 8*(x(2)-x(1)^2)]; 
    end
%————定义目标函数的二阶导数————
    function y=hfun(x)
        y =[2-16*x(2)+48*x(1)^2, -16*x(1);...
                -16*x(1),          8    ]; 
    end
%————定义非精确一维搜索————
    function a=Armijo(x)
        e=0.5;         %Armijo判断条件参数
        tau=0.5;       %缩小参数          
        m=0;           %初始的缩小幂次
        alpha0=0.9;    %初始 步长
        gf=gfun(x);
        %while fun(x - alpha0*gf) > fun(x)
        while fun(x - alpha0*gf) > fun(x)+e*alpha0*(-1*dot(gf,gf))
            m=m+1;
            alpha0=alpha0*(tau^m);
            if m>20
                break;
            end
        end
        a=alpha0;
    end
end

