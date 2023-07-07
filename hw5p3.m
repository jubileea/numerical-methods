% MAE 107 HW 5  Problem 3 Bisection Algorithm
% 
%Objective: Write code for bisection algorithm and apply it to find the root of g(x). Use a0,
%b0, and epsilon as inputs. Code needs to det. # of n steps based on the
%inputs. No need to error check for bad input data. 

% Apply code to a0=0, b0=4 and epsilon = 10^-5

%setup
clear all; 
close all; 
clc;
syms x
%inputs
a0 = 0; % given 
b0 = 4; % given 
epsilon = 10^(-5); % given epsilon value
g(x) = min( [0.5+sin(pi*x) + (3*x)  5-2*x*exp(1/(1+x^2))] ); % given function

% call function
[r,n] = bisection(g, a0, b0, epsilon);   %r = root

% bisection algorithm 
function [r,n] = bisection(g, a0, b0, epsilon) 
    a(1) = a0;  %  starting a value
    b(1) = b0;  %  starting b value
    n = 0;  % initialize number of steps
    for k = 1:100    % iteration, assuming n<100  (n = k+1)

        c(k+1) = (a(k) + b(k)) / 2; % from notes, avg value between a and b
        if g(c(k+1))*g(b(k)) < 0    % first step in notes loop
            a(k+1) = c(k+1);    % change variables
            b(k+1) = b(k);  % change variables
          else
            a(k+1) = a(k);  % change variables
            b(k+1) = c(k+1);    % change variables
        end
     
        if abs(abs(g(c(k+1))) - abs(g(c(k)))) < epsilon  % if loop to check if root has been found
            break   % ends for loop if found root
        end

    end  %end of the for loop from k->100 or until found root
    n = k + 1;    % amount of steps, n, to find the root
    r = c(:,end);
    disp(['The root is ' num2str(r) '.'])  % displays root 
    disp(['It took ' num2str(n) ' steps to find with the given epsilon.'])    % displays step count 
end
