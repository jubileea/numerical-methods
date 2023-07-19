# numerical-methods
Code from my numerical methods class at university. 
The following are descriptions of each of my code files

hw3probl2.m -> HW 3 Problem 2 
- Objective: Compute approximations to the derivative, f'(x0) for
 specified h  for j from 0 to 10  for D, Dhat, and Dtilde, as well as
 their respective errors e, ehat, and etilde
- Then plot in Matlab logbase10 (of the respective errors) functions versus log(h) in
different colors on the same graph, write text on the graph indicating what
color for what curve
- Also show on the graph roughly where the catastrophic subtraction (Cat.
Sub.) errors dominate



hw3p3.m -> HW 3 Problem 3
- Objective: Compute approximations to the derivative, f'(x0) for specified h  for j from 0 to 8  for D, as well as
 its respective error e
- Then plot in Matlab logbase10(e) functions versus log(h) in
different colors on the same graph, write text on the graph indicating what
color for what curve
- Also show on the graph roughly where the catastrophic subtraction (Cat.
Sub.) errors dominate and where Taylor polynomial derived error dominates.


hw34.m -> HW 3 Problem 4 
- Objective: Compute approximations to the derivative, f''(x0) for
 specified h  for j from 0 to 5  for D, as well as
 its respective error e
- Then plot in Matlab logbase10(e2) functions versus log(h) in
different colors on the same graph, write text on the graph indicating what
color for what curve
- Also show on the graph roughly where the catastrophic subtraction (Cat.
Sub.) errors dominate and where Taylor polynomial derived error dominates


*Descriptions for hw4-6 coming soon, but also found at the beginning of each .m file


JL_P1.m -> Final Problems 1 and 2
Objective: Use Euler's method, RK2 (Runge-Kutta 2), and RK4 (Runge-Kutta 4) to solve
- ydot = e^(-y) x (sin(t+2 x pi x y) ) ; 
- y0 = 1;          
- up to time T=2  with B2 = 0.5 (beta2 = 0.5) 
%--------------------------------------------------------------
- Part 2:
- Also create RK2 of your own, choosing B2 different from .5 and 1 . 
- Use varying steps  n = 2^i   first i = 2, until i = 12 (last n is 4096) 
%-------------------------------------------------------------
- Part 3:
- Plot solutions on one or more graphs w diff colors for the methods
assume RK 4 with n= 8192 = true solution
- Plot log of the error vs log(n) for all 4 graphs -> 4 lines
- Comment on the slopes

JL_p3.m -> Final Problem 3
Objective: Use RK4 to solve
- ydot = g(t,y)
- y0 = 4   
- g is the solution of z = exp(  -(1+sin(z) )  ) - ( ( sin(t+y) )^2) x (1+z^2)^(1/3)   ****in this code, b = z
- if y = pi/2 and t = 1 -> g is the solution of fixed pt eqn z up to time T=6  with B2 = 0.5
%-------------------------------------------------------------
- Plot solution approx for varying steps  n = [8 16 32 64 128 256 512] 
%-------------------------------------------------------------
- Explain using the same or different n for RK4 and FPI (fixed point method)



