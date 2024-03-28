function K = knorm(K)

K = K ./ sqrt(diag(K) * diag(K)');

end

