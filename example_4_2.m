% ţ�ٷ������ھ�ȷһά�����Ĳ���
function example_4_2()
%����������ʼ�㡪������
correction=0.4;
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
    %det(F)
    if det(F)<0.0001
        print_index=1;
        fprintf('������������\n')
        break
    end
	
    iF=inv(hfun(x));    %��������������
    gfun(x)
    dk=-[dot(iF(1,:),gfun(x)),dot(iF(2,:),gfun(x))]; %ţ�ٷ�����������
    
	alpha(k)=exactminfun(x,dk);  % �½�����
	
	if alpha(k)>=correction
		 x = x + alpha(k).*dk;        % ������ţ�ٷ�������ʽ
    else
		x = x + dk;
	end %if
	
%   x=x+dk;
	
	disp('alpha=');
    disp(alpha(k));
	disp('x=')
    disp(x);
	disp('dk=')
    disp(dk);
	
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
    %alpha
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
%������������һά������������
    function y=phi(alpha,x,dk)
        xx(1)=x(1)+ alpha*dk(1);
        xx(2)=x(2)+ alpha*dk(2);
        y = (xx(1)-1)^2 + 4* (xx(2)-xx(1)^2)^2;
    end
%������������һά������һ�׵�����������
    function y=gphi(alpha,x,dk)
        xx(1)=x(1)+ alpha*dk(1);
        xx(2)=x(2)+ alpha*dk(2);        
        y=(2*xx(1)-2-16*(xx(2)-xx(1)^2)*xx(1))*dk(1) + (8*(xx(2)-xx(1)^2))*dk(2);
    end
%������������һά�����Ķ��׵�����������
    function y=hphi(alpha,x,dk)
        xx(1)=x(1)+ alpha*dk(1);
        xx(2)=x(2)+ alpha*dk(2);
        y = (2-16*xx(2)+48*xx(1)^2)*dk(1)*dk(1)-2*16*xx(1)*dk(1)*dk(2)+8*dk(2)*dk(2);
    end
%����������ȷһά����:ţ�ٷ���������
    function a=exactminfun(x,dk)        
        m=0;
        alpha0=1;    %��ʼ ����
        current=phi(alpha0,x,dk);
        x= x + alpha0.*dk;
        change= current;       
        while change>0.000001            
            alpha0=alpha0-gphi(alpha0,x,dk)/hphi(alpha0,x,dk);             
            x= x + alpha0.*dk;
            new=phi(alpha0,x,dk);  
            change = current - new;
            current = new;
            if change<0
                break
            end
            m=m+1;
            if m>200
                break;
            end
        end
        a=alpha0;
    end
end

