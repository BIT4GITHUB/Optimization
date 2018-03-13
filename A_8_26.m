function A_8_26()
clear;clc;
%-------ȷ������ֹͣ������--------
epsilon_x =10^(-6);
epsilon_g =10^(-4);
max_iter=10000;
%-------ȷ����ʼ������---------------
xnew=[-2,2];

for k = 1:max_iter
    xcurr=xnew;
    g_curr=grad(xcurr);
    %---------��ֹ����1----------------
    if norm(g_curr) <= epsilon_g
        disp('Terminating: Norm of gradient less than');
        disp(epsilon_g);
        k=k-1;
        break;
    end %if
    %--------���ø��߷�ȷ��alpha-----------
    alpha=linesearch_secant(xcurr,-g_curr);
    %-----------���µ�����--------------
    xnew = xcurr-alpha.*g_curr;
    %---------------��ֹ����2---------------------
    if norm(xnew-xcurr) <= epsilon_x*norm(xcurr)
        disp('Terminating: Norm of difference between iterates less than');
        disp(epsilon_x);
        break;
    end %if
    
    if k == max_iter
        disp('Terminating with maximum number of iterations');
    end %if
end %for

    disp('Final point =');
    disp(xnew');
    disp('Number of iterations =');
    disp(k);
%------------------------------------------------------------------
%--------------���ø��߷�����alpha value-------------------
function alpha=linesearch_secant(x,d)
    %Line search using secant method
    epsilon=10^(-4); %line search tolerance
    max = 100; %maximum number of iterations
    alpha_curr=0;
    alpha=0.001;
    dphi_zero=d*grad(x)';
    dphi_curr=dphi_zero;
    i=0;
    while abs(dphi_curr)>epsilon*abs(dphi_zero),
        alpha_old=alpha_curr;
        alpha_curr=alpha;
        dphi_old=dphi_curr;
        dphi_curr=d*grad(x+alpha_curr.*d)';
        alpha=(dphi_curr*alpha_old-dphi_old*alpha_curr)/(dphi_curr-dphi_old);
        i=i+1;
        if (i >= max)&&(abs(dphi_curr)>epsilon*abs(dphi_zero)),
            disp('Line search terminating with number of iterations:');
            disp(i);
            break;
        end
    end %while
end

%������������Ŀ�꺯����������
%   function y=fun(x)
 %       y = 100* (x(2)-x(1))^2 + (1-x(1))^2;
  %  end
%������������Ŀ�꺯����һ�׵�����������
    function y=grad(x)
        y =[100*(4*x(1)^3-4*x(1)*x(2))+2*x(1)-2,200*(x(2)-x(1)^2)]; 
    end
end