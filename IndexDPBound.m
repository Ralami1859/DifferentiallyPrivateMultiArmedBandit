%% See https://arxiv.org/pdf/1511.08681.pdf (Algorithm 1 DP-UCB_Bound)

function [Index, Success] = IndexDPBound(NbrPlayArm, EpsLaplace, Success, t)
K = length(NbrPlayArm);
Pow = IsInteger(log2(NbrPlayArm));
Success = Success + laprnd(1,K,0,1/EpsLaplace).*Pow;
nu = 2*sqrt(2)/EpsLaplace*log(4*t^4) + 2*sqrt(2)/EpsLaplace*log(4*t^4).*log(NbrPlayArm).*(1-Pow);
Index = Success./NbrPlayArm +  sqrt(2*log(t)./NbrPlayArm) + nu./NbrPlayArm;
