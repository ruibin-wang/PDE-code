% function testNSGA2main
clear;clc
%% 数据重置，每次重新运行的时候需要将该变量还原至初始状态
% 矩阵结构为[HdPress(1,2,3), HdViscous(1,2,3), HdTotal(1,2,3), ...
%              MidPress(1,2,3), MidViscous(1,2,3), MidTotal(1,2,3), ...
%                  TailPress(1,2,3), TailViscous(1,2,3), TailTotal(1,2,3), ...] 
%  以上括号中的(1,2,3)分别表示 在(1,0,0),(0,1,0),(0,0,1)方向上的力或系数
% 
% 整车阻力系数在矩阵中的索引为第34列，尾车的升力在矩阵中的索引为第26列

orgPressViscousNet  =  1:36;  %% 创建初始化数据，并保存，使得数据第一行是1:36的数值
coffPressViscousNet = 1:36;
generationParaSets  = 1:10;   %% 存放十个变量参数，此处进行初始化，然后保存

save orgPressViscousNet.mat orgPressViscousNet
save coffPressViscousNet.mat coffPressViscousNet
save generationParaSets.mat generationParaSets

%% 提前打开并行

global poolStates
delete(gcp('nocreate'))   %% 防止报错，提前关闭并行中打开的worker
c = parcluster;
poolStates  =  parpool(c);

%% 进行遗传算法运算

load paraRanges.mat %% 导入形状控制参数的变化区间

M         =        2;   %% the dimension of the objective space
V         =        10;  %% dimension of decision variable space
min_range =        paraRanges(:,1);  %% range for the variables in the decision variable space
max_range =        paraRanges(:,2);
pop       =        20;   %% Population size, must be an integer, more than 20
gen       =        5;   %% Total number of generations, must be an integer, more than 5
nsga_2(M, V, min_range, max_range, pop, gen)

