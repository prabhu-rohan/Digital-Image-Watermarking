clc;
clear;
close all;
%% Problem Definition

CostFunction=@(x,y) (1/x)-y;        % Cost Function

nVar=1;             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin=0.001;         % Decision Variables Lower Bound
VarMax= 0.1;         % Decision Variables Upper Bound

%% ABC Settings

MaxIt=100;              % Maximum Number of Iterations

nPop=20;               % Population Size (Colony Size)

nOnlooker=nPop;         % Number of Onlooker Bees

L=round(0.6*nVar*nPop); % Abandonment Limit Parameter (Trial Limit)

a=1;                    % Acceleration Coefficient Upper Bound

%% Initialization

% Empty Bee Structure
empty_bee.Position=[];
empty_bee.Cost=[];

% Initialize Population Array
pop=repmat(empty_bee,nPop,1);

% Initialize Best Solution Ever Found
BestSol.Cost=inf;

% Create Initial Population
for i=1:nPop
    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
    [x y]=svd_dwt_hh_ABC(pop(i).Position);
    pop(i).Cost=CostFunction(x,y);
    disp(['number' num2str(x) num2str(y) num2str(pop(i).Cost())]);
    if pop(i).Cost<=BestSol.Cost
        BestSol=pop(i);
    end
end

% Abandonment Counter
C=zeros(nPop,1);

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);
BestCostPosition=zeros(MaxIt,1);

%% ABC Main Loop

for it=1:MaxIt
    
    % Recruited Bees
    for i=1:nPop
        
        % Choose k randomly, not equal to i
        K=[1:i-1 i+1:nPop];
        k=K(randi([1 numel(K)]));
        
        % Define Acceleration Coeff.
        phi=a*unifrnd(-1,+1,VarSize);
        
        % New Bee Position
        newbee.Position=pop(i).Position+phi.*(pop(i).Position-pop(k).Position);
        
        % Evaluation
        [x y]=svd_dwt_hh_ABC(pop(i).Position);
        disp(['Success' num2str(nPop-i)]);
        newbee.Cost=CostFunction(x,y);
        
        % Comparision
        if newbee.Cost<=pop(i).Cost
            pop(i)=newbee;
        else
            C(i)=C(i)+1;
        end
        
    end
    
    % Calculate Fitness Values and Selection Probabilities
    F=zeros(nPop,1);
    MeanCost = mean([pop.Cost]);
    for i=1:nPop
        if(isnan(pop(i).Cost))
            F(i)=0;
        elseif(pop(i).Cost>=0)
            F(i)=1/(pop(i).Cost+1);
        else
            F(i)=1+abs(pop(i).Cost);
        end
        %F(i) = exp(-pop(i).Cost/MeanCost); % Convert Cost to Fitness
    end
    P=F/sum(F);
    
    % Onlooker Bees
    for m=1:nOnlooker
        
        % Select Source Site
        i=RouletteWheelSelection(P);
        
        % Choose k randomly, not equal to i
        K=[1:i-1 i+1:nPop];
        k=K(randi([1 numel(K)]));
        
        % Define Acceleration Coeff.
        phi=a*unifrnd(-1,+1,VarSize);
        
        % New Bee Position
        newbee.Position=pop(i).Position+phi.*(pop(i).Position-pop(k).Position);
        
        % Evaluation
        [x,y]=svd_dwt_hh_ABC(newbee.Position);
        newbee.Cost=CostFunction(x,y);
        
        % Comparision
        if newbee.Cost<=pop(i).Cost
            pop(i)=newbee;
        else
            C(i)=C(i)+1;
        end
        
    end
    
    % Scout Bees
    for i=1:nPop
        if C(i)>=L
            pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
            [x,y]=svd_dwt_hh_ABC(newbee.Position);
            pop(i).Cost=CostFunction(x,y);
            C(i)=0;
        end
    end
    
    % Update Best Solution Ever Found
    for i=1:nPop
        if pop(i).Cost<=BestSol.Cost
            BestSol=pop(i);
        end
    end
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    BestCostPosition(it)=BestSol.Position;
    % Display Iteration Information
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) 'Best Cost Position =' num2str(BestCostPosition(it))]);
    
end
    
%% Results

figure;
%plot(BestCost,'LineWidth',2);
plot(BestCost,'-o','LineWidth',2);
xlabel('Iteration');
ylabel('Value of Fitness Function');
grid on;