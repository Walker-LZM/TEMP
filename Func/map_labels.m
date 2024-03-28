function idx = map_labels(idx_prev, idx_cur)
  
[~, ~, ic] = unique(idx_prev);
idx = idx_cur(ic);

end