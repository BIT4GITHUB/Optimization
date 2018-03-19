function [X,N]=conj_grad(option)

	clc;
	%------��ʼ������---------------
	xnew=[-2,2];
	numvars = length(xnew);

	format compact;
	format short e;

	%--------��ֹ����----------------
	epsilon_x = 10^(-7);
	epsilon_g = 10^(-7);
	max_iter=1000*numvars;

	g_curr=grad(xnew);


%------���з���------
	d=-g_curr;

%----����6��֮��������������--------------
	reset_cnt = 0;
%------��ʼ����---------------
	for k = 1:max_iter,
		xcurr=xnew;

%--------���ø��߷����о�ȷһά����-------------
		alpha=linesearch_secant(xcurr,d);
		%alpha=-(d��*g_curr)/(d��*Q*d);
		xnew = xcurr+alpha*d';
		
%------��ֹ����1-----------------------
		if norm(xnew-xcurr) <= epsilon_x*norm(xcurr)
			disp('Terminating: Norm of difference between iterates less than');
			disp(epsilon_x);
			break;
		end %if
		
		g_old=g_curr;
		
		g_curr=grad(xnew);
		
		if norm(g_curr) <= epsilon_g
			disp('Terminating: Norm of gradient less than');
			disp(epsilon_g);
			break;
		end %if
		
%-------���������ﵽ��Զ����������ʱ������dk----------------
		reset_cnt = reset_cnt+1;
		if reset_cnt == 3*numvars
			d=-g_curr;
			reset_cnt = 0;
        else       
            %--------using diffrernt methods to clculate the beta------
			if option==0 %Powell
				beta = max(0,(g_curr'*(g_curr-g_old))/(g_old'*g_old));
				elseif option==1 %Fletcher-Reeves
				beta = (g_curr'*g_curr)/(g_old'*g_old);
				elseif option==2 %Polak-Ribiere
				beta = (g_curr'*(g_curr-g_old))/(g_old'*g_old);
				else %Hestenes-Stiefel
				beta = (g_curr'*(g_curr-g_old))/(d'*(g_curr-g_old));
			end %if
			d=-g_curr+beta*d;
		end

		if k == max_iter
			disp('Terminating with maximum number of iterations');
		end %if
	end %for

    if nargout >= 1
        X=xnew;
        if nargout == 2
            N=k;
        end
    else
        disp('Final point =');
        disp(xnew');
        disp('Number of iterations =');
    disp(k);
    end %if
	%------------------------------------------------------------------