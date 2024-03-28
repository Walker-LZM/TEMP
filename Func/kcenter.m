function K = kcenter(K)

K = K-mean(K,1)-mean(K,2)+mean(K,'all');

end