function R = restrict(V, m)
    R = zeros(m+2, m+2);
    for j = 2:m+1
        for k = 2:m+1
            R(j,k) = 0.25 * (V(2*j-1, 2*k-1) + V(2*j-1, 2*k+1) + V(2*j+1, 2*k-1) + V(2*j+1, 2*k+1));
        end
    end
end
