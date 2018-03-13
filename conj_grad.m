function conj_grad()

	clc;clear;
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
	
	reset_cnt = 0;
%------开始迭代---------------
	for k = 1:max_iter,
		xcurr=xnew;

%--------采用割线法进行精确一维搜索-------------
		alpha=linesearch_secant(xcurr,d);
		%alpha=-(d’*g_curr)/(d’*Q*d);
		xnew = xcurr+alpha*d;
		
		if print,
			disp(’Iteration number k =’)
			disp(k); %print iteration index k
			disp(’alpha =’);
			disp(alpha); %print alpha
			disp(’Gradient = ’);
			disp(g_curr’); %print gradient
			disp(’New point =’);
			disp(xnew’); %print new point
		end %if
		
		if norm(xnew-xcurr) <= epsilon_x*norm(xcurr)
			disp(’Terminating: Norm of difference between iterates less than’);
			disp(epsilon_x);
			break;
		end %if
		
		g_old=g_curr;
		
		g_curr=grad(xnew);
		
		if norm(g_curr) <= epsilon_g
			disp(’Terminating: Norm of gradient less than’);
			disp(epsilon_g);
			break;
		end %if
		
		reset_cnt = reset_cnt+1;
		if reset_cnt == 3*numvars
			d=-g_curr;
			reset_cnt = 0;
		else
			if options(5)==0 %Powell
				beta = max(0,(g_curr’*(g_curr-g_old))/(g_old’*g_old));
				elseif options(5)==1 %Fletcher-Reeves
				beta = (g_curr’*g_curr)/(g_old’*g_old);
				elseif options(5)==2 %Polak-Ribiere
				beta = (g_curr’*(g_curr-g_old))/(g_old’*g_old);
				else %Hestenes-Stiefel
				beta = (g_curr’*(g_curr-g_old))/(d’*(g_curr-g_old));
			end %if
			d=-g_curr+beta*d;
		end
		if print,
			disp(’New beta =’);
			disp(beta);
			disp(’New d =’);
			disp(d);
		end
		if k == max_iter
			disp(’Terminating with maximum number of iterations’);
		end %if
	end %for

	disp(’Final point =’);
	disp(xnew’);
	disp(’Number of iterations =’);
	disp(k);
	%------------------------------------------------------------------
	
	%--------------利用割线发迭代alpha value-------------------
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
	%————定义目标函数的一阶导数————
		function y=grad(x)
			y =[100*(4*x(1)^3-4*x(1)*x(2))+2*x(1)-2,200*(x(2)-x(1)^2)]; 
		end
end