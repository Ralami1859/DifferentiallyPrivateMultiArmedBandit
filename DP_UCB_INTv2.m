function [GlobalRegret, Success, NbrPlayArm]= DP_UCB_INTv2(BernoulliMeans, EpsLaplace, T, NbrIteration, v)
    GlobalRegret = [];
    K = length(BernoulliMeans);
    f = ceil(1./EpsLaplace);
    for iter = 1:NbrIteration;
        display(iter)
        Success = zeros(1,K);
        Index = zeros(1,K);
        RegretUCB = [];
        NbrPlayArm = zeros(1,K);
        for t = 1:T
            [Index, arm] = IndexDPUCBINT(NbrPlayArm,f,v, Success, t, Index);
            Success(arm) = Success(arm) + (rand() < BernoulliMeans(arm));
            NbrPlayArm(arm) = NbrPlayArm(arm) + 1;
            RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(arm)];
        end
        GlobalRegret = [GlobalRegret;cumsum(RegretUCB)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('DP-UCB-INT')
end