% example 2_2
%�������������򡪡�����

function example_2_2()
%�����������м���������
a=0;
b=2;
%�������������ʼ�����㡪������
localmin=myfun(a);
%��������������������
step=0.15;
iter=ceil((b-a)/step); %��������

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
%������������Ŀ�꺯����������
function y=myfun(x)
y = x^4-14*x^3+60*x^2-70*x;
end
end

