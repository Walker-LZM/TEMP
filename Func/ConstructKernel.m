function K = ConstructKernel(X,opt)

switch opt.type
    case 'Gaussian'
        D = FastEuDist(X,[]);
        t = mean(mean(sqrt(D)));
        K = exp(-D/(2*t^2));
    case 'Cauchy'
        D = FastEuDist(X,[]);
        t = mean(mean(sqrt(D)));
        K = (D/t+1).^(-1);
    case 'Linear'
        K = X*X';
    case 'Sigmoid'
        K = tanh(X*X');
    case 'Polynomial'
        K = (X*X').^2;
end
% K = (K+K')/2;

end