% MAE 107 HW 3  Problem 3
% 
%Objective: Compute approximations to the derivative, f'(x0) for
% specified h  for j from 0 to 8  for D, as well as
% its respective error e

%Then plot in matlab logbase10(e) fxns versus log(h) in
%different colors on the same graph, write text on graph indicating what
%color for what curve

%{
also show on the graph roughly where the catastrophic-subtraction (Cat.
Sub.) errors dominate and where Taylor polynomial derived error dominates
%}

syms x;
f(x)=x + x^(7/2);  %given f(x)
fprime(x)= 1+ (7/2)*x^(5/2);  %solved for f'(x) by hand
x0 = 0;  %given x0 
v1 = f(x0); %for easier code, storing terms as v1, v2,...etc

%creating empty arrays for each derivative approx and error 
Darray = [];
earray = [];
harray = []; %empty array to store h values for j from 0 to 8
h = 10^(-j);
%for loop for evaluating Derivatives and their respective error for j from 0 to 8 and
%putting values into their respective empty arrays (see above)
 for i = 1:1:9
     j = i-1; %start at j=0
     h = 10^(-j);  %given eqn for h
     v2 = f(x0+h);
     D = (v2 - v1)/h;  %given eqn for D
     e = abs(D - fprime(x0));  %error for D(x0) from lecture notes
    
    %storing the new values in their respective arrays for j from 0 to 8
    Darray = [Darray D];
    earray = [earray e];
    harray = [harray h];  

    i= i+1;  %update position in the array
 end
   Darray = (Darray);  %vector of D(x0) values for j from 0 to 8
   earray = (earray); %vector of errors of D(x0) for j from 0 to 8
   harray = (harray);  %vector storing h values for j from 0 to 8

%PLOTTING 
% logbase10( respective errors, 1 fxn) vs log(h) in
%different colors on the same graph, write text on graph indicating what
%color for what curve

logharray = double(log10(harray)); %logbase10(h) array for j from 0 to 8
logearray = double(log10(earray)); %logbase10(e) array for j from 0 to 8

plot(logharray,logearray)
hold on
axis([-10 0 -25 0])

%code for the legend, labels for the x and y axis, and title of graph
legend('log10(e_h)', 'Location', 'northwest')
xlabel('log10(h)')
ylabel('log10(error)')
title('Errors of Derivative Approximations for f(x)')

