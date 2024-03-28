function [obj,grad] = fminunc_wrapper(mu,C,gamma)

Theta = 0.5*(mu+mu'-C+gamma)/gamma;
Theta(Theta<0) = 0;

grad = double(2*sum(Theta,2)-2);
obj = gamma*sum(Theta.^2,'all')-2*sum(mu);

end