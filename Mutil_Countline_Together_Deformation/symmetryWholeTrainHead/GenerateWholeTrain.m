%%-------swjtu_robin@foxmail.com -------%%
%%---------  20171223  -----------------%% 
% this document is used to find the .obj face index of the train data


clear;clc
load halfTrainHead.txt          %% left part
load ObjFacesIndex.mat          %% left part
load selectPointIndex.mat       %% left part

load trainHead.txt              %% train head
load selectTrainHeadIndex.mat   %% train head
load trainHeadFaceIndex.mat     %% train head

%%  creat a cell to resort the index of three parts of the train
   % cell{1,1} points index of the train head
   % cell{1,2} faces index of these points
   % cell{1,3} the value cell{1,2} would minus  

indexStroMatrix = cell(3,3);  %% ÓÃÀ´´æ´¢ÁÐ³µÍ·ÐÍ¡¢³µÉíÒÔ¼°³µÎ²µÄÊý¾ÝºÍË÷Òý

%% Half train Head

LeftTrainHead  = halfTrainHead(selectPointIndex, :)*0.8281;  %% now length 32, it should be 26.5,so  26.5/32

rightTrainHead = [LeftTrainHead(:,1), LeftTrainHead(:,2), -LeftTrainHead(:,3) + 2*LeftTrainHead(1614,3)];

% trainHead      =     [LeftTrainHead; rightTrainHead];

%% Boundary

load Data.mat boundAttachToF1_F4 threeExtPt

LeftBound     =     flipud([threeExtPt(2,:); boundAttachToF1_F4{2,2}; threeExtPt(3,:)]*0.1*0.8281);

RightBound    =     [LeftBound(:,1), LeftBound(:,2), -LeftBound(:,3) + 2*LeftTrainHead(1614,3)];

bound         =     [LeftBound; flipud(RightBound)];

bound(33, :)  =     bound(34, :);   %% ²âÊÔ½á¹ûÎª£º33ÎªÎÞÓÃµã£¬ÔÚÉ¸Ñ¡Êý¾ÝÖÐ34Ë÷Òý¶ÔÓ¦µÄÊÇ2152ÒÔ¼°2153Ë÷Òý,ÏêÇé¼ûtestSymmTrHead

% hold on; scatter3(bound_15(end,1), bound_15(end,2), bound_15(end,3),'*'); axis equal

%% find the boudndary index of the train head

selectTrainHead   =    trainHead(selectTrainHeadIndex, :);   %% new train head

selectHdBdIndex   =    zeros(length(bound),1);

transSelTrHead    =    eval(vpa(selectTrainHead, 4));
transBound        =    eval(vpa(bound, 4));

for indexI = 1:length(transBound)
    for indexJ = 1:length(transSelTrHead)
        if transBound(indexI, :) == transSelTrHead(indexJ, :)
            
            selectHdBdIndex(indexI) = indexJ;
            
        end
    end
end

save selectHdBdIndex.mat selectHdBdIndex

%%  certain the extend(second) boundaries 

secTrianHeadBound   =      [bound(:,1) - 16.7, bound(:,2), bound(:,3)];  %% the second boundary of the trian head

longTrainHead       =      [selectTrainHead; secTrianHeadBound];    %% the long train head

secTrHeadBdIndex    =      (length(selectTrainHead)+1 : length(longTrainHead))';  

jointHdFaceIndex    =      zeros(2*length(bound)-2,3);    %% store the boundary index of the trainHead and the secTrianHeadBound
steps               =      1;
for indexI = 1:length(bound)-1
    
    jointHdFaceIndex(steps,:) = [selectHdBdIndex(indexI), selectHdBdIndex(indexI + 1), length(selectTrainHead) + indexI];
    steps = steps + 1;
    jointHdFaceIndex(steps,:) = [length(selectTrainHead) + indexI, length(selectTrainHead)+indexI+1, selectHdBdIndex(indexI+1)];
    steps = steps + 1;
    
end

longHdBotIndex      =       [selectHdBdIndex(1), selectHdBdIndex(end), length(longTrainHead); ...
                              length(longTrainHead), length(selectTrainHead)+1, selectHdBdIndex(1)];
jointHdFaceIndex    =       [jointHdFaceIndex;  longHdBotIndex];

longTrHdFaceIndex   =       [trainHeadFaceIndex; jointHdFaceIndex];  %% new faces index

longTrHdFaceIndex(7920, :) = [];  %% ÒòÎªÓÐÖØµþ£¬µ¼ÖÂÄ£ÐÍÖÐÓÐÏßÌõ³öÏÖ£¬¹Ê¶ø±»É¾³ýÁË
% hold on; trisurf(longTrHdFaceIndex, longTrainHead(:,1), longTrainHead(:,2), longTrainHead(:,3)); axis equal 
% obj_write('longTrainHead.obj', longTrainHead, longTrHdFaceIndex)
% load testTrainHeadIndex.txt


indexStroMatrix{1,1}    =      [1, length(longTrainHead)];
indexStroMatrix{1,2}    =      [1, length(longTrHdFaceIndex)];
indexStroMatrix{1,3}    =      0; 

%%  connect the middle train

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

% hold on; trisurf(longTrHdAndMidFaceIndex, longTrHdAndMid(:,1), longTrHdAndMid(:,2), longTrHdAndMid(:,3)); axis equal 

% middleTrPtIndex         =    length(selectTrainHead)+1:length(longTrHdAndMid);
% middleTrFacePosIndex    =    length(longTrHdFaceIndex)+1:length(longTrHdAndMidFaceIndex);

indexStroMatrix{2,1}    =    [length(selectTrainHead)+1, length(longTrHdAndMid)];
indexStroMatrix{2,2}    =    [length(longTrHdFaceIndex)+1, length(longTrHdAndMidFaceIndex)];
indexStroMatrix{2,3}    =    longTrHdAndMidFaceIndex(length(longTrHdFaceIndex)+1,1) - 1;

% middlePt                =    longTrHdAndMid(indexStroMatrix{2,1}(1):indexStroMatrix{2,1}(2),:);
% trainMidFaceIndex       =    longTrHdAndMidFaceIndex(indexStroMatrix{2,2}(1):indexStroMatrix{2,2}(2),:) - indexStroMatrix{2,3};
% hold on; trisurf(trainMidFaceIndex, middlePt(:,1), middlePt(:,2), middlePt(:,3)); axis equal 

%%  Rotate the train head, then move

transMartix      =      makehgtform('yrotate', pi);
OrtTrainTail     =      transMartix(1:3,1:3) * selectTrainHead';
OrtTrainTail     =      OrtTrainTail';

rotBound         =      transMartix(1:3,1:3) * bound';
rotBound         =      rotBound';

deltVert         =     bound(1,:) - rotBound(end,:);

noMovedTrainTail =     [OrtTrainTail(:,1)+ deltVert(1), OrtTrainTail(:,2)+ deltVert(2), OrtTrainTail(:,3)+ deltVert(3)];

trainTail        =     [noMovedTrainTail(:,1) - 58.4, noMovedTrainTail(:,2), noMovedTrainTail(:,3)];    %% 16.7+16.7+25

% hold on; trisurf(trainHeadFaceIndex, trainTail(:,1), trainTail(:,2), trainTail(:,3))

%% connect the train tail

wholeTrain       =     [longTrHdAndMid; trainTail];   %% the whole data of the train

trainTailIndex   =     length(longTrHdAndMid) + trainHeadFaceIndex;  %% the index of the train tail
trainTaiBdIndex  =     length(longTrHdAndMid) + selectHdBdIndex;     %% the boundary index of the train tail

trainTaiBdIndex  =     flipud(trainTaiBdIndex);  %% after the rotation, the sequence of the trian head has changed

jointTlFaceIndex =     zeros(2*length(bound)-2,3); 
steps            =     1;

for indexI = 1:length(bound)-1
    
    jointTlFaceIndex(steps,:) = [middleBdIndex(indexI), middleBdIndex(indexI + 1), trainTaiBdIndex(indexI)];
    steps = steps + 1;
    jointTlFaceIndex(steps,:) = [trainTaiBdIndex(indexI), trainTaiBdIndex(indexI+1), middleBdIndex(indexI + 1)];
    steps = steps + 1;
    
end

midAndTlBotIndex      =    [middleBdIndex(1), middleBdIndex(end), trainTaiBdIndex(end); ...
                              trainTaiBdIndex(end), trainTaiBdIndex(1), middleBdIndex(1)];
                          
                          
jointTlFaceIndex      =    [jointTlFaceIndex; midAndTlBotIndex];  %% the index of the middle and the tail 

initWholeTrainIndex   =    [longTrHdAndMidFaceIndex; jointTlFaceIndex; trainTailIndex];  %%  the index of the whole train

% for indexI = 1:length(initWholeTrainIndex)
%     if initWholeTrainIndex(indexI, 1) == initWholeTrainIndex(indexI, 2) || ...
%             initWholeTrainIndex(indexI, 1) == initWholeTrainIndex(indexI, 3) ||... 
%             initWholeTrainIndex(indexI, 2) == initWholeTrainIndex(indexI, 3)
% 
%         disp(indexI)
%     end
% end

initWholeTrainIndex(8184,:)   =  [];  %% µãÖØºÏÁË£¬³ÉÁËÏß£¬GeomagicÖÐ×Ô¶¯É¾³ýÁË£¬µ¼ÖÂÎÞ·¨Æ¥Åä£¬¹Ê¶øÌáÇ°É¾³ý

indexStroMatrix{3,1}  =    [length(longTrainHead)+1, length(wholeTrain)];
indexStroMatrix{3,2}  =    [length(longTrHdAndMidFaceIndex)+1, length(initWholeTrainIndex)];
indexStroMatrix{3,3}  =    length(longTrainHead);


% middlePt                =    wholeTrain(indexStroMatrix{3,1}(1):indexStroMatrix{3,1}(2), :);
% trainMidFaceIndex       =    initWholeTrainIndex(indexStroMatrix{3,2}(1):indexStroMatrix{3,2}(2), :) - indexStroMatrix{3,3};
% hold on; scatter3(middlePt(:,1), middlePt(:,2), middlePt(:,3), 'filled')
% hold on; trisurf(trainMidFaceIndex, middlePt(:, 1), middlePt(:, 2), middlePt(:, 3)); axis equal 
% obj_write('initWholeTrain.obj', wholeTrain, initWholeTrainIndex)


% hold on; trisurf(initWholeTrainIndex, wholeTrain(:,1), wholeTrain(:,2), wholeTrain(:,3)); axis equal
save indexStroMatrix.mat indexStroMatrix

% save initWholeTrainIndex.mat initWholeTrainIndex
% save wholeTrain.mat wholeTrain


%% load the adjusted train index

% load wholeTrain.mat
load wholeTrainIndex.txt  %% ¸Ä±ä·¨ÏßÖ®ºóµÄÕû³µÍ·ÐÍË÷Òý
% 
% hold on; trisurf(wholeTrainIndex, wholeTrain(:,1), wholeTrain(:,2), wholeTrain(:,3)); axis equal
save wholeTrainIndex.mat wholeTrainIndex
% 
obj_write('wholeTrain.obj', wholeTrain, wholeTrainIndex)
% 


%% ÕÒµ½Ìí¼ÓÁËµÄÁ½¸öÍø¸ñ£¨µ¥¶ÀÔËÐÐ£©

% clear;clc
% 
% load wholeTrainIndex.txt  %% ¸Ä±ä·¨ÏßÖ®ºóµÄÕû³µÍ·ÐÍË÷Òý
% load initWholeTrainIndex.mat
% 
% testMatrix = [1 1 1];
% for indexI = 7920:length(initWholeTrainIndex)
%     if ismember(initWholeTrainIndex(indexI, :), wholeTrainIndex(indexI, :))
%         continue
%     else
%        indexI
%     end
% end
   

        
        
        
        
