% MAE 107 SP23 Take Home Final  Problem 1 

%Objective: Use Euler's method, RK2, and RK4 to solve
%ydot = e^(-y)* (sin(t+2*pi*y) ) ; 
%y0 = 1;          
% up to time T=2  with B2 = 0.5
%-------------------------------------------
%Part 2:
%also create RK2 of your own, choosing B2 different from .5 and 1 . 
%use varying steps  n = 2^i   first i = 2, until i = 12 (last n is 4096) 
%-------------------------------------------------------------
%Part 3:
%plot solns on one or more graphs w diff colors for the methods
%assume RK 4 with n= 8192 = true solution
%plot log of the error vs log(n) for all 4 graphs -> 4 lines
%comment on the slopes

%setup
clear all; 
close all; 
T = 2;  %run code up to T=2
f=@(t,y) exp(-y)* (sin(t+2*pi*y) ) ;  %ydot for Euler's, RK2, RK4
fc=@(tc,yc) exp(-yc)* (sin(tc+2*pi*yc) ) ;  %ydot for RK2 Custom  
%setting up matrices and arrays to use to graph error plots
eulmatrix = [];
custmatrix = [];
rk2matrix = [];
rk4matrix = [];
eulFarr = [];
custFarr = [];
rk2Farr = [];
rk4Farr = [];

%------------------------------------------------------------------------------------------------
%Part 3: Assume RK4 at n=8192 generates the true solution. To find the true solution:
    nreal = 8192; %RK4 at n = 8192 is the true solution
    t(1) = 0; %t0
    y(1) = 1; %y0
    h = T/nreal; %step size, h
    for z = 1:nreal     %use indices variable z instead of k
        %RK4 eqns from Lecture
        k1 = h*f( t(z),y(z)  );
        k2 = h*f( t(z) + h/2,y(z)+ k1/2 );
        k3 = h*f( t(z) + h/2,y(z)+ k2/2 );
        k4 = h*f( t(z) + h,y(z)+ k3 );
        y(z+1) = y(z) + (      (k1 + 2*k2 + 2*k3 + k4 )/6       );
        t(z+1) = t(z) +  h; 
    end
    disp(['The true solution is found using RK4 with n=8192: ' num2str( y(nreal) ) ])
    sol = y(end); %this is the true solution stored in sol variable, tb used in error plots

%------------------------------------------------------------------------------------------------

%Parts 1 & 2 
% for loop to run the methods and graph them for every n number of steps
 n = 4;  %starting n value
 hold on 
for n= 2.^[2:12]   %n is already n = 4    go until n = 2^12 = 4096
   
    subplot(3,2,1);  %subplot for Euler's
    [t,y,Eularray] = eulers(f, n, T,sol);  %call function for Euler's
    eulmatrix = [eulmatrix Eularray]; %store values in matrix to use in error plotting
    hold on
    plot(t,y, 'LineWidth', 1) %plots Euler's method 
    title('Euler''s Method')
    xlabel('t')
    ylabel('y(t)')
    legend('n=4','n=8', 'n=16','n=32','n=64', 'n=128','n=256','n=512', 'n=1024','n=2048','n=4096','Location','northwest','FontSize',5) 
    hold off
     
    subplot(3,2,2); %subplot for RK2 Custom
    [tc, yc,custarray] = rk2custom(fc, n, T, 0.7,sol);   %call function for RK2 Custom; custom beta2 = 0.7
    custmatrix = [custmatrix custarray]; %store values in matrix to use in error plotting
    hold on
    plot(tc,yc, 'LineWidth', 1) %plots RK2 Custom
    title('Runge-Kutta 2nd Order Custom')
    xlabel('t')
    ylabel('y(t)')
    legend('n=4','n=8', 'n=16','n=32','n=64', 'n=128','n=256','n=512', 'n=1024','n=2048','n=4096','Location','northwest','FontSize',5) 
    hold off

    subplot(3,2,3); %subplot for RK2
    [t, y,rk2array] = rk2(f, n, T,0.5,sol);   %call function for RK2; beta2 = 0.5
    rk2matrix = [rk2matrix rk2array]; %store values in matrix to use in error plotting
    hold on
    plot(t,y, 'LineWidth', 1) %plots RK2 
    title('Runge-Kutta 2nd Order')
    xlabel('t')
    ylabel('y(t)')
    legend('n=4','n=8', 'n=16','n=32','n=64', 'n=128','n=256','n=512', 'n=1024','n=2048','n=4096','Location','northwest','FontSize',5) 
    hold off

    subplot(3,2,4); %subplot for RK4
    [t, y,rk4array] = rk4(f,n, T,sol); %call function for RK4
    rk4matrix = [rk4matrix rk4array]; %store values in matrix to use in error plotting
    hold on
    plot(t,y, 'LineWidth', 1) %plots RK4
    title('Runge-Kutta 4th Order')
    xlabel('t')
    ylabel('y(t)')
    legend('n=4','n=8', 'n=16','n=32','n=64', 'n=128','n=256','n=512', 'n=1024','n=2048','n=4096','Location','northwest','FontSize',5) 
    hold off
end  %end of the for loop
%------------------------------------------------------------------------------------------------

%Part 3 (con't)
    subplot(3,2,5)   %subplot for error plot vs log(n)
    narr = [];
    narr = 2.^[2:12]; %creates an array of n values to use in error plot
    hold on
    %to plot error fxn log of error of y(T) vs log(n) for all methods
    plot(log10(narr),log10(eulmatrix ), 'LineWidth', 1)
    plot(log10(narr),log10(rk2matrix ), 'LineWidth', 1)
    plot(log10(narr), log10(custmatrix ) , 'LineWidth', 1)
    plot(log10(narr),log10(rk4matrix ), 'LineWidth', 1)
    title('Error Plot: Log(Errors) vs Log(Steps)')
    xlabel('log(n)')
    ylabel('log(error)')
    legend('Euler''s','RK2', 'RK2 Custom','RK4', 'Location', 'southwest','FontSize',5) 
    hold off
%------------------------------------------------------------------------------------------------

%~~~~~~~~~~~~Final Problem 2~~~~~~~~~~~%
%Objective: Plot log of the error in y(T) vs log(F) where F = FEs. How do
%the resulting plots change? Why?
    subplot(3,2,6)   %subplot for FE plot
    %From lecture we know Euler's FE =  n, RK2 FE = 2*n, & RK4 FE = 4*n
    %so we assign these values to each method's FE array
    eulFarr = 2.^[2:12];
    rk2Farr = 2*( 2.^[2:12] ) ; 
    custFarr = 2*( 2.^[2:12] ) ; 
    rk4Farr = 4*( 2.^[2:12] ) ;
    hold on
    %plots the log of the function evaluations vs log of the errors for each method:
    plot(log10(eulFarr),log10(eulmatrix ), 'LineWidth', 1)
    plot(log10(rk2Farr),log10(rk2matrix ), 'LineWidth', 1)
    plot(log10(custFarr), log10(custmatrix ) , 'LineWidth', 1)
    plot(log10(rk4Farr),log10(rk4matrix ), 'LineWidth', 1)
    title('Error Plot: Log(Errors) vs Log(Function Evaluations)')
    xlabel('log(FE)')
    ylabel('log(error)')
    legend('Euler''s','RK2', 'RK2 Custom','RK4', 'Location', 'southwest','FontSize',5)
    hold off
    %~~~~~~~~~~~~Final Problem 2~~~~~~~~~~~%

%------------------------------------------------------------------------------------------------


%Parts 1 & 2 (con't)
%Below are the functions for the 4 methods:
%------------------------------------------------------------------------------------------------
%Function for Euler's Method
function [t, y, Eularray] = eulers(f,n, maxT,sol) %inputs are ydot (f), number of steps (n), T (maxT) and true solution
    %outputs t,y, and array with errors for error plot
    t(1) = 0; %t0
    y(1) = 1; %y0
    h = maxT/n; %step size, h
    Eularray = [];
    for k = 1:n
        y(k+1) =  y(k) + h*f( t(k),y(k) ) ;  %eqn for Euler's from Lecture
        t(k+1) = t(k) +  h; %go to the next t by adding the step size, h
         if t(k+1) == maxT %if statement to grab y at T for that n
             Eularray =   [Eularray  abs(y(k+1) - sol) ] ;  %vector storing errors at y(T) for each n
         end
    end
end
%------------------------------------------------------------------------------------------------
%Function for Runge-Kutta 2nd Order   
function [t, y,rk2array] = rk2(f,n, maxT,beta2,sol) %inputs are ydot (f), number of steps (n), T (maxT), beta2 and true solution
    %outputs t,y, and array with errors for error plot
    beta1 = 1 - beta2;
    v = 0.5/beta2;
    a = 0.5/beta2; 
    t(1) = 0; %t0
    y(1) = 1; %y0
    h = maxT/n; %step size, h
    rk2array = [];
    for z = 1:n     %use indices variable z
      y(z+1) = y(z) + h*( beta1*f( t(z),y(z)  ) + beta2*f(   t(z) + v*h  ,   y(z)+a*h*f( t(z),y(z) )    ) ); %eqn for RK2 from Lecture
      t(z+1) = t(z) +  h; %go to the next t by adding the step size, h
         if t(z+1) == maxT %if statement to grab y at T for that n
             rk2array =   [rk2array  abs(y(z+1) - sol)   ] ;  %vector storing errors at y(T) for each n
         end
    end
end
%------------------------------------------------------------------------------------------------
%Function for Runge-Kutta 2nd Order Custom  
function [tc, yc,custarray] = rk2custom(fc,n, maxT,beta2,sol) %inputs are ydot (fc), number of steps (n), T (maxT), beta2(custom) and true solution
    %outputs t,y, and array with errors for error plot
    beta1 = 1 - beta2;
    v = 0.5/beta2;
    a = 0.5/beta2;
    tc(1) = 0; %t0
    yc(1) = 1; %y0
    h = maxT/n; %step size, h
    custarray =   [];
    for z = 1:n+1     %use indices variable z
      yc(z+1) = yc(z) + h*( beta1*fc( tc(z),yc(z)  ) + beta2*fc(   tc(z) + v*h  ,   yc(z)+a*h*fc( tc(z),yc(z) )    )    );%eqn for RK2 from Lecture
       tc(z+1) = tc(z) +  h; %go to the next t by adding the step size, h
            if tc(z+1) == maxT %if statement to grab y at T for that n
                  custarray =   [custarray  abs(yc(z+1) - sol)   ] ;  %vector storing errors at y(T) for each n
            end
    end
end
%------------------------------------------------------------------------------------------------
%Function for Runge-Kutta 4th Order 
function [t, y,rk4array] = rk4(f,n, maxT,sol) %inputs are ydot (f), number of steps (n), T (maxT), and true solution
    %outputs t,y, and array with errors for error plot
    t(1) = 0; %t0
    y(1) = 1; %y0
    h = maxT/n; %step size, h
    rk4array =[];
    for z = 1:n     %use indices variable z instead of k
        k1 = h*f( t(z),y(z)  );
        k2 = h*f( t(z) + h/2,y(z)+ k1/2 );
        k3 = h*f( t(z) + h/2,y(z)+ k2/2 );
        k4 = h*f( t(z) + h,y(z)+ k3 );
        y(z+1) = y(z) + (      (k1 + 2*k2 + 2*k3 + k4 )/6       ); %eqns for RK4 from Lecture
       t(z+1) = t(z) +  h; %go to the next t by adding the step size, h
       if t(z+1) == maxT  %if statement to grab y at T for that n
              rk4array =   [rk4array  abs( y(z+1) - sol ) ];  %vector storing errors at y(T) for each n
       end
    end
   
end