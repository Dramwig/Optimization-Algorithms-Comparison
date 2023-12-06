# Optimization Algorithms Comparison

This project is about comparing and analyzing the performance of different heuristic optimization algorithms including GAT, GA, CGWO, PSO and AOA. The efficiency and effectiveness of each algorithm is evaluated mainly through the number of iterations and convergence curves. The code in the project is written in MATLAB and contains implementations of the various algorithms as well as visualizations of the results. This project is very helpful in understanding and comparing different meta-heuristic optimization algorithms.

这个项目是关于比较和分析不同启发式优化算法（包括 GAT、GA、CGWO、PSO 和 AOA）的性能。主要通过迭代次数和收敛曲线来评估每种算法的效率和效果。项目中的代码使用 MATLAB 编写，包含了各种算法的实现以及结果的可视化。这个项目对于理解和比较不同的元启发式优化算法非常有帮助。

## Introduction

In this project, we evaluate the performance of various optimization algorithms by examining their convergence curves. The convergence curve represents the change in the objective function value over iterations, providing insights into the optimization process and the effectiveness of different algorithms.

在本项目中，我们通过分析各个优化算法的收敛曲线来评估其性能。收敛曲线表示目标函数值随迭代次数的变化，从而提供了关于优化过程和不同算法效果的洞察。

The algorithms compared in this project are:

本项目中比较的算法有：

- Improved Genetic Algorithm (GAT)
  
  基于贪婪和模拟退火思想的改进遗传算法
  
- Genetic Algorithm (GA)
  
  遗传算法
  
- Improved Grey Wolf Optimizer (CGWO)
  
- 改进收敛因子和比例权重的灰狼优化算法
  
- Particle Swarm Optimization (PSO)
  
  粒子群优化算法
  
- Archimedes optimization algorithm (AOA)
  
  阿基米德优化算法

## Optimization

The objective function has been encapsulated as an obj.m function, which is indicated here to solve the following optimization problem:

目标函数被封装为一个 obj.m 函数，在此用于解决以下优化问题：

The objective of the optimization function is to minimize the procurement cost to ensure that the cost of purchasing the ABLVR vascular robot and operators is minimized while meeting the treatment needs of the hospital, i.e., to find the optimal procurement strategy for the vascular robot and operators in order to minimize the cost while meeting the treatment needs.

优化函数的目标是最小化采购成本，以确保在满足医院治疗需求的前提下，购买ABLVR血管机器人和操作人员的成本最低化，即找到最佳的血管机器人和操作人员的采购策略，以实现成本最小化的同时满足治疗需求。

This file can be modified and replaced for other issues.

可以修改替换这个文件，实现对其他问题的运筹。

## Code

The main code for this project is written in MATLAB and can be found in the file "main.m". Below is a brief overview of the code structure:

本项目的主要代码使用MATLAB编写，可以在 "main.m" 文件中找到。以下是代码结构的简要说明：

1. Data Initialization: The code initializes the necessary variables and parameters, such as the number of weeks, dimensionality, number of search agents, and maximum number of iterations.

   数据初始化：代码初始化必要的变量和参数，如周数、维度、搜索代理数量和最大迭代次数。

2. Algorithm Execution and Time Measurement: The code executes each algorithm (GA, CGWO, PSO, and AOA) and measures the execution time for each algorithm.

   算法执行和时间测量：代码执行每个算法（GA、CGWO、PSO和AOA）并测量每个算法的执行时间。

3. Convergence Curve Calculation: The code records the convergence curve for each algorithm, which represents the objective function value at each iteration.

   收敛曲线计算：代码记录每个算法的收敛曲线，表示每次迭代的目标函数值。
   
4. Results Visualization: The code plots the convergence curves for all algorithms on a single graph, using different line styles and colors for each algorithm. The graph helps in visualizing and comparing the convergence characteristics of different optimization algorithms.

   结果可视化：代码将所有算法的收敛曲线绘制在一个图中，使用不同的线型和颜色来区分每个算法。该图有助于可视化和比较不同优化算法的收敛特性。

## Usage

To run the code and generate the convergence curves, follow these steps:
按照以下步骤运行代码并生成收敛曲线：

1. Make sure you have MATLAB installed on your system.
  
   确保系统上安装了MATLAB。

2. Clone the GitHub repository: https://github.com/Dramwig/Optimization-Algorithms-Comparison.git
  
   克隆GitHub仓库：[https://github.com/Dramwig/Optimization-Algorithms-Comparison.git]

3. Open MATLAB and navigate to the project directory.
  
   打开MATLAB，导航到项目目录。

4. Run the "main.m" script.

   运行 "main.m" 脚本。

5. The convergence curves will be generated and displayed in a MATLAB figure.
  
   收敛曲线将在MATLAB图形界面中生成和显示。

## Results

The results of this project provide insights into the convergence characteristics of different optimization algorithms. By analyzing the convergence curves, you can observe the convergence speed and stability of each algorithm. The comparison helps in selecting the most suitable algorithm for specific optimization problems.

本项目的结果提供了对不同优化算法收敛特性的洞察。通过分析收敛曲线，您可以观察每个算法的收敛速度和稳定性。这种比较有助于选择最适合特定优化问题的算法。

## Conclusion

The comparison and analysis of convergence curves for different optimization algorithms allow researchers and practitioners to gain a deeper understanding of algorithm performance. This project provides a starting point for further research and exploration of optimization algorithms.

对不同优化算法的收敛曲线进行比较和分析，可以让研究人员和实践者更深入地了解算法性能。本项目为进一步研究和探索优化算法提供了一个起点。

## References

Wang, Z., Huang, Y., Fan, C., Lai, X., Song, Q., & Lu, P. (2023). Improved Genetic Algorithm Based on Greedy and Simulated Annealing Ideas for Vascular Robot Ordering Strategy. Journal of Medical Robotics, 10(3), 123-145.

Please note that this project is for educational and research purposes only.
