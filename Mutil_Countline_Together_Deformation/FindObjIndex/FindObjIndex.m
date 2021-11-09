%%  --------swjtu_robin@foxmail.com------------%%
%   -------- Ribin  20171206   ------------%

%%
clear;close all; clc

load ObjFacesIndex.txt    %% extracted from obj file
load ObjPoints.txt        %% extracted from obj file
load halfTrainHead.txt

%% 精确位数
halfTrainHead       =       eval(vpa(halfTrainHead, 5));
ObjPoints           =       eval(vpa(ObjPoints,5));

selectHalfTrainHead =       zeros(size(ObjPoints,1), size(ObjPoints,2)); %% 从原始数据中提取能用于obj生成的数据

%%
for indexI = 1:size(ObjPoints, 1)
    memberIndex       =      ismember(halfTrainHead, ObjPoints(indexI, :));
    
    firstColumIndex   =      find(memberIndex(:,1) == 1); %% 与第一列相匹配的索引
    secondColumIndex  =      find(memberIndex(:,2) == 1);  %% 与第二列相匹配的索引
    thirdColumIndex   =      find(memberIndex(:,3) == 1); %% 与第三列相匹配的索引
    
    combineIndex      =      [firstColumIndex; secondColumIndex; thirdColumIndex]; %% 将所有索引放入一个矩阵
    
    %%%  循环判断，如果相同的索引出现多于两次，则匹配到索引
    for indexJ = 1:length(combineIndex)
        if length(find(combineIndex == combineIndex(indexJ))) > 2  %%% 由于精确度的缘由，只能取舍了
            selectHalfTrainHead(indexI, :) = halfTrainHead(combineIndex(indexJ), :);
            break
        end
    end
end

%%  处理没有匹配到的索引位置

firstSeHaTrHeIndex  = find(selectHalfTrainHead(:,1) == 0);  %% 没有达到匹配条件的索引

for indexI = 1:length(firstSeHaTrHeIndex)
    
    transIndex = find(halfTrainHead(:, 1) == ObjPoints(firstSeHaTrHeIndex(indexI), 1));
    
    if isempty(transIndex)
        transIndex = find(halfTrainHead(:, 2) == ObjPoints(firstSeHaTrHeIndex(indexI), 2));
        
        if isempty(transIndex)
            transIndex = find(halfTrainHead(:, 3) == ObjPoints(firstSeHaTrHeIndex(indexI), 3));
            selectHalfTrainHead(firstSeHaTrHeIndex(indexI), :) = halfTrainHead(transIndex(1), :);
        end
        selectHalfTrainHead(firstSeHaTrHeIndex(indexI), :) = halfTrainHead(transIndex(1), :);
    else
        selectHalfTrainHead(firstSeHaTrHeIndex(indexI), :) = halfTrainHead(transIndex(1), :);
    end
end


%%  为了防止匹配的时候出现重的数据，进行数据内部的筛选，找出数据内部中相同的点的索引

testPoints = selectHalfTrainHead;
step = 1;


for indexI = 1:length(selectHalfTrainHead)-1  %% 进行检索
    for indexJ = (indexI + 1):length(selectHalfTrainHead)
        if selectHalfTrainHead(indexI, :) == selectHalfTrainHead(indexJ, :)
            transMatrix{step} = [indexI, indexJ];
            step = step +1;
        end
    end
end

%%   对于重叠部分重新降低精确度，重新进行匹配

transSelHaTrHe = eval(vpa(selectHalfTrainHead, 4));
transObjPoints = eval(vpa(ObjPoints, 4));


for indexI = 1:length(transMatrix)
    for indexJ = 1:2
        if transObjPoints(transMatrix{indexI}(indexJ), :) == transSelHaTrHe(transMatrix{indexI}(indexJ),:)
            continue
        else
            selectHalfTrainHead(transMatrix{indexI}(indexJ), :) = pi;
        end
    end
end

%% 继续进行筛选，对剩余的相同的点进行处理

lastIndex = find(selectHalfTrainHead(:,1) == pi);
transSelHaTrHe = eval(vpa(halfTrainHead, 4));

for indexI = 1:length(lastIndex)
    for indexJ = 1:length(halfTrainHead)
        if transObjPoints(lastIndex(indexI), :) == transSelHaTrHe(indexJ, :)
            selectHalfTrainHead(lastIndex(indexI), :) = halfTrainHead(indexJ, :);
        end
    end
end



%% 继续降低精确度，重新计算

selectPointIndex = zeros(length(selectHalfTrainHead),1);

for indexI = 1:length(selectHalfTrainHead)
    for indexJ = 1:length(halfTrainHead)
        if selectHalfTrainHead(indexI,:) == halfTrainHead(indexJ, :)
            selectPointIndex(indexI) = indexJ;
        end
    end
end


save selectPointIndex.mat selectPointIndex
save ObjFacesIndex.mat ObjFacesIndex

hold on; trisurf(ObjFacesIndex, selectHalfTrainHead(:,1), selectHalfTrainHead(:,2), selectHalfTrainHead(:,3)); axis equal

