% MAE 107 HW 3  Problem 2 
% 
%{ Objective: Compute approximations to the derivative, f'(x0) for
% specified h  for j from 0 to 10  for D, Dhat, and Dtilde, as well as
% their respective errors e, ehat, and etilde

%Then plot in matlab logbase10( respective errors) fxns versus log(h) in
%different colors on the same graph, write text on graph indicating what
%color for what curve

%{
also show on the graph roughly where the catastrophic-subtraction (Cat.
Sub.) errors dominate
%}

syms x;
f(x)=(cos(pi*x))*exp(-2*x);  %given f(x)
fprime(x)= -(cos(pi*x))*2*exp(-2*x) - pi*(sin(pi*x))*(cos(pi*x));  %solved for f'(x) by hand
x0 = 1;  %given x0
v1 = f(x0); %for easier code, storing terms as v1, v2,...etc

%creating empty arrays for each derivative approx and error
Darray = [];
earray = [];
Dhatarray = [];
ehatarray = [];
Dtildearray = [];
etildearray = [];
harray = []; %empty array to store h values for j from 0 to 10
h = 10^(-j);
%for loop for evaluating Derivatives and their respective error for j from 0 to 10 and
%putting values into their respective empty arrays (see above)
 for i = 1:1:11
     j = i-1;  %start at j=0
     h = 10^(-j);  %given eqn for h
     v2 = f(x0+h);
     D = (v2 - v1)/h;  %given eqn for D
     e = abs(D - fprime(x0));  %error for D(x0) from lecture notes

    v3 = f(x0-h);
    Dhat = (v2 - v3)/(2*h);  %given eqn for Dhat
    ehat = abs(Dhat - fprime(x0)); %error for Dhat(x0) from lecture notes

    v4 = f(x0+2*h);
    v5 = f(x0-2*h);
    Dtilde =  ( ( 8*(v2 - v3) ) -  (v4 - v5) )/(12*h); %given eqn for Dtilde
    etilde = abs(Dtilde - fprime(x0)); %error for Dtilde(x0) from lecture notes
    
    %storing the new values in their respective arrays for j is 0 to 10
    Darray = [Darray D];
    earray = [earray e];
    Dhatarray = [Dhatarray Dhat];
    ehatarray = [ehatarray ehat];
    Dtildearray = [Dtildearray Dtilde];
    etildearray = [etildearray etilde];
    harray = [harray h];  

    i= i+1;  %update position in the array
 end
   Darray = (Darray);  %vector of D(1) values for j from 0 to 10
   earray = (earray); %vector of errors of D(1) for j from 0 to 10
   harray = (harray);  %vector storing h values for j from 0 to 10
   Dhatarray = Dhatarray;  %vector of Dhat(1) values for j from 0 to 10
   ehatarray = ehatarray; %vector of errors of Dhat(1) for j from 0 to 10
    Dtildearray = Dtildearray;  %vector of Dtilde(1) values for j from 0 to 10
    etildearray = etildearray;   %vector of errors of Dtilde(1) for j from 0 to 10

%PLOTTING 
% logbase10( respective errors, 3 fxns) vs log(h) in
%different colors on the same graph, write text on graph indicating what
%color for what curve

logharray = double(log10(harray)); %logbase10(h) array for j from 0 to 10
logearray = double(log10(earray)); %logbase10(e) array for j from 0 to 10
logehatarray = double(log10(ehatarray)); %logbase10(ehat) array for j from 0 to 10
logetildearray = double(log10(etildearray));

plot(logharray,logearray,'DisplayName','log10(e_h)')
hold on
plot(logharray,logehatarray,'DisplayName','log10(ê_h)')
hold on
plot(logharray,logetildearray,'DisplayName','log10(ẽ_h)')
axis([-10 0 -17 2])

%rough interval of where Cat. Sub. dominates for e
xe = [-10 -8 -8 -10]; 
ye = [-17 -17 2 2];
patchplot = patch(xe, ye, 'blue', 'FaceAlpha', .2)  %patch command to fill in the interval
%rough interval of where Cat. Sub. dominates for ehat
xehat = [-8 -6 -6 -8];
yehat = [-17 -17 2 2];
patchplot2 = patch(xehat, yehat, 'red', 'FaceAlpha', .2)  %patch command to fill in the interval
%rough interval of where Cat. Sub. dominates for etilde
xetilde = [-6 -4 -4 -6];
yetilde = [-17 -17 2 2];
patchplot3 = patch(xetilde, yetilde, 'yellow', 'FaceAlpha', .2)  %patch command to fill in the interval

%code for the legend, labels for the x and y axis, and title of graph
legend('log10(e_h)','log10(ê_h)','log10(ẽ_h)', ...
    'Cat. Sub. Region for e_h', 'Cat. Sub. Region for ê_h', 'Cat. Sub. Region for ẽ_h', 'Location', 'northwest')
xlabel('log10(h)')
ylabel('log10(error)')
title('Errors of Derivative Approximations for f(x)')



