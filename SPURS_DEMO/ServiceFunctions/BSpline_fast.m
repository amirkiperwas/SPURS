function x=BSpline_fast(t,SplineDegree)

[tm, tn] = size(t);
t = t(:);
n = SplineDegree;
rel_t_idx = find(abs(t)<SplineDegree);

if isempty(rel_t_idx)
    x = zeros(tm,tn);
else
    sdegree = (0:(n+1));
    NCKv = zeros(n+2,1);
    for ii=0:n+1
        NCKv(ii+1) = nchoosek(n+1,ii);
    end
    X_K_n_1_2 = bsxfun(@minus, t(rel_t_idx).', sdegree.')+(n+1)/2;
    X_K_n_1_2 = (X_K_n_1_2 > 0).*X_K_n_1_2;
    X_K_n_1_2 = X_K_n_1_2.^n;
    B = bsxfun(@times ,NCKv.*(-1).^(sdegree.'), X_K_n_1_2);
    xt = zeros(size(t));
    xt(rel_t_idx)=(1/factorial(n)).*sum(B,1);
    x = reshape(xt,tm,tn);
end
end

