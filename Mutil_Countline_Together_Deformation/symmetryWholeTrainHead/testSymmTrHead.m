clear;clc
load halfTrainHead.txt
load ObjFacesIndex.mat
load selectPointIndex.mat

LeftTrainHead  = halfTrainHead(selectPointIndex, :)*0.8281;  %% now length 32, it should be 26.5,so  26.5/32
% find(LeftTrainHead(:,3) == max(LeftTrainHead(:,3)))  1614

rightTrainHead = [LeftTrainHead(:,1), LeftTrainHead(:,2), -LeftTrainHead(:,3) + 2*LeftTrainHead(1614,3)];

% hold on; trisurf(ObjFacesIndex, LeftTrainHead(:,1), LeftTrainHead(:,2), LeftTrainHead(:,3)); axis equal
% xlabel('X'); ylabel('Y'); zlabel('Z')
% hold on; trisurf(ObjFacesIndex, rightTrainHead(:,1), rightTrainHead(:,2), rightTrainHead(:,3))

trainHead     =     [LeftTrainHead; rightTrainHead];
save trainHead.txt trainHead -ascii

%% Boundary

load selectTrainHeadIndex.mat
load trainHeadFaceIndex.mat

% bound_15      =     PtMatrix_15(122:133,:)*0.1*0.8281;

load Data.mat boundAttachToF1_F4 threeExtPt

LeftBound     =     flipud([threeExtPt(2,:); boundAttachToF1_F4{2,2}; threeExtPt(3,:)]*0.1*0.8281);

RightBound    =     [LeftBound(:,1), LeftBound(:,2), -LeftBound(:,3) + 2*LeftTrainHead(1614,3)];

bound         =     [LeftBound; flipud(RightBound)];

%%  测试边界点中无用的点 
% newTrainHead  =     trainHead(selectTrainHeadIndex,:);  %% 33 34 vs 2152 2153   得出 33为遗弃的点 34 与2152以及2153重合
% newTrainHead  =     eval(vpa(trainHead(selectTrainHeadIndex,:), 5));
% checkPt       =     eval(vpa(bound(33,:),5));
% find(newTrainHead(:,3) == checkPt(:,3))
% xxx = ismember(newTrainHead, bound(34,:));
% find(xxx(:,1) == 1)
% xxx(2152,:)
% xxx(2153,:)
% xxx(2154,:)
% xxx(2155,:)

% hold on; scatter3(bound(34, 1), bound(34, 2), bound(34, 3), 'filled')

% hold on; trisurf(trainHeadFaceIndex,trainHead(selectTrainHeadIndex,1), trainHead(selectTrainHeadIndex,2), trainHead(selectTrainHeadIndex,3))
% axis equal

% for indexI = 1:length(bound)
%     
%     hold on; scatter3(bound(indexI, 1), bound(indexI, 2), bound(indexI, 3), 'filled')
%     
% end

% hold on; scatter3(bound(end,1), bound(end,2), bound(end,3),'*')
% axis equal
 bound(33, :) =  bound(34, :);   %% 测试结果为：33为无用点，在筛选数据中34索引对应的是2152以及2153索引

%% Rotate whole train

TransMartix   =    makehgtform('yrotate', pi);
OrtTrainTail  =    TransMartix(1:3,1:3) * trainHead';
OrtTrainTail  =    OrtTrainTail';

rotBound      =    TransMartix(1:3,1:3) * bound';
rotBound      =    rotBound';

% % % hold on; scatter3(OrtTrainTail(:,1), OrtTrainTail(:,2), OrtTrainTail(:,3), 'filled')
% %
% % % hold on; scatter3(OrtTrainTail(:,1), OrtTrainTail(:,2), OrtTrainTail(:,3), 'filled')
% %
% % % hold on; scatter3(rotBound(:,1), rotBound(:,2), rotBound(end,3), 'filled')

%% Rotate the bound

deltVert          =     bound(1,:) - rotBound(end,:);

initTrainTail     =     [OrtTrainTail(:,1)+ deltVert(1), OrtTrainTail(:,2)+ deltVert(2), OrtTrainTail(:,3)+ deltVert(3)];

% hold on; scatter3(trainTail(:,1), trainTail(:,2), trainTail(:,3), '*')

%% move the bound

headTrianbound   =      [bound(:,1) - 16.7, bound(:,2), bound(:,3)];

middleTrianbound =      [headTrianbound(:,1) - 25, headTrianbound(:,2), headTrianbound(:,3)];

trainTail        =      [initTrainTail(:,1) - 58.4, initTrainTail(:,2), initTrainTail(:,3)];    %% 16.7+16.7+25

% hold on; scatter3(headTrianbound(:,1), headTrianbound(:,2), headTrianbound(:,3), 'filled')
% hold on; scatter3(middleTrianbound(:,1), middleTrianbound(:,2), middleTrianbound(:,3), 'filled')
% hold on; scatter3(trainTail(:,1), trainTail(:,2), trainTail(:,3), 'filled')

% wholeTrain       =      [trainHead; headTrianbound; middleTrianbound; trainTail];

% save wholeTrain.txt wholeTrain -ascii

%%  Generate train body

middleTrianbound    =      [secTrianHeadBound(:,1) - 25, secTrianHeadBound(:,2), secTrianHeadBound(:,3)];

longTrHdAndMid      =      [longTrainHead; middleTrianbound];  %%  the connection of middle train and the long train head
middleBdIndex       =      (length(longTrainHead)+1 : length(longTrHdAndMid))';

jointMidFaceIndex   =      zeros(2*length(bound)-2,3);    %% store the boundary index of the trainHead and the secTrianHeadBound
steps               =      1;

for indexI = 1:length(bound)-1
    
    jointMidFaceIndex(steps,:) = [secTrHeadBdIndex(indexI), secTrHeadBdIndex(indexI + 1), middleBdIndex(indexI)];
    steps = steps + 1;
    jointMidFaceIndex(steps,:) = [middleBdIndex(indexI), middleBdIndex(indexI+1), secTrHeadBdIndex(indexI + 1)];
    steps = steps + 1;
    
end

longTrHdAndMidBotIndex  =    [secTrHeadBdIndex(1), secTrHeadBdIndex(end), middleBdIndex(end); ...
                              middleBdIndex(end), middleBdIndex(1), secTrHeadBdIndex(1)];

jointMidFaceIndex       =    [jointMidFaceIndex; longTrHdAndMidBotIndex];

longTrHdAndMidFaceIndex =    [longTrHdFaceIndex; jointMidFaceIndex];  %% new faces index





%% 

hold on; trisurf(testIndex, testBound(:,1), testBound(:,2), testBound(:,3))
% axis equal



