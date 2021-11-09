function f = initialize_variables_givenPara(N, M, V, min_range, max_range)

%% function f = initialize_variables_givenPara(N, M, V, min_tange, max_range) 

% 断电之后的操作

% dataTransfer 断电前保存的数据，从中选了后面30个

load dataTransfer.mat

f = dataTransfer;


