%%-------swjtu_robin@foxmail.com -------%%
%%---------  20171223  -----------------%% 
% this function is used to generate the data of the whole train
% while the input variable is the half train head.

function wholeTrain =  GeneratWholeTrainData(halfTrainHead)

% load halfTrainHead.txt          %% left part
load selectPointIndex.mat       %% left part

load selectTrainHeadIndex.mat   %% train head
load trainHeadFaceIndex.mat     %% train head

load selectHdBdIndex.mat        %% the boundary index of the train head

%% use the half train Head to generate the train head

LeftTrainHead     =     halfTrainHead(selectPointIndex, :)*0.8281;  %% now length 32, it should be 26.5,so  26.5/32

rightTrainHead    =     [LeftTrainHead(:,1), LeftTrainHead(:,2), -LeftTrainHead(:,3) + 2*LeftTrainHead(1614,3)];

initTrainHead     =     [LeftTrainHead; rightTrainHead];

%% certain the boundary of the short train head
selectTrainHead   =     initTrainHead(selectTrainHeadIndex, :);   %% new train head

bound             =     selectTrainHead(selectHdBdIndex, :);

%%  Rotate the train head, then move



transMartix       =      makehgtform('yrotate', pi);
OrtTrainTail      =      transMartix(1:3,1:3) * selectTrainHead';
OrtTrainTail      =      OrtTrainTail';

rotBound          =      transMartix(1:3,1:3) * bound';
rotBound          =      rotBound';

deltVert          =     bound(1,:) - rotBound(end,:);

noMovedTrainTail  =     [OrtTrainTail(:,1)+ deltVert(1), OrtTrainTail(:,2)+ deltVert(2), OrtTrainTail(:,3)+ deltVert(3)];

trainTail         =     [noMovedTrainTail(:,1) - 58.4, noMovedTrainTail(:,2), noMovedTrainTail(:,3)];    %% 16.7+16.7+25



%%  combine all the patches

secTrianHeadBound   =     [bound(:,1) - 16.7, bound(:,2), bound(:,3)];  %% the second boundary of the trian head
middleTrianbound    =     [secTrianHeadBound(:,1) - 25, secTrianHeadBound(:,2), secTrianHeadBound(:,3)];

wholeTrain          =     [selectTrainHead; secTrianHeadBound; middleTrianbound; trainTail];    %% the long train head

% load wholeTrainIndex.mat 
% 
% hold on; trisurf(wholeTrainIndex, wholeTrain(:,1), wholeTrain(:,2), wholeTrain(:,3)); axis equal
