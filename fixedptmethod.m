
% MAE 107 HW 5  Problem 8  Fixed Point
% 
%Objective: Apply fixed point method to the two forms from #7  (f_1 and f_2) (did f_1 by hand). 
% (this is only for f_2.) 
% Run until diverging or iterates don't change by more than 10^-5.   

%setup
clear all; 
close all; 
clc;

%inputs
to = 10^(-5);
nm = 20;
x0=0;
x0two = 2;
x0tho = 1000;
f=@(x) (1/4)*atan(2*x + 0.5);  % given, f_2
% call function  for x0=0, x0=2, x0=1000
 fixedpt(f,x0,to, nm)  
  fixedpt(f,x0two,to, nm) 
   fixedpt(f,x0tho,to, nm) 
   function sol=fixedpt(fun,x,bnd,nmax)    %x input is x0 , 0 in the first case
    i = 1;
    g = feval(fun,x);  %setting g = function evaluated at initial x0  
 
        if g==x  %when reach error of 0
            disp([ 'The fixed point is ' , g]) 
        end 
        
         while abs(x-g) > bnd && i+1 <=nmax   %while the iterates difference is greater than the bound, 10^-5
             i = i+1
             x = g; 
             g = feval(fun,x);
         end
       disp([ 'The fixed point is ' , num2str(g)]) 
end



