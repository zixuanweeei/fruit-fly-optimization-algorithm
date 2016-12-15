% test function 
clear, clc
FUN = @(x)(sin(x - 2) + 0.01*x.^2);
[peak, route] = ffoa(FUN, 'maxIterations', 100, 'popSize', 20,...
    'minmax', 'min', 'plotFlag', 1);
peak