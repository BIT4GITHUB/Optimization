% ţ�ٷ�����������ţ�ٷ��ͷǾ�ȷһά��������������ţ�ٷ�
function example_4_1()
%����������ʼ�㡪������
x=[1.6,1.5];
k=0;
print_index=0; % ���������������ֵ�ָʾ��
%��������ֹͣ����Ĳ�����������
f_current = fun(x);              % ���㵱ǰ����ֵ
f_change  = f_current;              % ��ʼ����ֵ
%���������ݶ��½�����������
while f_change>0.000000001       %�������������μ����ֵ֮��С��ĳ����������ѭ��
    k=k+1;
    
    F=hfun(x);
    if min(eig(F))<0
        print_index=1;
        fprintf('������������\n')
        break
    end
    iF=inv(hfun(x));    %��������������
    dk=-[dot(iF(1,:),gfun(x)),dot(iF(2,:),gfun(x))]; %ţ�ٷ�����������
    alpha(k)=Armijo(x);          % �½�����
    %x = x + dk;                  % ����������ţ�ٷ�������ʽ
       x = x + alpha(k).*dk;        % ������ţ�ٷ�������ʽ
    f_new = fun(x);              % ������һ��������ĺ���ֵ
    f_change = f_current - f_new;       % �������κ���ֵ֮��
    if f_change<0
        print_index=1;
        fprintf('Ŀ�꺯�������½�\n')
        break
    end
    f_current = f_new;                  % ������ǰ�ĺ���ֵ
    plot(x(1),x(2),'ro','markersize',7) % ��ǵ�ǰ��λ��
    drawnow;pause(0.2);    
    x_record(k,:)=x;
end
plot(x_record(:,1),x_record(:,2),'m')
hold off
if print_index==0
    fprintf('�ڵ���%d�κ��ҵ�������СֵΪ%e����Ӧ��xֵΪ[%e,%e].\n',k,f_current,x(1),x(2))
    alpha
end
%������������Ŀ�꺯����������
    function y=fun(x)
        y = (x(1)-1)^2 + 4* (x(2)-x(1)^2)^2;
    end
%������������Ŀ�꺯����һ�׵�����������
    function y=gfun(x)
        y =[2*x(1)-2-16*(x(2)-x(1)^2)*x(1), 8*(x(2)-x(1)^2)]; 
    end
%������������Ŀ�꺯���Ķ��׵�����������
    function y=hfun(x)
        y =[2-16*x(2)+48*x(1)^2, -16*x(1);...
                -16*x(1),          8    ]; 
    end
%������������Ǿ�ȷһά������������
    function a=Armijo(x)
        e=0.5;         %Armijo�ж���������
        tau=0.5;       %��С����          
        m=0;           %��ʼ����С�ݴ�
        alpha0=0.9;    %��ʼ ����
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

