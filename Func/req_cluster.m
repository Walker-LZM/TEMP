function idx_req = req_cluster(Theta, idx, c_req)

c_init = max(idx);
idx_req = idx;

for c = c_init - 1:-1:c_req
    Theta = coarsen_graph(Theta, idx);
    [u, v] = find_top_affinity(Theta);
    idx = [1:v - 1, u, v:c];
    idx_req = map_labels(idx_req, idx);
end

end

function [u, v] = find_top_affinity(Theta)

n = size(Theta, 1);
Theta(1:n + 1:end) = 0;
[~, ind] = max(Theta, [], 'all');
[u, v] = ind2sub([n, n], ind);
if u > v
    [u, v] = deal(v, u);
end

end
