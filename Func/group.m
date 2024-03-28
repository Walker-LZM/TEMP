function idx = group(Theta,c)

[hier_y, hier_n_clu] = hier_group(Theta);
idx = find(hier_n_clu == c, 1);
if ~isempty(idx)
    idx = hier_y(idx, :)';
elseif any(hier_n_clu > c)
    refine_starter = find(hier_n_clu > c, 1, 'last');
    idx = req_cluster(Theta, hier_y(refine_starter, :), c)';
else
    error('The number of found clusters is less than %d', c);
end

end
