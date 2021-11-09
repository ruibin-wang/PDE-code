%%  --------swjtu_robin@foxmail.com------------%%
%   -------- Ribin  20171206   ------------%

%%
clear;close all; clc

load ObjFacesIndex.txt    %% extracted from obj file
load ObjPoints.txt        %% extracted from obj file
load halfTrainHead.txt

%% ��ȷλ��
halfTrainHead       =       eval(vpa(halfTrainHead, 5));
ObjPoints           =       eval(vpa(ObjPoints,5));

selectHalfTrainHead =       zeros(size(ObjPoints,1), size(ObjPoints,2)); %% ��ԭʼ��������ȡ������obj���ɵ�����

%%
for indexI = 1:size(ObjPoints, 1)
    memberIndex       =      ismember(halfTrainHead, ObjPoints(indexI, :));
    
    firstColumIndex   =      find(memberIndex(:,1) == 1); %% ���һ����ƥ�������
    secondColumIndex  =      find(memberIndex(:,2) == 1);  %% ��ڶ�����ƥ�������
    thirdColumIndex   =      find(memberIndex(:,3) == 1); %% ���������ƥ�������
    
    combineIndex      =      [firstColumIndex; secondColumIndex; thirdColumIndex]; %% ��������������һ������
    
    %%%  ѭ���жϣ������ͬ���������ֶ������Σ���ƥ�䵽����
    for indexJ = 1:length(combineIndex)
        if length(find(combineIndex == combineIndex(indexJ))) > 2  %%% ���ھ�ȷ�ȵ�Ե�ɣ�ֻ��ȡ����
            selectHalfTrainHead(indexI, :) = halfTrainHead(combineIndex(indexJ), :);
            break
        end
    end
end

%%  ����û��ƥ�䵽������λ��

firstSeHaTrHeIndex  = find(selectHalfTrainHead(:,1) == 0);  %% û�дﵽƥ������������

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


%%  Ϊ�˷�ֹƥ���ʱ������ص����ݣ����������ڲ���ɸѡ���ҳ������ڲ�����ͬ�ĵ������

testPoints = selectHalfTrainHead;
step = 1;


for indexI = 1:length(selectHalfTrainHead)-1  %% ���м���
    for indexJ = (indexI + 1):length(selectHalfTrainHead)
        if selectHalfTrainHead(indexI, :) == selectHalfTrainHead(indexJ, :)
            transMatrix{step} = [indexI, indexJ];
            step = step +1;
        end
    end
end

%%   �����ص��������½��;�ȷ�ȣ����½���ƥ��

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

%% ��������ɸѡ����ʣ�����ͬ�ĵ���д���

lastIndex = find(selectHalfTrainHead(:,1) == pi);
transSelHaTrHe = eval(vpa(halfTrainHead, 4));

for indexI = 1:length(lastIndex)
    for indexJ = 1:length(halfTrainHead)
        if transObjPoints(lastIndex(indexI), :) == transSelHaTrHe(indexJ, :)
            selectHalfTrainHead(lastIndex(indexI), :) = halfTrainHead(indexJ, :);
        end
    end
end



%% �������;�ȷ�ȣ����¼���

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

