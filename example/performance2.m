FUN11 = @(x)(-5 + (x+3)^2);
[peak1, route1, yy1] = ffoa(FUN11, 'maxIterations', 100, 'popSize', 20,...
    'minmax', 'min', 'plotFlag', 0);
[peak2, route2, yy2] = iffoa(FUN11, 'maxIterations', 100, 'popSize', 20,...
    'minmax', 'min', 'plotFlag', 0);
h = plot([yy1, yy2], 'LineWidth', 2);
set(h(1), 'LineStyle', '--');
legend({'ffoa', 'iffoa'}, 'FontSize', 12)
xlabel('Iteration Number'), ylabel('Smell')
title('Optimization process')
grid on