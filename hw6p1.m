% MAE 107 HW 6 Problem 1  Fixed Point for n Eqns and n Solutions
% 
%Objective: Apply fixed point method to given eqns. Fixed pt fxn should
%call function that evals RH side of eqn. 

% Run for 2 diff ICs. for each find X^1 X^2 X^3 and run for any amt of
% iterations to get soln within 10^-4 error

%call function for fixed pt method
[ic, xpart, ypart, zpart, x, y, z, steps] = fixede(3, 2, 1)  %IC case 1
[ic, xpart, ypart, zpart, x, y, z, steps] = fixede(300, 200, 100)  %IC case 2

% function that outputs functions to be used in Fixed pt function
function [x1, x2, x3] = threef(x,y,z)
    % fxn that eval the three given functions x1 x2 x3 
    x1 = .25*sin(x + y + atan(z/2));
    x2 = .25*cos(x + y + atan(z/2));
    x3 = 1 + .25*cos(x + atan(z/2));
end

%fixed pt function
% takes initial conditions (x0,y0,z0 for case1 and case2) and returns next 3 iterations
%(xpart, ypart, zpart for both cases), estimates of solutions within 10^-4 range (xfin,
%yfin, zfin for both cases), # of steps to get to the estimate (steps) and
%what solutions correspond to which IC (ic)
function [ic, xpart, ypart, zpart, xfin, yfin, zfin, steps] = fixede(x0,y0,z0)
    % det. what inputs to be used
    if x0 == 3
        ic = 'Case 1 ICs: x^0 = 3, y^0 = 2, z^0 = 1'; %IC for X^0 case 1
    elseif x0 == 300
        ic = 'Case 2 ICs: x^0 = 300, y^0 = 200, z^0 = 100'; %IC for X^0 case 2
    end
    %setting ICs in arrays for each variable array
    x(1,1) = x0;
    y(1,1) = y0;
    z(1,1) = z0;
    n = 1;  %step 1
    % eval. first iteration to later use in the while loop that runs until
    % 10^-4
    [x(1,n+1), y(1,n+1), z(1,n+1)] = threef(x(1,n), y(1,n), z(1,n)); %setting values in the array by eval points using threef fxn
    n = 2; %so that matlab doesn't give an error for indices less than 1
    
    % while loop to check if each iteration output is close enough to actual ans by 10^-4
    while abs(x(1,n) - x(1,n-1)) > 10^(-4) || abs(y(1,n) - y(1,n-1)) > 10^(-4) || abs(z(1,n) - z(1,n-1)) > 10^(-4)
        [x(1,n+1), y(1,n+1), z(1,n+1)] = threef(x(1,n), y(1,n), z(1,n));
        n = n + 1; %if doesn't satisfy condition then go to next iteration and repeat 
    end
    steps = n;  %steps: returns # of steps that gives an ans close to the actual answer by 10^-4
    % returns values of iterations for X^1, X^2, X^3; from 1->3, but 2->4 bc matlab
    xpart = x(2:4);
    ypart = y(2:4);
    zpart = z(2:4);
    % returns ans within 10^-4 of actual
    xfin = x(end);
    yfin = y(end);
    zfin = z(end);
end

