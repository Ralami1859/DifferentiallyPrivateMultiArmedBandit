function [GlobalRegret, Success, NbrPlayArm]= DP_UCB_INTOracle(BernoulliMeans, EpsLaplace, NbrIteration, v)
    
    BernoullisMeanMatrix = [0.9 0.4 0.1; 0.1 0.2 0.85; 0.3 0.8 0.2];
    GlobalRegret = [];
    horizon = 1000*3;
    N = size(BernoullisMeanMatrix,1);
    K = size(BernoullisMeanMatrix,2);
    f = ceil(1./EpsLaplace);
    for iter = 1:NbrIteration;
        display(iter)
        RegretUCB = [];
        for n = 1:size(BernoullisMeanMatrix,1);
            BernoulliMeans = BernoullisMeanMatrix(n,:);
            t = 1;
            Success = zeros(1,K);
            Index = zeros(1,K);
            NbrPlayArm = ones(1,K);
            while(t <= horizon/N)
                [Index] = IndexDPUCBINT(NbrPlayArm,f,v, Success, t, Index);
                [~, BestArm] = max(Index);
                Success(BestArm) = Success(BestArm) + (rand() < BernoulliMeans(BestArm));
                NbrPlayArm(BestArm) = NbrPlayArm(BestArm) + 1;
                RegretUCB = [RegretUCB max(BernoulliMeans)- BernoulliMeans(BestArm)];
                t = t+1;
            end
        end
        GlobalRegret = [GlobalRegret;cumsum(RegretUCB)];
    end
    figure
    plot(mean(GlobalRegret,1),'k.')
    title('DP-UCB-INT')
end