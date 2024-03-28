function [ACC, NMI, ARI, Purity, F1] = ClusteringMeasure(Y, predY)

res = bestMap(Y, predY);
ACC = length(find(Y == res))/length(Y);
NMI = MutualInfo(Y,res);
ARI = rand_index(Y, res, 'adjusted');
Purity = purity(Y,res);
[F1,~,~] = f1score(Y,res);