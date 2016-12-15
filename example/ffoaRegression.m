% empty memory
clc, clear

w = [3; 1];
x = [ones(10,1), (1:10)'];
y = x*w + 0.1*rand(10, 1);

% random initial fruit fly swarm location
XAxis = 10*rand(1,2) - 5;
YAxis = 10*rand(1,2) - 5;
maxIterations = 100;
sizePop = 20;

smellBest = inf;
for it = 1:maxIterations    
    % optimization started, use the sense of smell to find food
    for p = 1:sizePop
        % give the random direction and distance for the search of food 
        % using osphresis by an individual fruit fly.
        X(p, :) = XAxis + 2*rand(1,2) - 1;
        Y(p, :) = YAxis + 2*rand(1,2) - 1;
        
        % calculating the distance from the origin.
        D(p, :) = (X(p, :).^2 + Y(p, :).^2).^0.5;
        S(p, :) = 1./D(p, :);
        a = S(p, :);
        yc = x*a';
        yDelta = yc - y;
        smell(p) = (sum(yDelta.^2)/10)^0.5;
    end
    [bestSmell, bestIndex] = min(smell);
    
    % keep the best smell concentration value and x,y coordinate, and at 
    % this moment, the fruit fly swarm will use vision to fly towards that 
    % location.
    if bestSmell < smellBest
        XAxis = X(bestIndex, :);
        YAxis = Y(bestIndex, :);
        bestS = S(bestIndex, :);
        smellBest = bestSmell;
    end
    yy(it) = smellBest;
    XBest(it, :) = XAxis;
    YBest(it, :) = YAxis;
end

wEstimate = 1./sqrt((XBest(end, :).^2 + YBest(end, :).^2))
figure(1)
plot(yy)
title('Optimization process')
xlabel('Iteration Number'), ylabel('RMSE')
figure(2), hold on
axis([min(XBest(:))-5 max(XBest(:))+5 ...
    min(YBest(:))-5 max(YBest(:))+5]);
for id = 1:maxIterations
    plot(XBest(id, :), YBest(id, :), 'o');
    drawnow;
    pause(0.05);
end
plot(XBest, YBest)
text(XBest(end), YBest(end), {['(', num2str(XBest(end, 1)), ', ',...
    num2str(YBest(end, 1)), ')'], ['(', num2str(XBest(end, 2)), ', ',...
    num2str(YBest(end, 2)), ')']}, 'Interpreter', 'latex');
title('Fruit fly flying route', 'FontSize', 14)
xlabel('XAxis'), ylabel('YAxis')