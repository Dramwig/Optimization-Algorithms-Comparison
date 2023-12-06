%% 粒子群算法
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pso1_im.m：画出函数图像（仅1维和2维）。
% pso1_in.m:初始化
% pso1_in2.m:迭代寻优并输出结果
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 可支持N维函数
% 可使用动态参数算法
% 多维目标函数的自变量输入格式为行向量
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PSO(50,5000,zeros(1,dim),ones(1,dim)*500,dim,@obj);

function [gbest_fitness,gbest_index,Convergence_curve] = PSO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)

funct = fobj;                          %目标函数
popsize = SearchAgents_no;                           %种群大小
fun_range = [lb',ub'];    %每个维度的求解范围，行代表维度，第一列最小值，第二列最大值
maxgen = Max_iter;                           %最大迭代次数
limit_v = 10;                          %每个维度的最大运动速度
maxormin = 0;                           %求最大值还是最小值。最大值为1，最小值为0
dynamic = 1;                            %是否采用动态参数
W = [0.7,1.4];                          %惯性因子。动态参数时为行向量，第一位是最小值，第二位是最大值
C2 = [0.5,2.5];
C1 = [0.5,2.5];                         %学习因子。动态参数时为行向量，第一位是最小值，第二位是最大值

%PSO1_IN 进行初始化
%
%INPUT：
%   size：种群规模
%   maxgen：最大迭代次数
%   d：维数
%   fun_range：运动范围矩阵，行数为维数，第一列最小值，第二列最大值
%   limit_v:速度范围，为一个数字
%   maxormin：0为求最小值，1为求最大值

%位置和速度初始化
x=initialization(popsize,dim);
for i = 1 : popsize
    for j = 1 : dim
        if i>5
            x(i,j) = x(i,j) + (rand-0.5)*0.05*(ub(j)-lb(j));
        end
        v(i,j) = rand * limit_v;% 速度初始化
    end
end
for i = 1 : popsize
    fitness(i,:) = funct(x(i,:)); % 计算初始适应度
end

pbest = x;              % 个体最优值位置
pbest_fitness = fitness;% 个体最优值
if maxormin == 1
    [gbest_fitness,gbest_index] = max(fitness);
elseif maxormin == 0
    [gbest_fitness,gbest_index] = min(fitness);
else print('maxormin的值非法')
        return
end
gbest = x(gbest_index,:);


%PSO1_IN2 开始迭代计算
%   
%INPUT:
%   size：种群规模
%   maxgen：最大迭代次数
%   d：维数
%   fun_range：运动范围矩阵，行数为维数，第一列最小值，第二列最大值
%   limit_v:速度范围，为一个数字
%   maxormin：0为求最小值，1为求最大值
times = 1;

for i = 1 : maxgen      % i表示迭代次数
    if dynamic == 1
        w = W(2) - (W(2) - W(1)) * i/maxgen; % 动态调整学习因子
        c1 = (C1(1) - C1(2)) * i / maxgen + C1(2);
        c2 = (C2(2) - C2(1)) * i / maxgen + C2(1);
    elseif dynamic == 0
        w = W;
        c1 = C1(1);
        c2 = C2(1);
    end
    for j = 1 : popsize    % j表示粒子索引
        % 更新速度
        v(j,:) = w * v(j,:) + c1 * rand * (pbest(j,:) - x(j,:)) + c2 * rand * (gbest - x(j,:));
    end
    % 限速
    for g=1:dim           % g表示维度
        for k=1:popsize    % k表示粒子索引
            if  v(k,g) > limit_v
                v(k,g) = limit_v;
            end
            if  v(k,g) < (-1 * limit_v)
                v(k,g) = (-1 * limit_v);
            end
        end
    end     
    % 更新位置
    x(j,:) = x(j,:) + v(j,:);
    %限制运动范围
    for g=1:dim           % g表示维度
        for k=1:popsize    % k表示粒子索引
        if  x(k,g) > fun_range(g,2)
            x(k,g) = fun_range(g,2);
        end
        if  x(k,g) < fun_range(g,1)
            x(k,g) = fun_range(g,1);
        end
        end
    end   
    % 更新适应度
    for u = 1 : popsize
        fitness(u,:) = funct(x(u,:)); % 计算初始适应度
    end
    % 更新全局最优
    if maxormin == 0
        if min(fitness) < gbest_fitness
            [gbest_fitness,gbest_index] = min(fitness);
            gbest = x(gbest_index,:);
        end
    elseif maxormin == 1
        if max(fitness) > gbest_fitness
            [gbest_fitness,gbest_index] = max(fitness);
            gbest = x(gbest_index,:);
        end
    end
    
    % 更新局部最优
    for k = 1 : popsize
      if maxormin == 0
        if fitness(k,:) < pbest_fitness(k,:)
            pbest_fitness(k,:) = fitness(k,:);
            pbest(k,:) = x(k,:);
        end
      elseif maxormin == 1 
        if fitness(k,:) > pbest_fitness(k,:)
            pbest_fitness(k,:) = fitness(k,:);
            pbest(k,:) = x(k,:);
        end
      end
    end
    Convergence_curve(times) = gbest_fitness;
    % disp( [num2str(times) '值:' num2str(gbest_fitness)]);
    times = times + 1;
end
% disp( ['目标函数最小值:' num2str(gbest_fitness)]);
% disp( ['最小值对应的（x,y）:' num2str(x(gbest_index,:))]);
% figure
% plot(record,'LineWidth',2);title('收敛过程')
% xlabel('迭代次数');
% ylabel('得到的目标函数值');



% canshu = {'惯性因子',W,'种群规模',popsize,'最大迭代次数',maxgen,'速度限制',limit_v,...
%     '最大值还是最小值',maxormin};
% xlswrite(file,record,'record');
% xlswrite(file,canshu,'参数');
end
