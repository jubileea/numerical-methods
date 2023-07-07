% MAE 107 HW 5  Problem 5 Newton's Method
% 
%Objective: Solve for the root of f(x) and g(x) (fhat(x)) using Newton's method and apply it to find the 
% root of f(x) and g(x). 

%for f(x) = 0  , indicate x0 that leads to diverge
% for g(x) = 0  , indicate x0 that leads to convergence to the correct solution 
%show solns with at least 5 steps in each case. For converging fxn, continue method
%until abs(f(x)) < 10^-12

% Discuss errors


%setup
clear all; 
close all; 
clc;
syms x
syms p

%inputs
x0 = 2; % assume x0=2  for f(x) to converge
gx0 = 0; % assume  x0= 0    for g(x) to diverge
n = 0; % both methods must run at least 5 steps but initialize n=0
f(x) = atan(x+ (2/3)*x^3) - 0.7; % given function set = 0
df(x) = (2*x^2+1) / ( ( (2/3)*x^3+x)^2 + 1 );  %derivative of f(x), done by hand
g(p) = p + (2/3)*p^3 - tan(0.7); % other function set = 0
dg(p) = 2*p^2+1;  %derivative of g(x), done by hand

% call function that converges, f(x)
[r] =  newton(df, f,x0,gx0,dg,g,n); 

% Newton's method  
function [r] = newton(df, f,x0, gx0,dg,g,n)   %r = root
    ef = [];
    x(1) = x0; % assumed, starting from k=1 but its actually x0 because matlab can't do indices=0 
    for k = 1:10    % iteration   
        x(k+1) = x(k) - ( (f( x(k)) )  /  ( df(x(k))  )  ); %eqn for Newton's method from notes
         disp(['The x' num2str(k)  ' solution for f(x) is ' num2str( x(k+1) ) '.'])  % displays xk

         ef(k) = abs( 0.655 - x(k) ) %outputs errors, tb analyzed in relation to digit doubling

        if abs(   f(x(k) )  )  <  10^(-12)   %continue method until error < 10^-12    % ignore: - f(x(k+1))
            break   %breaks the for loop once this condition is satisfied
        end
    end
    n = k-1 ;    % amount of steps, n, to find the root
    r = x(:,end); %for converging fxn, root is x after n steps
    disp(['The root of f is ' num2str(r) '.'])  % displays root 
    disp(['It took ' num2str(n) ' steps to find the root of f with the given error ' ...
        'bound and initial condition x0=' num2str(x0) '.'])    % displays step count


%%-----  g(x),  the one that converges, run Newton's method   --------
    p(1) = gx0; % assumed, starting from k=1 but its actually gx0 because matlab can't do indices=0 
     eg = [];
    for z = 1:10    % iteration   
         p(z+1) = p(z) - ( (g( p(z)) )  /  ( dg(p(z))  )  ); %eqn for Newton's method from notes
         disp(['The x' num2str(z)  ' solution for g(x) is ' num2str( p(z+1) ) '.'])  % displays xk

          eg(z) = abs( 0.655 - p(z) )  %outputs errors, tb analyzed in relation to digit doubling

         if abs(   g(p(z) )  )  <  10^(-12)   %continue method until error < 10^-12    % ignore: - g(p(z+1))
                break   %breaks the for loop once this condition is satisfied
         end
    end
     num = z-1 ;    % amount of steps, n, to find the root
    rootg = p(:,end); %for converging fxn, root is x after n steps
    disp(['g(x) has a root of ' num2str(rootg) '.'])  
    disp(['It took ' num2str(num) ' steps to find the root of g with the given error bound ' ...
        'and initial condition x0=' num2str(gx0) '.']) 

end





