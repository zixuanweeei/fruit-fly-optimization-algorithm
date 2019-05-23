% FFOA fruit fly optimization algorithm.
function [peak, route, yy] = iffoa(FUN, varargin)

if ~mod(nargin, 2)
    error('MATLAB:narginchk:notEnoughInputs', ...
        'I have no idea about this, you can guess it');
end

maxIterations = 100;
popSize = 20;
plotFlag = 0;

for ind = 1:2:nargin-1
    switch lower(varargin{ind})
        case 'maxiterations'
            maxIterations = varargin{ind + 1};
        case 'popsize' 
            popSize = varargin{ind + 1};
        case 'minmax'
            if strcmp(varargin{ind + 1}, 'min')
                flagMinMax = 0;
            else
                flagMinMax = 1;
            end
        case 'plotflag'
            plotFlag = varargin{ind + 1};
        otherwise
            error('The function don''t support this parameter');
    end
end
if ~exist('flagMinMax', 'var')
    error('You must specify the parameter ''MinMax''')
end

% random initial fruit fly swarm location
XAxis = 10*rand() - 5;
YAxis = 10*rand() - 5;

% set parameters and variables
if flagMinMax
    smellBest = -inf;
else
    smellBest = inf;
end
X = zeros(popSize, 1);
Y = zeros(popSize, 1);
D = zeros(popSize, 1);
S = zeros(popSize, 1);
smell = zeros(popSize, 1);
yy = zeros(maxIterations, 1);
XBest = yy;
YBest = XBest;

% interative optimization start
for g = 1:maxIterations
    % give the random direction and distance for the search of food using
    % osphresis by an individual fruit fly.
    for i = 1:popSize
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
        if (X(i) < 0 && Y(i) > 0) || (X(i) > 0 && Y(i) < 0)
            S(i) = -S(i);
        end
        smell(i) = FUN(S(i));
    end
    % find out the fruit fly with maximal smell concentration (finding the
    % maximal value)among the fruit fly swarm.
    if flagMinMax
        [bestSmell, bestIndex] = max(smell);
    else
        [bestSmell, bestIndex] = min(smell);
    end
    % determine whether the smell concentration better than the previous
    % iteration of concertration, if yes then keep the best smell
    % concentration value and x,y coordinate, and at this moment, the fruit
    % fly swarm will use vision to fly towards that location.
    if flagMinMax
        if bestSmell > smellBest
            XAxis = X(bestIndex);
            YAxis = Y(bestIndex);
            smellBest = bestSmell;
        end
    else
        if bestSmell < smellBest
            XAxis = X(bestIndex);
            YAxis = Y(bestIndex);
            smellBest = bestSmell;
        end
    end
    yy(g) = smellBest;
    XBest(g) = XAxis;
    YBest(g) = YAxis;
end
peak = yy(end);
route = [XBest, YBest];

if plotFlag
    % draw smell concentration of each iteration
    figure(1)
    plot(yy, 'LineWidth', 1.5);
    title('Optimization process', 'FontSize', 12);
    xlabel('Iteration Number',  'FontSize', 12), ylabel('Smell', 'FontSize', 12)
    figure(2), hold on
    axis([min(XBest)-5 max(XBest)+5 min(YBest)-5 max(YBest)+5]);
    h = animatedline;
    h.LineStyle = 'none'; h.Marker = '.'; h.Color = 'r';
    for id = 1:maxIterations
        addpoints(h, XBest(id), YBest(id));
        drawnow
    end
    plot(XBest, YBest, 'b-')
    text(XBest(end), YBest(end), ['(', num2str(XBest(end)), ', ',...
        num2str(YBest(end)), ')'], 'Interpreter', 'latex');
    title('Fruit fly flying route', 'FontSize', 14)
    xlabel('XAxis'), ylabel('YAxis')
end