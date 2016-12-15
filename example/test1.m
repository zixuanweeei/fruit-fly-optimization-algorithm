% empty memory
clc
clear

% random initial fruit fly swarm location
XAxis = 10*rand();
YAxis = 10*rand();

% set parameters
maxIterations = 100;
sizePop = 5;
smellBest = inf;

% % optimization started, use the sense of smell to find food
% for i = 1:sizePop
%     % give the random direction and distance for the search of food using
%     % osphresis by an individual fruit fly.
%     X(i) = XAxis + 2*rand() - 1;
%     Y(i) = YAxis + 2*rand() - 1;
%     % since the food location cannot be known, the distance to the origin
%     % is thus estimated first(Dist), then the smell concentration judgment
%     % value(S) is calculated, and this value is the reciprocal of distance.
%     D(i) = (X(i)^2 + Y(i)^2)^0.5;
%     S(i) = 1/D(i);
%     % substitude smell concentration judgment value(S) into smell
%     % concentration judgment function(or called Fitness function)so as to
%     % find the smell concentration(Smelli)of the individual location of the
%     % fruit fly.
%     smell(i) = -5 + S(i)^2;
% end
% % find out the fruit fly with maximal smell concentration(finding the
% % maximal value)among the fruit fly swarm.
% [bestSmell, bestIndex] = min(smell);
% 
% % keep the best smell concentration value and x,y coordinate, and at this
% % moment, the fruit fly swarm will use vision to fly towards that location.
% XAxis = X(bestIndex);
% YAxis = Y(bestIndex);
% smellBest = bestSmell;

% interative optimization start
for g = 1:maxIterations
    % give the random direction and distance for the search of food using
    % osphresis by an individual fruit fly.
    for i = 1:sizePop
        X(i) = XAxis + 2*rand() - 1;
        Y(i) = YAxis + 2*rand() - 1;
        % since the food location cannot be known, the distance to the 
        % origin is thus estimated first(Dist), then the smell 
        % concentration judgment value(S) is calculated, and this value is 
        % the reciprocal of distance.
        D(i) = (X(i)^2 + Y(i)^2)^0.5;
        S(i) = 1/D(i);
        % substitude smell concentration judgment value(S) into smell
        % concentration judgment function(or called Fitness function) so as
        % to find the smell concentration(smelli) of the individual
        % location of the fruit fly.
        smell(i) = -5 + S(i)^2;
    end
    % find out the fruit fly with maximal smell concentration (finding the
    % maximal value)among the fruit fly swarm.
    [bestSmell, bestIndex] = min(smell);
    % determine whether the smell concentration better than the previous
    % iteration of concertration, if yes then keep the best smell
    % concentration value and x,y coordinate, and at this moment, the fruit
    % fly swarm will use vision to fly towards that location.
    if bestSmell < smellBest
        XAxis = X(bestIndex);
        YAxis = Y(bestIndex);
        smellBest = bestSmell;
    end
    yy(g) = smellBest;
    XBest(g) = XAxis;
    YBest(g) = YAxis;
    figure(2), hold on
    axis([0 100 0 100])
    plot(XBest(g), YBest(g), 'r.');
    drawnow;
    pause(0.1);
end

% draw smell concentration of each iteration
figure(1)
plot(yy, 'LineWidth', 1.5);
title('Optimization process', 'FontSize', 12);
xlabel('Iteration Number',  'FontSize', 12), ylabel('Smell', 'FontSize', 12)
figure(2)
plot(XBest, YBest, 'b-')
text(XBest(end), YBest(end), ['(', num2str(XBest(end)), ', ',...
    num2str(YBest(end)), ')'], 'Interpreter', 'latex');
title('Fruit fly flying route', 'FontSize', 14)
xlabel('XAxis'), ylabel('YAxis')