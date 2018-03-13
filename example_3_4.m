% ����Armijo�Ǿ�ȷһά�������ݶ��½��㷨,��⸴�Ӻ���
function example_3_5()
%����������ʼ�㡪������
x=[2,1.5];
k=0;
%��������ֹͣ����Ĳ�����������
f_current = fun(x);              % ���㵱ǰ����ֵ
f_change  = f_current;              % ��ʼ����ֵ
%���������ݶ��½�����������
while f_change>0.000000001       %�������������μ����ֵ֮��С��ĳ����������ѭ��
    k=k+1;
    alpha(k)=Armijo(x); % �½�����    
    x = x - alpha(k).*gfun(x);                  % �ݶ��½���������ʽ
    f_new = fun(x);              % ������һ��������ĺ���ֵ
    f_change = f_current - f_new;       % �������κ���ֵ֮��
    f_current = f_new;                  % ������ǰ�ĺ���ֵ
    plot(x(1),x(2),'ro','markersize',7) % ��ǵ�ǰ��λ��
    drawnow;pause(0.2);    
    x_record(k,:)=x;
end
plot(x_record(:,1),x_record(:,2),'m')
hold off
fprintf('�ڵ���%d�κ��ҵ�������СֵΪ%e����Ӧ��xֵΪ[%e,%e].\n',k,f_current,x(1),x(2))
alpha
%������������Ŀ�꺯����������
    function y=fun(x)
        y = (x(1)-1)^2 + 4* (x(2)-x(1)^2)^2;
    end
%������������Ŀ�꺯����һ�׵�����������
    function y=gfun(x)
        y =[2*x(1)-2-16*(x(2)-x(1)^2)*x(1), 8*(x(2)-x(1)^2)]; 
    end
%������������Ǿ�ȷһά������������
    function a=Armijo(x)
        e=0.5;         %Armijo�ж���������
        tau=0.5;       %��С����          
        m=0;           %��ʼ����С�ݴ�
        alpha0=0.5;    %��ʼ ����
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

