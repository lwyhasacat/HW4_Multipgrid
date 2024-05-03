clc, clear, close all;

% grid_sizes = [100];
grid_sizes = [100, 250, 500];
p_values = [1, 2];
q_values = [1, 2, 3];
iterations = 10;
results = [];

% plotting
figure;
hold on;

for n = grid_sizes
    m = floor((n - 1) / 2); 
    f = ones(n+2, n+2);
    initialU = zeros(n+2, n+2);

    for p = p_values
        for q = q_values
            U = initialU;
            residuals = zeros(1, iterations);
            
            for iter = 1:iterations
                U = multigrid(U, f, n, log2(n+1) - 1, p, q);
                residual = computeResidual(U, f, n);
                residuals(iter) = norm(residual, 'fro'); 
            end
            
            reductionFactor = residuals(1:end-1) ./ residuals(2:end);
            avgReduction = mean(reductionFactor);
            
            X = [ones(iterations, 1), (1:iterations)']; 
            beta = X \ residuals'; 
            slope = beta(2);
            
            results = [results; n, p, q, residuals(end), avgReduction, slope];
            plot(1:iterations, residuals, '-o', 'DisplayName', sprintf('n=%d, p=%d, q=%d, Slope=%.4f', n, p, q, slope));
        end
    end
end

title('Multigrid Residual Decrease');
xlabel('Iteration');
ylabel('Residual Norm');
legend('show');
hold off;