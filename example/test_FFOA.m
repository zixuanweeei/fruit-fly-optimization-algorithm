clc
clear
X_axis=10*rand();
Y_axis=10*rand();
% X_axis=0;
% Y_axis=10;
generations=10;
population=20;
for i=1:population    
    X(i)=X_axis+2*rand()-1;    
    Y(i)=Y_axis+2*rand()-1;    
    D(i)=(X(i)^2+Y(i)^2)^0.5;    
    S(i)=1/D(i);    
    Smell(i)=-5+S(i)^2;
end
[bestSmell bestIndex]=min(Smell);
X_axis=X(bestIndex);
Y_axis=Y(bestIndex);
Smellbest=bestSmell
for g=1:generations    
    for i=1:population        
        X(i)=X_axis+2*rand()-1;        
        Y(i)=Y_axis+2*rand()-1;        
        D(i)=(X(i)^2+Y(i)^2)^0.5;        
        S(i)=1/D(i);        
        Smell(i)=-5+S(i)^2;        
    end    
    [bestSmell bestIndex]=min(Smell);    
    if bestSmell>Smellbest        
        X_axis=X(bestIndex);        
        Y_axis=Y(bestIndex);        
        Smellbest=bestSmell;        
    end    
    yy(g)=Smellbest    
    Xbest(g)=X_axis;    
    Ybest(g)=Y_axis;    
end
%Smellbest
%   Xbest
%   Ybest
% yy
figure(1)
plot(yy)
title('Optimization process','fontsize',12)
xlabel('Iteration Number','fontsize',12);
ylabel('Smell','fontsize',12);
figure(2)
plot(Xbest,Ybest,'*')
title('Fruit fly flying route','fontsize',14)
xlabel('X-axis','fontsize',12);
ylabel('Y-axis','fontsize',12);