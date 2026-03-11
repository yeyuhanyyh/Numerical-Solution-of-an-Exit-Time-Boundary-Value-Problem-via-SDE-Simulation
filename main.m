clear; clc; close all;

f = @(x) x(1)^2 + x(2)^2 + 1;
u = @(x) (x(1)^2 + x(2)^2)/2;

t = [0.1, 0.03, 0.01, 0.003, 0.001];   % Change the last entry to 0.001
N = 10000;                              % Monte Carlo sample size
x0 = [0;0];

err = zeros(size(t));
traj = cell(length(t),1);               % Store one representative trajectory for each time step

for ite = 1:length(t)
    h = t(ite);
    sum_mc = 0;

    for i = 1:N
        xk = x0;
        path = xk;                      % Current sample trajectory
        inte = 0;

        while norm(xk) < 1
            deltaW = sqrt(h) * randn(2,1);
            xk = xk + xk*h + deltaW;    % Euler-Maruyama update
            inte = inte - f(xk);        % Approximate the integral term
            path(:,end+1) = xk;         % Record the trajectory
        end

        inte = inte * h;
        sum_mc = sum_mc + 0.5 + inte;

        % Save only the first sample trajectory for plotting
        if i == 1
            traj{ite} = path;
        end
    end

    nmu = sum_mc / N;
    err(ite) = abs(nmu - u(x0));
end

%% Plot three representative sample trajectories
idx_plot = [1, 3, 5];   % Corresponding to h = 0.1, 0.01, 0.001

for k = 1:length(idx_plot)
    j = idx_plot(k);
    path = traj{j};

    figure;
    plot(path(1,:), path(2,:), 'b-', 'LineWidth', 1.2);
    hold on;

    % Plot the boundary of the unit disk
    th = linspace(0, 2*pi, 400);
    plot(cos(th), sin(th), 'r--', 'LineWidth', 1.2);

    % Plot the starting point and exit point
    plot(path(1,1), path(2,1), 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 6);
    plot(path(1,end), path(2,end), 'mo', 'MarkerFaceColor', 'm', 'MarkerSize', 6);

    axis equal;
    grid on;
    xlabel('x_1');
    ylabel('x_2');
    title(['Sample trajectory, h = ', num2str(t(j))]);

    legend('Trajectory', 'Boundary of unit disk', 'Start point', 'Exit point', ...
        'Location', 'best');
end

%% Plot the error convergence curve
figure;
plot(log(t), log(err), 'o-', 'LineWidth', 1.5, 'MarkerSize', 7);
grid on;
xlabel('$\log(\Delta t)$', 'Interpreter', 'latex');
ylabel('$\log(\mathrm{err})$', 'Interpreter', 'latex');
title('Log-log error plot');

% Fit the slope of the log-log curve
p = polyfit(log(t), log(err), 1);
disp(['Observed slope = ', num2str(p(1))]);