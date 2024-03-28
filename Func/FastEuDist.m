function D = FastEuDist(X,ind)

if (~exist('ind','var')) || isempty(ind)
    A = X*X';
    u = diag(A);
    v = u;
else
    A = X*X(ind,:)';
    u = sum(X.*X,2);
    v = u(ind);
end
D = max(u+v'-2*A,0);

end
