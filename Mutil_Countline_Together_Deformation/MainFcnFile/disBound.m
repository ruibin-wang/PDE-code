function [unitDisBound, aveBoundLength] = disBound(boundMatrix, aveValue)

eachDisBound = zeros(size(boundMatrix,1)-1,1);  %% 表示边界上两个临近点之间的距离
unitDisBound = zeros(size(boundMatrix,1)-1,1);  %% 表示边界上每个点到第一个点的叠加距离

for i = 1:size(boundMatrix,1)-1
    eachDisBound(i) = Distance(boundMatrix,i,i+1);
    unitDisBound(i) = sum(eachDisBound);
end

boundLength = unitDisBound(end,1);     %% 表示边界的长度
aveBoundLength = boundLength/aveValue;  %%  表示我们对每条边界划分的均分长度