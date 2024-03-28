function X = Normalize(X,opt)

if opt.norm == 1
    X = (X-mean(X,2)) ./ max(std(X,0,2),eps);
elseif opt.norm == 2
    X = X ./ max(sqrt(sum(X.^2, 2)),eps);
end

end