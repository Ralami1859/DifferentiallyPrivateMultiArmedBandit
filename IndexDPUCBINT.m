%% See https://arxiv.org/pdf/1511.08681.pdf (Algorithm 3 DP-UCB_INT)

function [Index, arm] = IndexDPUCBINT(NbrPlayArm,f,v, Success, t, Index)
K = length(NbrPlayArm);
if t <= K*f
    arm = mod(t-1,K)+1;
else
    for arm = 1:K;
        if mod(NbrPlayArm(arm),f) == 0
            lap = laprnd(1,1,0,1/NbrPlayArm(arm).^(1-v/2));    
            Index(arm) = Success(arm)./NbrPlayArm(arm) + lap + sqrt(2*log(t)./NbrPlayArm(arm));
        end
    end
    [~, arm] = max(Index);
end