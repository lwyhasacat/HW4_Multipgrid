function U = gaussSeidel(U, f, n)
    for j = 2:n+1
        for k = 2:n+1
            U(j,k) = 0.25 * (U(j, k+1) + U(j, k-1) + U(j+1, k) + U(j-1, k) - f(j,k));
        end
    end
end
