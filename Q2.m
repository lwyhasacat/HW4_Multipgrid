clc, clear, close all;

grid_sizes = [100, 250, 500, 1000, 2000];
p = 2;
iter = 20;
results = struct();
slopes = zeros(size(grid_sizes));

% plotting settings
figure; 
hold on;
colors = lines(numel(grid_sizes));

for idx = 1:length(grid_sizes)
    n = grid_sizes(idx);
    m = floor((n - 1) / 2);
    f = ones(n+2, n+2);
    U = zeros(n+2, n+2); % initial guess
    
    residuals = zeros(1, iter);
    
    for i = 1:iter
        % pre-smoothing using GS
        for j = 1:p
            U = gaussSeidel(U, f, n);
        end

        rh = computeResidual(U, f, n);
        r2h = restrict(rh, m);
        W2h = zeros(m+2, m+2);
        for k = 1:10
            W2h = gaussSeidel(W2h, -r2h, m);
        end
        Wh = prolongate(W2h, n, m);
        U = U + Wh;
        
        residuals(i) = norm(rh, 'fro');
    end
    results.(sprintf('n%d', n)) = residuals;
    
    % calculate slope
    X = [ones(iter, 1), (1:iter)']; 
    b = X \ residuals';
    slopes(idx) = b(2); 
    
    % Plotting each grid size on the same figure
    plot(residuals, 'DisplayName', sprintf('n = %d, Slope = %.2f', n, slopes(idx)), 'Color', colors(idx,:));
end

title('Residual Norms for Different Grid Sizes');
xlabel('Iteration Number');
ylabel('Residual Norm');
legend show;

% Print the slopes
disp('Slopes of the residual lines for each grid size:');
for idx = 1:length(grid_sizes)
    fprintf('Grid size %d: Slope = %.4f\n', grid_sizes(idx), slopes(idx));
end