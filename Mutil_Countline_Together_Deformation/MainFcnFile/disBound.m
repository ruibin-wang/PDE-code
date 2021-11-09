function [unitDisBound, aveBoundLength] = disBound(boundMatrix, aveValue)

eachDisBound = zeros(size(boundMatrix,1)-1,1);  %% ��ʾ�߽��������ٽ���֮��ľ���
unitDisBound = zeros(size(boundMatrix,1)-1,1);  %% ��ʾ�߽���ÿ���㵽��һ����ĵ��Ӿ���

for i = 1:size(boundMatrix,1)-1
    eachDisBound(i) = Distance(boundMatrix,i,i+1);
    unitDisBound(i) = sum(eachDisBound);
end

boundLength = unitDisBound(end,1);     %% ��ʾ�߽�ĳ���
aveBoundLength = boundLength/aveValue;  %%  ��ʾ���Ƕ�ÿ���߽绮�ֵľ��ֳ���