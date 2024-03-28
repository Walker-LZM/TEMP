function [hier_idx, hier_n_clu] = hier_group(Theta)

[idx_cur, hier_n_clu] = search_cluster(Theta);
hier_idx = idx_cur;
if hier_n_clu <= 1
    return;
end

while true
    Theta = coarsen_graph(Theta, idx_cur);
    [idx_cur, c_cur] = search_cluster(Theta);
    if c_cur <= 1
        break;
    end
    hier_idx = [hier_idx; map_labels(hier_idx(end, :), idx_cur)];
    hier_n_clu = [hier_n_clu, c_cur];
end

end

function [idx, c] = search_cluster(Theta)

n = size(Theta, 1);
Theta(1:n+1:end) = 0;
[~, nn_idx] = max(Theta,[],2);
[idx, n_clu] = conncomp(graph(1:n,nn_idx));
c = numel(n_clu);

end
