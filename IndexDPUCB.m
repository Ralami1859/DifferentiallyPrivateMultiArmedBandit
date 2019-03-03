%% See https://arxiv.org/pdf/1511.08681.pdf (Algorithm 1 DP-UCB_Bound)

function [Index, Success] = IndexDPUCB(NbrPlayArm,NbrLeaf, EpsLaplace, Success, t)
K = length(NbrPlayArm);
Pow = IsInteger(log2(NbrLeaf));
Success = Success + laprnd(1,K,0,1/EpsLaplace).*Pow;
Index = Success./NbrPlayArm +  sqrt(2*log(t)./NbrPlayArm);