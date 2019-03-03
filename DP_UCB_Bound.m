function [GlobalRegret, Success, NbrPlayArm]= DP_UCB_Bound(BernoulliMeans, EpsLaplace, Horizon, NbrIteration)
    GlobalRegret = [];
    K = length(BernoulliMeans);
    for iter = 1:NbrIteration;
        display(iter)
        Success = [];
        RegretUCB = [];
        NbrPlayArm = [];
        for t = 1:K
            Success = [Success (rand()< BernoulliMeans(t))];
            NbrPlayArm = [NbrPlayArm 1];
            RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(t)];
        end

        for t = K+1:Horizon
            [Index, Success] = IndexDPBound(NbrPlayArm, EpsLaplace, Success, t);
            [~, BestArm] = max(Index);
            Success(BestArm) = Success(BestArm) + (rand() < BernoulliMeans(BestArm));
            NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
            RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(BestArm)];
        end
        GlobalRegret = [GlobalRegret;cumsum(RegretUCB)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('DP-UCB-Bound')
end