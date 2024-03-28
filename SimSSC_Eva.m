clear;
addpath(genpath('./Data'));
addpath(genpath('./Func'));
addpath(genpath('./L-BFGS-B'));

load COIL20
% load COIL100
% load ORL
% load USPS_order
% load hhar_order.mat
% load reut_order.mat
% load AMAC_order.mat
% load STL10_order.mat
% load ImageNet-10
% load cifar10_order

X = double(X);
% X = single(X);

k = 4;
% ratio = 0.1;
% k = ceil(size(X,1)*ratio);
opt.norm = 0;
% opt.type = 'Linear';
opt.type = 'Gaussian';
% opt.type = 'Cauchy';
% opt.type = 'Polynomial';
% opt.type = 'Sigmoid';

c = length(unique(Y));

X = Normalize(X,opt);
K = ConstructKernel(X,opt);
K = kcenter(K);
K = knorm(K);
C = diag(K)+diag(K)'-2*K;
C = diag(sum(C,2))+C;

B = mink(C,k+1);
gamma = mean(k*B(k+1,:)-sum(B(1:k,:)))/2;
  
[Theta,info] = SimSSC(C,gamma);
idx = group(Theta, c);
[ACC, NMI, ARI, Pur,F1S] = ClusteringMeasure(Y, idx);
