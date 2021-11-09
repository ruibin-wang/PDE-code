function deformBound = boundMotivation(bound, aixsT, deltT)

Len            =     size(bound,1);   %% 边界点数量
deformBound    =     bound;   %% 先将变形前边界赋值给变形后的边界，因为只有某一轴方向发生了形变，其他的方向保持不变

switch aixsT
    case 'X'
        for index = 1:1:size(bound)
            deformBound(index,1) = bound(index,1) * (1+(deltT*(index-1)*(Len-index)/((index-1)^2+(Len-index)^2)));  %%  X轴方向形变函数
        end
        
    case 'Y'
        for index = 1:1:size(bound)
            deformBound(index,2) = bound(index,2) * (1+(deltT*(index-1)*(Len-index)/((index-1)^2+(Len-index)^2)));  %%  Y轴方向形变函数
        end
        
    case 'Z'
        for index = 1:1:size(bound)
            deformBound(index,3) = bound(index,3) * (1+(deltT*(index-1)*(Len-index)/((index-1)^2+(Len-index)^2)));  %%  Z轴方向形变函数
        end
        
    case 'NaN'
        
        deformBound = bound;
        
end
