clc;
clear;

%% 数据初始化
weeks = 104;

%% 算法
dim = weeks * 4;
SearchAgents_no = 50;
Max_iter = 500000;

% 记录GAT算法执行时间
tic;
[~, ~, Convergence_curve1] = GAT(SearchAgents_no, Max_iter, weeks * 4, @obj); 
gat_time = toc;
fprintf('GAT OK! Execution time: %.2f seconds\n', gat_time);

% 记录GA算法执行时间
tic;
[~, ~, Convergence_curve2] = GA(SearchAgents_no, Max_iter, weeks * 4, @obj); 
ga_time = toc;
fprintf('GA OK! Execution time: %.2f seconds\n', ga_time);

% 记录CGWO算法执行时间
tic;
[~, ~, Convergence_curve3] = CGWO(SearchAgents_no, Max_iter, zeros(1, dim), ones(1, dim) * 500, dim, @obj);
cgwo_time = toc;
fprintf('CGWO OK! Execution time: %.2f seconds\n', cgwo_time);

% 记录PSO算法执行时间
tic;
[~, ~, Convergence_curve4] = PSO(SearchAgents_no, Max_iter, zeros(1, dim), ones(1, dim) * 500, dim, @obj);
pso_time = toc;
fprintf('PSO OK! Execution time: %.2f seconds\n', pso_time);

% 记录AOA算法的执行时间
tic
[~, ~, Convergence_curve5] = AOA(SearchAgents_no, Max_iter, @obj, dim, 0, 500, 1, 2);
aoa_time = toc;
fprintf('AOA OK! Execution time: %.2f seconds\n', aoa_time);

save data Convergence_curve1 Convergence_curve2 Convergence_curve3 Convergence_curve4 Convergence_curve5

%% 绘制图形
figure;
hold on;
plot(Convergence_curve1, 'b-', 'LineWidth', 1.5); % GAT算法，蓝色实线
plot(Convergence_curve2, 'g--', 'LineWidth', 1.5); % GA算法，绿色虚线
plot(Convergence_curve3, 'r-.', 'LineWidth', 1.5); % CGWO算法，红色点线
plot(Convergence_curve4, 'm:', 'LineWidth', 1.5); % PSO算法，品红色点虚线
plot(Convergence_curve5, 'k-', 'LineWidth', 1.5); % AOA算法，黑色实线

% 添加标注
legend('GAT', 'GA', 'CGWO', 'PSO', 'AOA');
xlabel('迭代次数');
ylabel('收敛曲线');
title('优化算法收敛曲线');
grid on;
hold off;