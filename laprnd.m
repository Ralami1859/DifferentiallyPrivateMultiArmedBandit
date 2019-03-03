function y  = laprnd(m, n, mu, b)
%LAPRND generate i.i.d. laplacian random number drawn from laplacian distribution
%   with mean mu and standard deviation sigma. 
%   mu      : mean
%   b       : scale parameter
%   [m, n]  : the dimension of y.
%   Default mu = 0, b = 1. 
%   For more information, refer to
%   http://en.wikipedia.org./wiki/Laplace_distribution

%   Author  : Elvis Chen (bee33@sjtu.edu.cn)
%   Date    : 01/19/07

%Check inputs
if nargin < 2
    error('At least two inputs are required');
end

if nargin == 2
    mu = 0; b = 1;
end

if nargin == 3
    b = 1;
end

% Generate Laplacian noise
u = rand(m, n)-0.5;
y = mu - b * sign(u).* log(1- 2* abs(u));