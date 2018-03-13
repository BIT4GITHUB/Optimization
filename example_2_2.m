% example 2_2
%————主程序————

function example_2_2()
%————可行集————
a=0;
b=2;
%————定义初始迭代点————
localmin=myfun(a);
%————迭代————
step=0.15;
iter=ceil((b-a)/step); %迭代次数

for i=1:iter
    x(i)=a+i*step;
    f(i)=myfun(x(i));
    if f(i)<localmin
        localmin=f(i);
        xmin=x(i);
    end
end
x
f
localmin
xmin
iter
%————定义目标函数————
function y=myfun(x)
y = x^4-14*x^3+60*x^2-70*x;
end
end

