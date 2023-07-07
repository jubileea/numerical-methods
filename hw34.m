% MAE 107 HW 3  Problem 4
% 
%Objective: Compute approximations to the derivative, f''(x0) for
% specified h  for j from 0 to 5  for D, as well as
% its respective error e

%Then plot in matlab logbase10(e2) fxns versus log(h) in
%different colors on the same graph, write text on graph indicating what
%color for what curve

%{
also show on the graph roughly where the catastrophic-subtraction (Cat.
Sub.) errors dominate and where Taylor polynomial derived error dominates
%}

 syms x;
 f(x) = log(x^2+2);  %given function, f(x)
 fdoubleprime(x) = ( -2*(x^2+2) )/( (x^2+2)^2 );  %solved for f''(x) by hand
x0 = 0;  %given x0 
v1 = f(x0); %for easier code, storing terms as v1, v2,...etc
%creating empty arrays for each derivative approx and error 
D2array = [];
e2array = [];
harray = []; %empty array to store h values for j from 0 to 5
h = 10^(-j);
%for loop for evaluating Derivatives and their respective error for j from 0 to 5 and
%putting values into their respective empty arrays (see above)
 for i = 1:1:6
     j = i-1; %to start at j=0
     h = 10^(-j);  %given eqn for h
     v2 = f(x0+h);
     v3 = f(x0-h);
     D2 = (v2 + v3 - 2*v1)/(h^2);  %given eqn for D2
     e2 = abs(D2 - fdoubleprime(x0));  %error for D(x0) from lecture notes
    %storing the new values in their respective arrays for j from 0 to 5
    D2array = [D2array D2];
    e2array = [e2array e2];
    harray = [harray h];  
    i= i+1;  %update position in the array
 end
 D2array = [D2array];
  e2array = [e2array];

  %PLOTTING 
% logbase10( respective errors, 1 fxn) vs log(h) in
%different colors on the same graph, write text on graph indicating what
%color for what curve

logharray = double(log10(harray)); %logbase10(h) array for j from 0 to 5
loge2array = double(log10(e2array)); %logbase10(e) array for j from 0 to 5

plot(logharray,loge2array)
hold on
axis([-8 0 -12 0])

%code for the legend, labels for the x and y axis, and title of graph
legend('log10(e^2_h)', 'Location', 'northwest')
xlabel('log10(h)')
ylabel('log10(error)')
title('Error of 2nd Derivative Approximation for f(x)')



