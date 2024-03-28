function Theta = coarsen_graph(Theta,idx)
  
if size(idx, 1) ~= 1
    idx = idx';
end
Y = ind2vec(idx);
Y = Y ./ sum(Y, 2);
Theta = Y * Theta * Y';
 
end