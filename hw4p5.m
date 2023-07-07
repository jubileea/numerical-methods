% MAE 107 HW 4  Problem 5
% 
%{ Objective: Compute integration of f(x) by the left-endpoint rule, trap rule, 
% and corrected trap rule. 
% Obtain approximations for n=10^k, k from 1 to 4.  

%Then plot in matlab logbase10(errors) fxns versus log(n) for all 3 rules.
%Comment on slopes. By the graph estimate n steps req s.t. error < 10^-6

thefun(0,3)

function [f] = funct(x)
%for each x calculates f and stores it in f array
    f = sin(pi*x) - .5*cos(2*pi*x);
end

%Left endpoint integration
function [ILE] = LE(a,b)
    format long
    ILE = zeros(1,4);
    %take k from 10 to 10^4
    for k = 1:4
           n = 10^k;
           %step size
           h = (b-a)/n;
           %initialize variables for the for loop
           x = 0;
           arr1 = zeros(1,n);
           for r = 1:n
               %eval fxn at x and store
               arr1(1,r) = sin(pi*x) - .5*cos(2*pi*x);
               %incr x by h for next step
               x = x+h;
           end
           %sum LE integration
           ILE(1,k) = h*sum(arr1);
    end
end

%Trapezoid integration
function [ITrap] = trap(a,b)
    format long
    ITrap = zeros(1,4);
    %for k from 10 to 10^4
    for k = 1:4
        n = 10^k;
        %step size
        h = (b-a)/n;
        x = h; 
        arr2 = zeros(1,n);
        for r = 2:n  %start at 2 to skip first fxn eval -> x1
            %eval fxn at x
            arr2(1,r) = sin(pi*x) - .5*cos(2*pi*x);
            %incr x by h
            x = x+h;
        end
        %find f0 and f3 for lin interp
        f0 = sin(0) - .5*cos(0);
        f1= sin(pi*x) - .5*cos(2*pi*x);
        arr3 = (f0+f1)/2;
        %trap summation
        ITrap(1,k) = h*(arr3+sum(arr2));
    end
end

%Corrected trapezoid integration
function [Ict] = ct(a,b)
format long
Ict = zeros(1,4);
%iterate for k from 10 to 10^4
 for k = 1:4
        n = 10^k;
        %step size
        h = (b-a)/n;
        x = h; 
        arr4 = zeros(1,n);
        for r = 2:n
            %eval fxn at x
            arr4(1,r) = sin(pi*x) - .5*cos(2*pi*x);
            %incr x by h
            x = x+h;
        end
        %find f0 and f3 for lin interp
        ctf0 = sin(0) - .5*cos(0);
        ctf1= sin(pi*x) - .5*cos(2*pi*x);
        arr5 = (ctf0+ctf1)/2;
        %corrected trap term
        correct = 3*ctf0 - 4*arr4(1,2) + arr4(1,3) + arr4(1,n-1) - 4*arr4(1,n) + 3*ctf1;
       
        %ct summation
        Ict(1,k) = h*(arr5+sum(arr4)-(1/24)*correct); 
 end
end


function thefun(a,b)
    %int fxns get solution vectors in k range
    [ILE] = LE(a,b);
    [ITrap] = trap(a,b);
    [Ict] = ct(a,b);
    
    %manual calc of integral to find true soln
    
    x=0;
    f0= -(sin(2*pi*x) + 4*cos(pi*x))/(4*pi);
    x=3;
    f3= -(sin(2*pi*x) + 4*cos(pi*x))/(4*pi);
    Iactual = f3-f0; 
    
    %log err vecs
    logLE = log10(abs(ILE - Iactual));
    logtrap = log10(abs(ITrap - Iactual));
    logct = log10(abs(Ict - Iactual));
    
    %calc log(n)
    n= zeros(1,4);
        for w=1:4
            n(1,w) = 10^w;
        end
    
    %plotting
    
    plot(log10(n),logLE,'b','LineWidth', 5)
    hold on
    plot(log10(n),logtrap, 'g', 'LineWidth', 2)
    plot(log10(n),logct, 'r')

    legend('log10(LE error)','log10(Trap error)', 'log10(CT error)')
    xlabel('log10(n)')
    ylabel('log10(error)')

end







