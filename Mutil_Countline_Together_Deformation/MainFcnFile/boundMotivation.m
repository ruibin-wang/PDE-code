function deformBound = boundMotivation(bound, aixsT, deltT)

Len            =     size(bound,1);   %% �߽������
deformBound    =     bound;   %% �Ƚ�����ǰ�߽縳ֵ�����κ�ı߽磬��Ϊֻ��ĳһ�᷽�������α䣬�����ķ��򱣳ֲ���

switch aixsT
    case 'X'
        for index = 1:1:size(bound)
            deformBound(index,1) = bound(index,1) * (1+(deltT*(index-1)*(Len-index)/((index-1)^2+(Len-index)^2)));  %%  X�᷽���α亯��
        end
        
    case 'Y'
        for index = 1:1:size(bound)
            deformBound(index,2) = bound(index,2) * (1+(deltT*(index-1)*(Len-index)/((index-1)^2+(Len-index)^2)));  %%  Y�᷽���α亯��
        end
        
    case 'Z'
        for index = 1:1:size(bound)
            deformBound(index,3) = bound(index,3) * (1+(deltT*(index-1)*(Len-index)/((index-1)^2+(Len-index)^2)));  %%  Z�᷽���α亯��
        end
        
    case 'NaN'
        
        deformBound = bound;
        
end
