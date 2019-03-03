function [GlobalRegret, Success, NbrPlayArm]= DP_UCB(BernoulliMeans, EpsLaplace, Horizon, NbrIteration)
    GlobalRegret = [];
    K = length(BernoulliMeans);
    for iter = 1:NbrIteration;
        display(iter)
        Success = [];
        RegretUCB = [];
        NbrPlayArm = [];
        NbrLeaf = [];
        for t = 1:K
            Success = [Success (rand()< BernoulliMeans(t))];
            NbrPlayArm = [NbrPlayArm 1];
            NbrLeaf = [NbrLeaf 1];
            RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(t)];
        end

        for t = K+1:Horizon
            [Index, Success] = IndexDPUCB(NbrPlayArm, NbrLeaf, EpsLaplace, Success, t);
            [~, BestArm] = max(Index);
            Success(BestArm) = Success(BestArm) + (rand() < BernoulliMeans(BestArm));
            NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
            Success = Success + 0;
            NbrLeaf = NbrLeaf + 1;
            RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(BestArm)];
        end
        GlobalRegret = [GlobalRegret;cumsum(RegretUCB)];
    end
    figure
    semilogy(mean(GlobalRegret,1),'k.')
    title('DP-UCB')
end