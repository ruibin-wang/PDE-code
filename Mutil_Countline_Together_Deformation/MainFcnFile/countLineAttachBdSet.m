%%%  定义存放轮廓线的元胞数据集
%%%  绑定输入参数，用一个元胞来表示；包括轮廓线形变方向、大小、旋转角度、切线系数等

% boundAttachToA1_F1  
% boundAttachToA2_F2
% boundAttachToA3_F3 
% boundAttachToA4_F4

%%% boundAttachToE1_E4              
%%% boundAttachToF1_F4            
%%% boundAttachToD1_D4           
%%% boundAttachToC1_C4            
%%% boundAttachToB1_B4
%%% boundAttachToA1_O1_A3
% CounterLineDeformation(countLineAttachBd, aixsT, deltT, bdDirDefNum, deformAngle, coff);  
%%% 1是边界的编号，2为形变的方向aixsT，3为形变的大小deltT，4为bdDirDefNum，5为deformAngle，6 为coff
function countLineAttachBdSet(controlPara)

countLineAttachBdSets{1,1}    =  'boundAttachToA1_F1';       countLineAttachBdSets{1,2}   = 'Y';  %% 第二列表示形变方向
countLineAttachBdSets{1,3}    =  controlPara(1);             countLineAttachBdSets{1,4}   = [];
countLineAttachBdSets{1,5}    =  0*[0, -(1/3)*pi, 0, 0];     countLineAttachBdSets{1,6}   = 1;


countLineAttachBdSets{2,1}    =  'boundAttachToA2_F2';       countLineAttachBdSets{2,2}   = 'Y';  %% 第二列表示形变方向
countLineAttachBdSets{2,3}    =  controlPara(2);             countLineAttachBdSets{2,4}   = [];
countLineAttachBdSets{2,5}    =  0*[0, -(1/3)*pi, 0, 0];     countLineAttachBdSets{2,6}   = 1;


countLineAttachBdSets{3,1}    =  'boundAttachToA3_F3';       countLineAttachBdSets{3,2}   = 'Z';  %% 第二列表示形变方向
countLineAttachBdSets{3,3}    =  controlPara(3);             countLineAttachBdSets{3,4}   = [];
countLineAttachBdSets{3,5}    =  0*[0, -(1/3)*pi, 0, 0];     countLineAttachBdSets{3,6}   = 1;


countLineAttachBdSets{4,1}    =  'boundAttachToA4_F4';       countLineAttachBdSets{4,2}   = 'Z';  %% 第二列表示形变方向
countLineAttachBdSets{4,3}    =  controlPara(4);             countLineAttachBdSets{4,4}   = [];
countLineAttachBdSets{4,5}    =  0*[0, -(1/3)*pi, 0, 0];     countLineAttachBdSets{4,6}   = 1;


%% 
countLineAttachBdSets{5,1}    =  'boundAttachToB1_B4';       countLineAttachBdSets{5,2}   = 'Y';  %% 第二列表示形变方向
countLineAttachBdSets{5,3}    =  controlPara(5);             countLineAttachBdSets{5,4}   = [];
countLineAttachBdSets{5,5}    =  0*[0, -(1/3)*pi, 0, 0];     countLineAttachBdSets{5,6}   = 1;


countLineAttachBdSets{6,1}    =  'boundAttachToC1_C4';       countLineAttachBdSets{6,2}   = 'Y';  %% 第二列表示形变方向
countLineAttachBdSets{6,3}    =  controlPara(6);             countLineAttachBdSets{6,4}   = [];
countLineAttachBdSets{6,5}    =  0*[0, -(1/3)*pi, 0, 0];     countLineAttachBdSets{6,6}   = 1;


countLineAttachBdSets{7,1}    =  'boundAttachToD1_D4';       countLineAttachBdSets{7,2}   = 'Y';  %% 第二列表示形变方向
countLineAttachBdSets{7,3}    =  controlPara(7);             countLineAttachBdSets{7,4}   = [];
countLineAttachBdSets{7,5}    =  0*[0, -(1/3)*pi, 0, 0];     countLineAttachBdSets{7,6}   = 1;


countLineAttachBdSets{8,1}    =  'boundAttachToE1_E4';       countLineAttachBdSets{8,2}   = 'Y';  %% 第二列表示形变方向
countLineAttachBdSets{8,3}    =  controlPara(8);             countLineAttachBdSets{8,4}   = [];
countLineAttachBdSets{8,5}    =  0*[0, -(1/3)*pi, 0, 0];     countLineAttachBdSets{8,6}   = 1;

% countLineAttachBdSets{8,1}    =  'boundAttachToF1_F4';
% countLineAttachBdSets{8,2}   = 'vertical';  %% fixed

countLineAttachBdSets{9,1}    =  'boundAttachToA1_O1_A3';    countLineAttachBdSets{9,2}   = 'X';   %% 第二列表示形变方向
countLineAttachBdSets{9,3}    =  controlPara(9);             countLineAttachBdSets{9,4}   = [];
countLineAttachBdSets{9,5}    =  0*[0, -(1/3)*pi, 0, 0];     countLineAttachBdSets{9,6}   = 1;


countLineAttachBdSets{10,1}   =  'boundAttachToA3_A4';       countLineAttachBdSets{10,2}  = 'Y';  %% 第二列表示形变方向
countLineAttachBdSets{10,3}   =  controlPara(10);            countLineAttachBdSets{10,4} = [];
countLineAttachBdSets{10,5}   =  0*[0, -(1/3)*pi, 0, 0];     countLineAttachBdSets{10,6}  = 1;

save countLineAttachBdSets.mat countLineAttachBdSets
