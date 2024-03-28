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

range = 2:1:25;
% range = ceil([1:1:25]*0.01*size(X,1));

opt.norm = 0;

% opt.type = 'Linear';
opt.type = 'Gaussian';
% opt.type = 'Cauchy';
% opt.type = 'Polynomial';
% opt.type = 'Sigmoid';

n = size(X,1);
c = length(unique(Y));
l = length(range);
ACC = zeros(l,1);
NMI = zeros(l,1);
Pur = zeros(l,1);
ARI = zeros(l,1);
F1S = zeros(l,1);

X = Normalize(X,opt);
K = ConstructKernel(X,opt);
K = kcenter(K);
K = knorm(K);
C = diag(K)+diag(K)'-2*K;
C = diag(sum(C,2))+C;

for i = 1:l
    j = range(i);
    B = mink(C,j+1);
    gamma = mean(j*B(j+1,:)-sum(B(1:j,:)))/2;
    [Theta,info] = SimSSC(C,gamma);
    idx = group(Theta,c);
    [ACC(i), NMI(i), ARI(i), Pur(i),F1S(i)] = ClusteringMeasure(Y,idx);
end

ACC = roundn([ACC',max(ACC)],-4);
NMI = roundn([NMI',max(NMI)],-4);
ARI = roundn([ARI',max(ARI)],-4);
Pur = roundn([Pur',max(Pur)],-4);
F1S = roundn([F1S',max(F1S)],-4);
result = [ACC;NMI;ARI;Pur;F1S];