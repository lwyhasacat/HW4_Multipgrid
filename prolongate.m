function U = prolongate(W, n, m)
    U = zeros(n+2, n+2); % Initialize the fine grid U
    for j = 1:n+1
        for k = 1:n+1
            % Nearest coarse grid points
            jc = floor(j/2) + 1;
            kc = floor(k/2) + 1;

            % Linear interpolation for pure directions
            U(j,k) = W(jc,kc);
            if mod(j,2) == 0 && mod(k,2) == 0
                U(j,k) = W(jc,kc);
            elseif mod(j,2) == 0
                U(j,k) = 0.5 * (W(jc, kc) + W(jc, min(kc+1, m+1)));
            elseif mod(k,2) == 0
                U(j,k) = 0.5 * (W(jc, kc) + W(max(jc-1, 2), kc));
            else
                U(j,k) = 0.25 * (W(jc, kc) + W(max(jc-1, 2), kc) + W(jc, min(kc+1, m+1)) + W(max(jc-1, 2), min(kc+1, m+1)));
            end
        end
    end
end
