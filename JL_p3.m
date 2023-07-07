
% MAE 107 SP23 Take Home Final  Problem 3

%Objective: Use RK4 to solve
%ydot = g(t,y)
%y0 = 4   
%g is the solution of z = exp(  -(1+sin(z) )  ) - ( ( sin(t+y) )^2)*(1+z^2)^(1/3)   ****in this code, b = z
%if y = pi/2 and t = 1 -> g is the solution of fixed pt eqn z
% up to time T=6  with B2 = 0.5
%-------------------------------------------
%Plot solution approx for varying steps  n = [8 16 32 64 128 256 512] 
%-------------------------------------------------------------
%Explain using same or different n for RK4 and FPI

%setup
clear all; 
close all; 
T = 6;  %run code up to T=6
f=@(b,t,y) exp(  -(1+sin(b) )  ) - ( ( sin(t+y) )^2 )*(1+ b^2 )^(1/3); %use fixed pt method of f to evaluate g(t,y) and get b

%------------------------------------------------------------------------------------------------
n = 8; %starting n value
% to run RK 4 w/ Fixed Pt inside  for the n values: 8,16,32,64,128,256,512
for n = 2.^[3:10]  %for loop to go until last n (n=512 =  2^9)
    [t, y] = rk4(f,0,0,4,n,T); %call function for RK4 
    hold on
    plot(t,y, 'LineWidth', 1)  %plot RK4 w/ FPI
    title('Runge-Kutta 4th Order w/ Fixed Point')
    xlabel('t')
    ylabel('y(t)')
    legend('n=4','n=8', 'n=16','n=32','n=64', 'n=128','n=256','n=512','Location','northwest','FontSize',9, 'Location', 'northeast') 
    hold off
end
%------------------------------------------------------------------------------------------------
%Fixed Point Function
function [b] = fixedpt(f,t,y,n)  %inputs: fun = function input, t, n (steps), and y; outputs the root approximation, b tb used in RK4
    i = 1;  %local variable counter
    bnd = 10^(-4);  %local variable error bound for fixed pt method
    x0=0;  %first inital guess for the root
    b(1) = 0;  %initializing output
    b = feval(f,b,t,y);  %temporary root is f evaluated at b, t and y
        
         while abs(x0-b) > bnd && i+1 <=n   %while the difference is greater than the bound, and less than the # of wanted steps
             if b==x0  %check if the temp root is the guess
                 b = x0;
                 disp([ 'The fixed point is ' , num2str(b)  'at n=0'  ]) 
                 break  %exit the if statement
            end 
             i = i+1;  %up the counter
             x0 = b;  %guess is changed to the old temp root value
             b = feval(f,b,t,y);  % evaluate new temp root; b is the output if while loop stops running
         end
end
 %------------------------------------------------------------------------------------------------
%Function for Runge-Kutta 4th Order with Fixed Point Method
function [t, y] = rk4(f,b0,t0,y0,n, maxT) %inputs are function used to do RK (f), number of steps (n), T (maxT), initial t & y
    %outputs t and y
    %for debugging: b(1) = [b0 b]; %makes an array for z and sets the first value
    t(1) = t0;%makes an array for t and sets the first value
    y(1) = y0;%makes an array for y and sets the first value
    h = maxT/n; %step size, h
    for z = 1:n     %use indices variable z instead of k
        % call fixedpt function to evaulate k1 through k4
        %eqns for RK4 from Lecture
        k1 = h*fixedpt(f,t(z),y(z),n );  
        k2 = h*fixedpt(f,t(z) + h/2,y(z)+ k1/2,n );   
        k3 = h*fixedpt(f,t(z) + h/2,y(z)+ k2/2,n );
        k4 = h*fixedpt(f,t(z) + h,y(z)+ k3,n );
        y(z+1) = y(z) + (      (k1 + 2*k2 + 2*k3 + k4 )/6       ); 
       t(z+1) = t(z) +  h; %go to the next t by adding the step size, h
    end

end