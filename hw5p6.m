% MAE 107 HW 5  Problem 6 Secant Method
% 
%Objective: Write code for secant method and apply it to find the root of f(x). Use x0,
%x1, and n as inputs.  

% Make a graph showing how x2 was obtained from x0 and x1, and also x3 from x1 and
% x2. Discuss rate of convergence. 

%setup
clear all; 
close all; 
clc;
syms x

%inputs
x0 = 3; % given 
x1 = 2; % given 
n = 8; % given 

f(x) = sin(x) + (5/4)*x - 2; % given function

% call function
[r,vecx,vecf,froot] =  secant(f,x0,x1,n); 

% secant method  
function [r,vecx,vecf,froot] = secant(f,x0,x1,n)   %r = root
    x(2) = x0; % given, starting from k=2 because matlab can't do indices=0 
    x(3) = x1; % given
    for k = 3:10    % iteration starting from k=3   
        x(k+1) = x(k) - ((f( x(k)))*(x(k)-x(k-1))) / ( f(x(k)) - f(x(k-1) ) ); %eqn for secant method from notes
        %effx( x(k+1)  )  = f(x(k+1));
    end
    r = x(10);
    froot = (  f( x(10) )  );  %fxn at root
    str_e = sprintf('%0.5e',froot)  %formats floating pt #
    vecx = x
    vecf = f(x) 
    disp(['The root is ' num2str(r) '.'])  % displays root 
    disp(['The function at the root is ' num2str(str_e) '.'])  % displays fxn at root 

    %----------------------PLOTTING  f(x) vs x , the lines connecting x1 x0 to x2   and x1 x2 to x3

    fplot(f,'b','LineWidth', 1,'DisplayName','f(x)')  %plot the function, f(x)
    hold on
    b = [x(2) x(4)];
    y = [f(x(2)) 0];
    line(b,y,'Color','red','DisplayName','x2') % plot the line from x1 to x0 to get x2
    line([x(3) x(4)],[f(x(3)) f(x(4))] , 'Color','g','DisplayName','x3')  % plot the line from x1 to x2 to get x3
   
    %lines connecting the points to the function f(x)
    line([x(2) x(4)],[0 0] , 'Color','b', 'LineStyle', '--') %line from x0 to x2
    line([ x(4) x(4)],[f(x(4)) 0] , 'Color','b', 'LineStyle', '--') %line from f(x2) to 0
    line([ x(3) x(3)],[f(x(3)) 0] , 'Color','b', 'LineStyle', '--') %line from f(x1) to 0
    line([ x(2) x(2)],[f(x(2)) 0] , 'Color','b', 'LineStyle', '--') %line from f(x0) to 0


    %label x0, x1, x2, x3
    v = [x(2) x(3) x(4)  x(5) ];
    w = [0 0 0  0];
    labels = {'x_0','x_1','x_2','x_3'};
    plot(v,w,'o','Color','k')
    text(v,w,labels,'VerticalAlignment','top','HorizontalAlignment','left')

    %label where x0, x1, x2 are on f(x) to help draw connecting lines
    h = [ x(2) x(3) x(4)];
    g = [f(x(2)) f(x(3)) f(x(4))];
    plot(h,g,'o','Color', 'b')


    %setup of graph
    title('Secant Method')
    xlabel('x')
    ylabel('f(x)')
     axis([-1.5 4 -4.5 2.5])
     legend('Location','southeast')

end


