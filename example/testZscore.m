% empty memory
clc, clear
load dataforZSCORE.mat
[row, col] = size(TXY);
set = row/5;
row1 = row - set;
tr = TXY(1:row1, 1:col - 1);
t1 = TXY(1:row1, col);
te = TXY(row1+1:end, 1:col - 1);
t2 = TXY(row1+1:end, 1:col);

% random initial fruit fly swarm location
XAxis = 10*rand(1,5) - 5;
YAxis = 10*rand(1,5) - 5;
maxIterations = 100;
sizePop = 20;

smellBest = inf;
for it = 1:maxIterations    
    % optimization started, use the sense of smell to find food
    for p = 1:sizePop
        % give the random direction and distance for the search of food 
        % using osphresis by an individual fruit fly.
        X(p, :) = XAxis + 2*rand(1,5) - 1;
        Y(p, :) = YAxis + 2*rand(1,5) - 1;
        
        % calculating the distance from the origin.
        D(p, :) = (X(p, :).^2 + Y(p, :).^2).^0.5;
        S(p, :) = 1./D(p, :);
        a = S(p, :);
        yc = tr*a';
        y = yc - t1;
        smell(p) = (sum(y.^2)/row1)^0.5;
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

figure(1)
plot(yy)
title('Optimization process')
xlabel('Iteration Number'), ylabel('RMSE')
figure(2)
plot(XBest, YBest, 'b.');
title('Fruit fly flying route')
xlabel('XAxis'), ylabel('YAxis')