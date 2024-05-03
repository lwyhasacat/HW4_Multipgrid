function U = multigrid(U, f, n, levels, p, q)
    if n <= 3
        % If on the smallest grid, solve directly with Gauss-Seidel
        for i = 1:50
            U = gaussSeidel(U, f, n);
        end
    else
        n = floor(n);
        m = floor((n - 1) / 2);

        % pre-smoothing
        for i = 1:p
            U = gaussSeidel(U, f, n);
        end

        r = computeResidual(U, f, n);
        r2h = restrict(r, m);
        E2h = zeros(m+2, m+2);
        for i = 1:q
            E2h = multigrid(E2h, -r2h, m, levels - 1, p, q);
        end
        Eh = prolongate(E2h, n, m);
        U = U + Eh;

        % post-smoothing
        for i = 1:p
            U = gaussSeidel(U, f, n);
        end
    end
    return
end
