function [GlobalRegret, Success, NbrPlayArm]= DP_UCB_INT(BernoulliMeans, EpsLaplace, T, NbrIteration, v)
    GlobalRegret = [];
    K = length(BernoulliMeans);
    f = ceil(1./EpsLaplace);
    for iter = 1:NbrIteration;
        display(iter)
        Success = zeros(1,K);
        %Success = 0.5*ones(1,K);
        Index = zeros(1,K);
        RegretUCB = [];
        NbrPlayArm = zeros(1,K);
        %NbrPlayArm = ones(1,K);
        for t = 1:T
            %{
            if t <= K*f;
                Arm = mod(t-1,K)+1;
                Success(Arm) = Success(Arm)+ (rand()< BernoulliMeans(Arm));
                NbrPlayArm(Arm) = NbrPlayArm(Arm)+ 1;
                RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(Arm)];
            else
                [Index] = IndexDPUCBINT(NbrPlayArm,f,v, Success, t, Index);
                [~, BestArm] = max(Index);
                Success(BestArm) = Success(BestArm) + (rand() < BernoulliMeans(BestArm));
                NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
                RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(BestArm)];
             end
            %}
            [Index,arm] = IndexDPUCBINT(NbrPlayArm,f,v, Success, t, Index);
            if sum(Index) == 0
                BestArm = arm;
            else
                [~, BestArm] = max(Index);
            end
            Success(BestArm) = Success(BestArm) + (rand() < BernoulliMeans(BestArm));
            NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
            RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(BestArm)];

        end
        GlobalRegret = [GlobalRegret;cumsum(RegretUCB)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('DP-UCB-INT')
end