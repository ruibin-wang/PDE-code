clear; clc

load trainHead.txt
load trainHeadFaceIndex.txt
load vertTrainHead.txt

transTrainHead          =     eval(vpa(trainHead, 4));
transVertTrainHead      =     eval(vpa(vertTrainHead, 4));

selectTrainHeadIndex    =     zeros(length(transVertTrainHead), 1);

for indexI = 1:length(transVertTrainHead)
    for indexJ = 1:length(transTrainHead)
        if transVertTrainHead(indexI, :) == transTrainHead(indexJ, :)
             selectTrainHeadIndex(indexI) = indexJ;
        end
    end
end

selectTrainHeadIndex(selectTrainHeadIndex == 0, :) = 2374;

selectTrainHead  =  transTrainHead(selectTrainHeadIndex, :);

% hold on; trisurf(trainHeadFaceIndex, selectTrainHead(:,1), selectTrainHead(:,2), selectTrainHead(:,3))
% axis equal

save selectTrainHeadIndex.mat selectTrainHeadIndex
save trainHeadFaceIndex.mat trainHeadFaceIndex