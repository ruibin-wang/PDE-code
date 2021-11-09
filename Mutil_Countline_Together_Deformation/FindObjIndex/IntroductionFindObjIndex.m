%%  --------swjtu_robin@foxmail.com------------%%
%   -------- Ribin  20171206   ------------%

%%
clear;close all; clc

load FaceIndex.txt    %% extracted from obj file
load vertices.txt        %% extracted from obj file
load halfTrain.txt

%%  ��ȷλ��
halfTrain       =       eval(vpa(halfTrain, 5));
vertices        =       eval(vpa(vertices,5));

selectHalfTrainHead =       zeros(size(vertices,1), size(vertices,2));  %% ��ԭʼ��������ȡ������obj���ɵ�����

%%
for indexI = 1:size(vertices, 1)
    memberIndex       =      ismember(halfTrain, vertices(indexI, :));
    
    firstColumIndex   =      find(memberIndex(:,1) == 1);  %% ���һ����ƥ�������
    secondColumIndex  =      find(memberIndex(:,2) == 1);  %% ��ڶ�����ƥ�������
    thirdColumIndex   =      find(memberIndex(:,3) == 1);  %% ���������ƥ�������
    
    combineIndex      =      [firstColumIndex; secondColumIndex; thirdColumIndex];  %% ��������������һ������
    
    %%%  ѭ���жϣ������ͬ���������ֶ������Σ���ƥ�䵽����
    for indexJ = 1:length(combineIndex)
        if length(find(combineIndex == combineIndex(indexJ))) > 2   %%% ���ھ�ȷ�ȵ�Ե�ɣ�ֻ��ȡ����
            selectHalfTrainHead(indexI, :) = halfTrain(combineIndex(indexJ), :);
            break
        end
    end
end

%%  ����û��ƥ�䵽������λ��

firstSeHaTrHeIndex  = find(selectHalfTrainHead(:,1) == 0);   %% û�дﵽƥ������������

for indexI = 1:length(firstSeHaTrHeIndex)
    
    transIndex = find(halfTrain(:, 1) == vertices(firstSeHaTrHeIndex(indexI), 1));
    
    if isempty(transIndex)
        transIndex = find(halfTrain(:, 2) == vertices(firstSeHaTrHeIndex(indexI), 2));
        
        if isempty(transIndex)
            transIndex = find(halfTrain(:, 3) == vertices(firstSeHaTrHeIndex(indexI), 3));
            selectHalfTrainHead(firstSeHaTrHeIndex(indexI), :) = halfTrain(transIndex(1), :);
        end
        selectHalfTrainHead(firstSeHaTrHeIndex(indexI), :) = halfTrain(transIndex(1), :);
    else
        selectHalfTrainHead(firstSeHaTrHeIndex(indexI), :) = halfTrain(transIndex(1), :);
    end
end


%% Ϊ�˷�ֹƥ���ʱ������ص����ݣ����������ڲ���ɸѡ���ҳ������ڲ�����ͬ�ĵ������

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

%%  �����ص��������½��;�ȷ�ȣ����½���ƥ��

transSelHaTrHe = eval(vpa(selectHalfTrainHead, 4));
transObjPoints = eval(vpa(vertices, 4));


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

lastIndex      =    find(selectHalfTrainHead(:,1) == pi);
transSelHaTrHe =    eval(vpa(halfTrain, 4));

for indexI = 1:length(lastIndex)
    for indexJ = 1:length(halfTrain)
        if transObjPoints(lastIndex(indexI), :) == transSelHaTrHe(indexJ, :)
            selectHalfTrainHead(lastIndex(indexI), :) = halfTrain(indexJ, :);
        end
    end
end

%% �������;�ȷ�ȣ����¼���
selectPointIndex = zeros(length(selectHalfTrainHead),1);

% transObjPoints(1098,:)
% transObjPoints(1567,:)
% 
% find(halfTrain(:,1) == transObjPoints(1098,1))
% find(halfTrain(:,3) == transObjPoints(1567,3))

selectPointIndex(1098) = 2070;
selectPointIndex(1567) = 666;



%% ����ƥ�䵽�ĵ㣬�ع�����

for indexI = 1:length(selectHalfTrainHead)
    for indexJ = 1:length(halfTrain)
        if selectHalfTrainHead(indexI,:) == halfTrain(indexJ, :)
            selectPointIndex(indexI) = indexJ;
        end
    end
end


FaceIndex = FaceIndex - 2105*ones(length(FaceIndex),3);

save selectPointIndex.mat selectPointIndex
save FaceIndex.mat FaceIndex


hold on; trisurf(FaceIndex, halfTrain(selectPointIndex, 1), halfTrain(selectPointIndex, 2), halfTrain(selectPointIndex, 3))
axis equal
% hold on; scatter3(selectHalfTrainHead(:,1), selectHalfTrainHead(:,2), selectHalfTrainHead(:,3), 'filled')
% xlabel('X')
% ylabel('Y')
% zlabel('Z')

% find(selectHalfTrainHead(:,1) == pi)

% find(selectPointIndex(:,1) == 0)
