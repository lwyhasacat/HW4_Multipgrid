clc, clear, close all;

% grid size and parameters
n = 127; % fine
m = (n - 1) / 2; % coarse
t = 10; % # of Gauss-Seidel sweeps
p = 5; % # of pre-smoothing GS sweeps, two-grid

% grid functions
f = ones(n+2, n+2);
U = zeros(n+2, n+2);

errors = zeros(1, t);
residuals = zeros(1, t);

for i = 1:t
    U = gaussSeidel(U, f, n);
    r = computeResidual(U, f, n);
    R = restrict(U, m);
    U_tilda = prolongate(R, n, m);

    errors(i) = norm(U_tilda - U, 'fro') / norm(U, 'fro');
    residuals(i) = norm(r, 'fro');
end

% plotting for U^h = 0 and f = 1; Q1-4
% credit: received help for plotting choice
figure;
yyaxis left;
plot(errors, 'b-');
ylabel('Relative Error');

yyaxis right;
plot(residuals, 'r--');
ylabel('Norm of Residual');
xlabel('Number of Gauss-Seidel Sweeps');
title('Error and Residual Norms over Gauss-Seidel Sweeps');

% two-grid
Uh = zeros(n+2, n+2);
for i = 1:p
    Uh = gaussSeidel(Uh, f, n);
end
rh = computeResidual(Uh, f, n);
r2h = restrict(rh, m);
L2h = delsq(numgrid('S', m+2)); 
r2h_vec = reshape(r2h(2:end-1, 2:end-1), [], 1);
W2h = L2h \ (-r2h_vec);
W2h = reshape(W2h, [m, m]);
W2h = padarray(W2h, [1 1], 'both');

% interpolating correction
Wh = prolongate(W2h, n, m);
U_tilda_h = Uh + Wh; % update


% testing restriction and prolongation with a linear function
linearF = meshgrid(1:n+2, 1:n+2) + meshgrid(1:n+2, 1:n+2)'; % fine grid
coarseLinearF = restrict(linearF, m); % restriction
fineLinearF = prolongate(coarseLinearF, n, m); % prolongation

% Q1-3 plot
% Credit to Xiaopeng Zhang for reminding me to plot this
figure;
subplot(1,3,1);
imagesc(linearF);
title('Original Linear Function');
colorbar;

subplot(1,3,2);
imagesc(fineLinearF);
title('After Restriction and Prolongation');
colorbar;

subplot(1,3,3);
imagesc(linearF - fineLinearF);
title('Difference');
colorbar;