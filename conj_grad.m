function [X,N]=conj_grad(option)

	clc;
	%------初始迭代点---------------
	xnew=[-2,2];
	numvars = length(xnew);

	format compact;
	format short e;

	%--------终止条件----------------
	epsilon_x = 10^(-7);
	epsilon_g = 10^(-7);
	max_iter=1000*numvars;

	g_curr=grad(xnew);


%------可行方向------
	d=-g_curr;

%----迭代6次之后，重置搜索方向--------------
	reset_cnt = 0;
%------开始迭代---------------
	for k = 1:max_iter,
		xcurr=xnew;

%--------采用割线法进行精确一维搜索-------------
		alpha=linesearch_secant(xcurr,d);
		%alpha=-(d’*g_curr)/(d’*Q*d);
		xnew = xcurr+alpha*d';
		
%------终止条件1-----------------------
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
		
%-------迭代次数达到变远个数的两倍时，重置dk----------------
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