% test with different population of fruit fly swarm
FUN = @(x)(-5 + x^2);
figure(1), hold on, grid on
i = 0;
for popSize = [3 6 9]
    [peak, route] = ffoa(FUN, 'maxIterations', 20, 'popSize', popSize,...
        'minmax', 'min');
    i = i + 1;
    subplot(3, 1, i)
    plot(route(:, 1), route(:, 2), 'LineWidth', 1, 'LineStyle', '-', ...
        'Marker', 'o', 'MarkerSize', 5, 'MarkerFaceColor', 'r');
    xlabel('XAxis'), ylabel('YAxis')
    title(['Fruit fly flying route with population size = ', ...
        num2str(popSize)]);
end
hold off