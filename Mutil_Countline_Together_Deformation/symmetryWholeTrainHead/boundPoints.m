clear;clc
%% 

load halfTrainHead.txt
load ObjFacesIndex.mat
load selectPointIndex

trainHeadShape1 = halfTrainHead(selectPointIndex, :);

%% 

load PtMatrix_13.txt
load PtMatrix_14.txt
load PtMatrix_15.txt

bound_13 = PtMatrix_13(length(PtMatrix_13)-11:end,:);
bound_14 = PtMatrix_14(length(PtMatrix_14)-10:end,:);
bound_15 = PtMatrix_15(122:133,:);

bound = [bound_13; bound_14; bound_15];
%{
hold on; scatter3(PtMatrix_13(:,1), PtMatrix_13(:,2), PtMatrix_13(:,3), 'filled')
hold on; scatter3(PtMatrix_14(:,1), PtMatrix_14(:,2), PtMatrix_14(:,3), 'filled')
hold on; scatter3(PtMatrix_15(:,1), PtMatrix_15(:,2), PtMatrix_15(:,3), 'filled')

hold on; scatter3(bound_13(:,1), bound_13(:,2), bound_13(:,3), '*')
hold on; scatter3(bound_14(:,1), bound_14(:,2), bound_14(:,3), '*')
hold on; scatter3(bound_15(:,1), bound_15(:,2), bound_15(:,3), '*')

hold on; scatter3(bound_15(end,1), bound_15(end,2), bound_15(end,3), '*')
%}



