function [Theta,info] = SimSSC(C,gamma)

n = size(C,1);
l  = -inf(n,1);    % no lower bound
u  = inf(n,1);      % no upper bound

opts = struct('factr', 1e3, 'pgtol', 1e-10, 'm', 10);
opts.printEvery = inf;
opts.maxIts = 1000;

fun = @(mu)fminunc_wrapper(mu,C,gamma);

[mu, ~, info] = lbfgsb(fun, l, u, opts);

Theta = double(0.5*max(mu + mu' - C + gamma, 0)/gamma);

end

