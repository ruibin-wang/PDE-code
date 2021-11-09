function newParaSet = lhsMethod

load paraRanges.mat %% ������״���Ʋ����ı仯����

% min_range =        paraRanges(:,1);  %% range for the variables in the decision variable space
% max_range =        paraRanges(:,2);

dividedNum        =    50;  %% �����仮�ֵĸ���
dividedInterval   =    zeros(length(paraRanges), dividedNum);  %% ��Ż����������ֵ����ֵ
intervalRandVal   =    zeros(length(paraRanges), dividedNum - 1);  %% ��ÿ�λ���������ȡһ���ֵ

newParaSet        =    zeros(1, length(paraRanges));


for indexI = 1:length(paraRanges)
 
   dividedInterval(indexI, :) = linspace(paraRanges(indexI, 1), paraRanges(indexI, 2), dividedNum);
   
   for indexJ = 1:(dividedNum-1)
       
       intervalRandVal(indexI, indexJ) = dividedInterval(indexI, indexJ) + ...
                + (dividedInterval(indexI, indexJ+1) - dividedInterval(indexI, indexJ)) * rand(1);
   end
           
   randNum    =   randi([1, dividedNum-1],1,1);
   
   newParaSet(1, indexI)    =   intervalRandVal(indexI, randNum);
   
end



% % for indexI = 1:length(paraRanges)
% %     
% %     hold on; scatter(1:dividedNum-1, intervalRandVal(indexI, :))
% % 
% % end
% 
% hold on; scatter(1:length(newParaSet), newParaSet(:, 1), '*')
% hold on; plot(1:length(newParaSet), newParaSet(:, 1))


