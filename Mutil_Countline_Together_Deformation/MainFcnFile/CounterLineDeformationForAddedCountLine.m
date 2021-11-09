%%% 该函数的作用为通过少量的参数改变大轮廓线的形状
%%% 改变偏微分方程三参数
%%% 改变边界切线的方向

function ptMatrix = CounterLineDeformationForAddedCountLine(countLineAttachBd, aixsT, deltT, bdDirDefNum, deformAngle, coff)


avePointSet = cell(17,1);
cd '..\StroNewAvePtForAddedCtLine'

for indexI = 1:17
    
    eval(['load avePoint_', num2str(indexI), '.mat', ' ;']);
    eval(['load Mesh_', num2str(indexI), '.mat', ' ;']);
    eval(['load PtMatrix_', num2str(indexI), '.txt']);   %% 导入未形变的面片点,以覆盖之前运算保存的数据
    %     eval(['temp = avePoint_', num2str(indexI), ';']);
    %     hold on; plot3(temp(:,1), temp(:,2), temp(:,3), '-')
    avePointSet{indexI, 1} = indexI;
    eval(['avePointSet{', num2str(indexI), ', 2} = ', 'avePoint_', num2str(indexI), ';']);
    eval(['load aveTanDir_', num2str(indexI), '.mat']);
    
end

load deformExtendCountLineSet.mat

cd '..\MainFcnFile'  %% 通过保存操作重新覆盖已经形变过的参数
for indexI = 1:17
    
    eval(['save PtMatrix_', num2str(indexI), '.txt', ' PtMatrix_', num2str(indexI), ' -ascii', ';'])
    eval(['save avePoint_', num2str(indexI), '.mat', ' avePoint_', num2str(indexI), ';'])
    %%% 修正边界切线
    %     eval(['aveTanDir_', num2str(indexI), ' =  BdTanAdjust(', 'aveTanDir_', num2str(indexI), ', avePoint_', num2str(indexI), ');']);
    eval(['save aveTanDir_', num2str(indexI), '.mat', ' aveTanDir_', num2str(indexI), ';']);
    
end

save deformExtendCountLineSet.mat


%%% 该部分为轮廓线的定义，只运行一次，并且保存在 DATA.mat 中

%% 生成横向大轮廓线
%%% 将面片边界连接起来，注意：相邻面片重合的顶点只用了一个，后期进行还原分配的时候得考虑好形变后顶点所处的位置

% CountLineName = ['A1_F1';'A2_F2';'A3_F3';'A4_F4';'B1_B4';...
%                     'C1_C4';'D1_D4';'E1_E4';'A1_O1_A3';'originalExtendA1_F1';'originalExtendA4_F4'];

A1_F1 =    [avePoint_3(1,:); avePoint_3(end:-1:31,:); avePoint_6(end:-1:31,:); ...   %% Y axis deformation
    avePoint_9(end:-1:31,:); avePoint_12(end:-1:31,:); ...
    avePoint_15(end:-1:31,:)];

B1    =    avePoint_3(31,:);   C1    =    avePoint_6(31,:);
D1    =    avePoint_9(31,:);   E1    =    avePoint_12(31,:);


B1_B2 =    avePoint_6(1:11,:);   C1_C2 =    avePoint_9(1:11,:);
D1_D2 =    avePoint_12(1:11,:);  E1_E2 =    avePoint_15(1:11,:);

boundAttachToA1_F1{1,1} = A1_F1; boundAttachToA1_F1{1,2} = B1_B2;
boundAttachToA1_F1{1,3} = C1_C2; boundAttachToA1_F1{1,4} = D1_D2;
boundAttachToA1_F1{1,5} = E1_E2;
boundAttachToA1_F1{2,1} = 'A1_F1';   %% 元胞第二行第一个位置存放轮廓线的编号，方便调试


A2_F2 = [avePoint_3(11:21,:); avePoint_6(12:21,:); avePoint_9(12:21,:);...    %% Z axis deformation
    avePoint_12(12:21,:); avePoint_15(12:21,:)];

B2    =    avePoint_3(21,:);   C2    =    avePoint_6(21,:);
D2    =    avePoint_9(21,:);   E2    =    avePoint_12(21,:);

B2_B3 =    avePoint_5(1:11,:);   C2_C3 =    avePoint_8(1:11,:);
D2_D3 =    avePoint_11(1:11,:);  E2_E3 =    avePoint_14(1:11,:);

boundAttachToA2_F2{1,1} = A2_F2; boundAttachToA2_F2{1,2} = B1_B2;
boundAttachToA2_F2{1,3} = C1_C2; boundAttachToA2_F2{1,4} = D1_D2;
boundAttachToA2_F2{1,5} = E1_E2;

boundAttachToA2_F2{1,6} = B2_B3; boundAttachToA2_F2{1,7} = C2_C3;
boundAttachToA2_F2{1,8} = D2_D3; boundAttachToA2_F2{1,9} = E2_E3;
boundAttachToA2_F2{2,1} = 'A2_F2';

A3_F3 = [avePoint_1(1:11,:);  avePoint_4(end:-1:31,:);...    %% Z axis deformation
    avePoint_7(end:-1:31,:); avePoint_10(end:-1:31,:);...
    avePoint_13(end:-1:31,:)];

B3    =    avePoint_1(11,:);  C3    =    avePoint_4(31,:);
D3    =    avePoint_7(31,:);  E3    =    avePoint_10(31,:);

B3_B4 =    avePoint_4(1:11,:);   C3_C4 =    avePoint_7(1:11,:);
D3_D4 =    avePoint_10(1:11,:);  E3_E4 =    avePoint_13(1:11,:);

boundAttachToA3_F3{1,1} = A3_F3; boundAttachToA3_F3{1,2} = B2_B3;
boundAttachToA3_F3{1,3} = C2_C3; boundAttachToA3_F3{1,4} = D2_D3;
boundAttachToA3_F3{1,5} = E2_E3;

boundAttachToA3_F3{1,6} = B3_B4; boundAttachToA3_F3{1,7} = C3_C4;
boundAttachToA3_F3{1,8} = D3_D4; boundAttachToA3_F3{1,9} = E3_E4;
boundAttachToA3_F3{2,1} = 'A3_F3';

A4_F4 = [avePoint_1(31:-1:21,:); avePoint_4(12:21,:); avePoint_7(12:21,:); ...   %% X,Z axis deformation
    avePoint_10(12:21,:); avePoint_13(12:21,:)];

B4    =    avePoint_1(21,:);   C4    =    avePoint_4(21,:);
D4    =    avePoint_7(21,:);   E4    =    avePoint_10(21,:);

boundAttachToA4_F4{1,1} = A4_F4; boundAttachToA4_F4{1,2} = B3_B4;
boundAttachToA4_F4{1,3} = C3_C4; boundAttachToA4_F4{1,4} = D3_D4;
boundAttachToA4_F4{1,5} = E3_E4;
boundAttachToA4_F4{2,1} = 'A4_F4';

%% 车头鼻尖

A1_O1_A3 = [ avePoint_16(31:end,:); avePoint_16(1,:); avePoint_17(1,:); avePoint_17(end:-1:31,:)];    %% X axis deformation
P1_O1 = avePoint_16(1:11, :);   O1_P2 = avePoint_17(1:11, :);
O1_O2 = avePoint_16(11:21, :);


boundAttachToA1_O1_A3{1, 1} = A1_O1_A3;   boundAttachToA1_O1_A3{1, 2} = P1_O1;
boundAttachToA1_O1_A3{1, 3} = O1_P2;      boundAttachToA1_O1_A3{1, 4} = O1_O2;
boundAttachToA1_O1_A3{2, 1} = 'A1_O1_A3';

% hold on; scatter3(avePoint_16(11,1), avePoint_16(11,2), avePoint_16(11,3), 'filled')
% hold on; scatter3(avePoint_17(:,1), avePoint_17(:,2), avePoint_17(:,3), 'filled')
%
% hold on; plot3(A1_O1_A3(:,1), A1_O1_A3(:,2), A1_O1_A3(:,3), '-')

%% 延拓点
%{
%%% 为了节省时间提前导入，保存成数据文件
% meshIndex_1          =     xlsread('MeshIndex.xlsx', 1);
% meshIndex_2          =     xlsread('MeshIndex.xlsx', 2);
% 
% meshIndex_3          =     xlsread('MeshIndex.xlsx', 3);
% meshIndex_4          =     xlsread('MeshIndex.xlsx', 4);
% meshIndex_5          =     xlsread('MeshIndex.xlsx', 5);
% meshIndex_6          =     xlsread('MeshIndex.xlsx', 6);
% meshIndex_7          =     xlsread('MeshIndex.xlsx', 7);
% meshIndex_8          =     xlsread('MeshIndex.xlsx', 8);
% meshIndex_9          =     xlsread('MeshIndex.xlsx', 9);
% meshIndex_10         =     xlsread('MeshIndex.xlsx', 10);
% meshIndex_11          =     xlsread('MeshIndex.xlsx', 11);
% meshIndex_12         =     xlsread('MeshIndex.xlsx', 12);
% meshIndex_13         =     xlsread('MeshIndex.xlsx', 13);
% meshIndex_14         =     xlsread('MeshIndex.xlsx', 14);
% meshIndex_15         =     xlsread('MeshIndex.xlsx', 15);
% 
% meshIndex_16         =     xlsread('MeshIndex.xlsx', 16);
% meshIndex_17         =     xlsread('MeshIndex.xlsx', 17);
% 
% MeshIndexSets      =   cell(17,1);
% for indexI = 1:17
%     eval(['MeshIndexSets{indexI, 1} = meshIndex_', num2str(indexI), ';']);
% end
% 
% save MeshIndexSets.mat

%}

load MeshIndexSets.mat   %% 存放面片索引的数据文件


for indexI = 1:17
    eval(['meshIndex_', num2str(indexI), ' = ', 'MeshIndexSets{indexI, 1}', ';']); %% 从面片索引的文件中，对每部分进行赋值
end


%%% 原始的面片延拓点
originalExtendA1_F1  =    [Mesh_3(meshIndex_3(:,1), :); Mesh_6(meshIndex_6(:,1), :); Mesh_9(meshIndex_9(:,1), :); ...
    Mesh_12(meshIndex_12(:,1), :); Mesh_15(meshIndex_15(:,1), :)];
%%% 原始的面片延拓点
originalExtendA4_F4  =    [Mesh_1(meshIndex_1(1,:), :); Mesh_4(meshIndex_4(:,size(meshIndex_4,2)), :); Mesh_7(meshIndex_7(:,size(meshIndex_7,2)), :); ...
    Mesh_10(meshIndex_10(:,size(meshIndex_10,2)), :); Mesh_13(meshIndex_13(:,size(meshIndex_13,2)), :)];


originalExtendA1_O1_A3  =    [Mesh_16(meshIndex_16(:,1), :); Mesh_17(meshIndex_17(:,1), :)];


%%% 简化之后的延拓点
extendA1_F1          =    findNearPoint(A1_F1, originalExtendA1_F1, 10000);        %%  边界边的延拓点
extendA4_F4          =    findNearPoint(A4_F4, originalExtendA4_F4, 10000);        %%  边界边的延拓点
extendA1_O1_A3       =    findNearPoint(A1_O1_A3, originalExtendA1_O1_A3, 10000);        %%  边界边的延拓点



boundAttachToA1_F1{2,2} = extendA1_F1; boundAttachToA4_F4{2,2} = extendA4_F4;  %% 只有元胞第二行第一个位置存放延拓点
boundAttachToA1_O1_A3{2,2} = extendA1_O1_A3;

% hold on; scatter3(extendA1_F1(:,1), extendA1_F1(:,2), extendA1_F1(:,3), 'filled')
% hold on; scatter3(extendA4_F4(:,1), extendA4_F4(:,2), extendA4_F4(:,3), 'filled')

%% 生成纵向大轮廓线
%%% 相邻面片交汇点在重新分配的时候得重新考虑，因为只用了一个
B1_B4 = [avePoint_6(1:11,:); avePoint_5(2:11,:); avePoint_4(2:11,:)];   %% Z,Y axis deformation
A2_B2 = avePoint_3(11:21,:);   A3_B3 = avePoint_2(11:21,:);
B2_C2 = avePoint_6(11:21,:);   B3_C3 = avePoint_5(11:21,:);

boundAttachToB1_B4{1,1} = B1_B4;   boundAttachToB1_B4{1,2} = A2_B2;
boundAttachToB1_B4{1,3} = A3_B3;   boundAttachToB1_B4{1,4} = B2_C2;
boundAttachToB1_B4{1,5} = B3_C3;
boundAttachToB1_B4{2,1} = 'B1_B4';

C1_C4 = [avePoint_9(1:11,:); avePoint_8(2:11,:); avePoint_7(2:11,:)];    %% Z,Y axis deformation
C2_D2 = avePoint_9(11:21,:);   C3_D3 = avePoint_8(11:21,:);

boundAttachToC1_C4{1,1} = C1_C4;   boundAttachToC1_C4{1,2} = B2_C2;
boundAttachToC1_C4{1,3} = B3_C3;   boundAttachToC1_C4{1,4} = C2_D2;
boundAttachToC1_C4{1,5} = C3_D3;
boundAttachToC1_C4{2,1} = 'C1_C4';


D1_D4 = [avePoint_12(1:11,:); avePoint_11(2:11,:); avePoint_10(2:11,:)];   %% Z,Y axis deformation
D2_E2 = avePoint_12(11:21,:);   D3_E3 = avePoint_11(11:21,:);

boundAttachToD1_D4{1,1} = D1_D4;   boundAttachToD1_D4{1,2} = C2_D2;
boundAttachToD1_D4{1,3} = C3_D3;   boundAttachToD1_D4{1,4} = D2_E2;
boundAttachToD1_D4{1,5} = D3_E3;
boundAttachToD1_D4{2,1} = 'D1_D4';


E1_E4 = [avePoint_15(1:11,:); avePoint_14(2:11,:); avePoint_13(2:11,:)];   %% Z,Y axis deformation
E2_F2 = avePoint_12(11:21,:);   E3_F3 = avePoint_11(11:21,:);

boundAttachToE1_E4{1,1} = E1_E4;   boundAttachToE1_E4{1,2} = D2_E2;
boundAttachToE1_E4{1,3} = D3_E3;   boundAttachToE1_E4{1,4} = E2_F2;
boundAttachToE1_E4{1,5} = E3_F3;
boundAttachToE1_E4{2,1} = 'E1_E4';


F1_F4 = [avePoint_15(31:-1:21,:); avePoint_14(30:-1:21,:); avePoint_13(30:-1:21,:)];   %% Z,Y axis deformation
E2_F2 = avePoint_12(11:21,:);   E3_F3 = avePoint_11(11:21,:);

boundAttachToF1_F4{1,1} = F1_F4;   boundAttachToF1_F4{1,2} = D2_E2;
boundAttachToF1_F4{1,3} = D3_E3;   boundAttachToF1_F4{1,4} = E2_F2;
boundAttachToF1_F4{1,5} = E3_F3;
boundAttachToF1_F4{2,1} = 'F1_F4';


originalExtendF1_F4  =    [Mesh_15(meshIndex_15(1,:), :); Mesh_14(meshIndex_14(1,:), :); Mesh_13(meshIndex_13(1,:), :)];
extendF1_F4          =    findNearPoint(F1_F4, originalExtendF1_F4, 10000);        %%  边界边的延拓点
boundAttachToF1_F4{2,2} = extendF1_F4;

A3_A4 = [avePoint_1(1,:); avePoint_1(end:-1:31,:)];

originalExtendA3_A4  =    Mesh_1(meshIndex_1(:,1), :);
extendA3_A4          =    findNearPoint(A3_A4, originalExtendA3_A4, 10000);        %%  边界边的延拓点


boundAttachToA3_A4{1,1}  =   A3_A4;
boundAttachToA3_A4{2,1}  =  'A3_A4';  boundAttachToA3_A4{2,2}  =  extendA3_A4;

threeExtPt = [Mesh_1(meshIndex_1(1,1), :); Mesh_15(meshIndex_15(1,1), :); Mesh_13(meshIndex_13(1,end), :)];    %% 延拓点的交点

% save DATA.mat  %% 避免重复计算，存放以上所有数据信息
%}

%% 参数接口，输入
% aixsT               =    'Y';
% deltT               =    0.2;

% load DATA.mat

countLineAttachBd   =    eval(countLineAttachBd);  %% 存放待形变轮廓线和依附在轮廓线上的曲面边界

% bdDirDefNum         =    9;   %% 需要改变面片边界切线的面片编号，若为[]，则表示不进行边界切线方向改变
% coff                =    1;    %% 参数系数
% deformAngle         =    [0, -(1/2)*pi, 0, 0];   %%  向外表现为凹陷，向内表现为凸起，效果刚刚好

% deformAngle         =    [0, (3/2)*pi, 0, 0];   %%  参数系数为1时，表现为外凸
% deformAngle         =    [0, -(1/3)*pi, 0, 0];   %%  参数系数为1时，表现为外凸，效果不错

% deformAngle         =    [0, -(2/3)*pi, 0, 0];   %%  参数系数为1时，内凸，外凹，效果不错


%%% boundAttachToE1_E4            boundAttachToA1_F1
%%% boundAttachToF1_F4            boundAttachToA2_F2
%%% boundAttachToD1_D4            boundAttachToA3_F3
%%% boundAttachToC1_C4            boundAttachToA4_F4
%%% boundAttachToB1_B4
%%% boundAttachToA1_O1_A3

%% 单个面片边界切线旋转

if ~isempty(bdDirDefNum)
    
    eval(['avePoint = avePoint_', num2str(bdDirDefNum), ';']);
    eval(['boundTan =', ' aveTanDir_', num2str(bdDirDefNum), ';']);
    
    deformTanDir        =      BoundDirDeformation(boundTan, avePoint, deformAngle, coff);  %% 还得注意绕轴的方向，后期得加上
    
    eval(['aveTanDir_', num2str(bdDirDefNum), ' = deformTanDir', ';']);
    eval(['save aveTanDir_', num2str(bdDirDefNum), '.mat', ' aveTanDir_', num2str(bdDirDefNum), ';']);
    
    %     MatchBdDirDef(bdDirDefNum, deformTanDir)  %% 边界边切线形变导致相邻面片边界切线同步发生改变,保存生成的边界切线
    
end


%% 形变及匹配

deformCountLine             =      boundMotivation(countLineAttachBd{1,1}, aixsT, deltT);   %% 形变后的轮廓线

defBdAttachToCountLine      =      countLineAttachBd;    %% 存放轮廓线以及其依附曲线形变之后的形状
defBdAttachToCountLine{1,1} =      deformCountLine;  %% 形变后的轮廓线占据第一个位置

% hold on; scatter3(0.1*deformCountLine(:,1), 0.1*deformCountLine(:,2), 0.1*deformCountLine(:,3), 'filled')
%
% hold on; scatter3(0.1*countLineAttachBd{1,1}(:,1), 0.1*countLineAttachBd{1,1}(:,2), 0.1*countLineAttachBd{1,1}(:,3), 'filled')

%% 计算鼻尖部位的形变

if strcmp(countLineAttachBd{2,1} ,'A1_O1_A3')
    for indexI = 2:length(countLineAttachBd)
        %%% 此处轮廓线与别处不同，所以得单独提取出来
        if indexI == length(countLineAttachBd)
            if aixsT == 'X'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    defBdAttachToCountLine{1,indexI}(indexJ,1) = countLineAttachBd{1,indexI}(indexJ,1) + ...
                        localIncrease * cos((pi/(2*10))*(indexJ-1));
                end
            elseif aixsT == 'Y'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    defBdAttachToCountLine{1,indexI}(indexJ,2) = countLineAttachBd{1,indexI}(indexJ,2) + ...
                        localIncrease * cos((pi/(2*10))*(indexJ-1));
                end
            end
            continue
        end
        
        if ~isempty(find(ismember(countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1))
            localIncrease = sign(deltT) * norm(deformCountLine(find(ismember(countLineAttachBd{1,1}, ...
                countLineAttachBd{1,indexI}(1,:)), 1),:) - countLineAttachBd{1,indexI}(1,:));
            if aixsT == 'X'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    if indexJ == 1
                        %%% 对于依附在形变轮廓线上的点来说，选择直接赋值
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1),:);
                    else
                        %%% 对于依附于形变轮廓线上的边界来说，直接进行平移，规定只在X轴方向上进行移动，故而，不再进行判断
                        defBdAttachToCountLine{1,indexI}(indexJ,1) = countLineAttachBd{1,indexI}(indexJ,1) + localIncrease;
                    end
                end
            elseif aixsT == 'Y'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    if indexJ == 1
                        %%% 对于依附在形变轮廓线上的点来说，选择直接赋值
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1),:);
                    else
                        %%% 对于依附于形变轮廓线上的边界来说，直接进行平移，规定只在X轴方向上进行移动，故而，不再进行判断
                        defBdAttachToCountLine{1,indexI}(indexJ,2) = countLineAttachBd{1,indexI}(indexJ,2) + localIncrease;
                    end
                end
            end
            
            
        elseif ~isempty(find(ismember(countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1))
            localIncrease = sign(deltT)*norm(deformCountLine(find(ismember(countLineAttachBd{1,1}, ...
                countLineAttachBd{1,indexI}(end,:)), 1),:) - countLineAttachBd{1,indexI}(end,:));
            if aixsT == 'X'
                for indexJ = length(countLineAttachBd{1,2}):-1:1
                    if indexJ == length(countLineAttachBd{1,2})
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,1) = countLineAttachBd{1,indexI}(indexJ,1) + localIncrease ;
                    end
                end
                
            elseif aixsT == 'Y'
                for indexJ = length(countLineAttachBd{1,2}):-1:1
                    if indexJ == length(countLineAttachBd{1,2})
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,2) = countLineAttachBd{1,indexI}(indexJ,2) + localIncrease ;
                    end
                end
            end
            
        end
    end
    
elseif strcmp(countLineAttachBd{2,1} ,'A3_A4') ~= 1
    %% 计算除去鼻尖之外的部分
    for indexI = 2:length(countLineAttachBd)
        if ~isempty(find(ismember(countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1))
            %%% 前面的系数是为了保证当增量为负的时候，其余点的增量也是负的
            localIncrease = sign(deltT)*norm(deformCountLine(find(ismember(countLineAttachBd{1,1}, ...
                countLineAttachBd{1,indexI}(1,:)), 1),:) - countLineAttachBd{1,indexI}(1,:));
            if aixsT == 'X'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    if indexJ == 1
                        %%% 对于依附在形变轮廓线上的点来说，选择直接赋值
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1),:);
                    else
                        %%% 对于依附于形变轮廓线上的边界来说，增量按照乘以余弦来增减，
                        %%% 11个点，将余弦的pi/2进行划分，然后按照点的顺序，作为增量系数，愈靠近形变轮廓线点的增量就越大
                        defBdAttachToCountLine{1,indexI}(indexJ,1) = countLineAttachBd{1,indexI}(indexJ,1) + ...
                            localIncrease * cos((pi/(2*10))*(indexJ-1));
                    end
                end
                
                
            elseif aixsT == 'Y'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    if indexJ == 1
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,2) = countLineAttachBd{1,indexI}(indexJ,2) + ...
                            localIncrease * cos((pi/(2*10))*(indexJ-1));
                    end
                end
                
            elseif aixsT == 'Z'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    if indexJ == 1
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,3) = countLineAttachBd{1,indexI}(indexJ,3) + ...
                            localIncrease * cos((pi/(2*10))*(indexJ-1));
                    end
                end
            end
            
        elseif ~isempty(find(ismember(countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1))
            localIncrease = sign(deltT)*norm(deformCountLine(find(ismember(countLineAttachBd{1,1}, ...
                countLineAttachBd{1,indexI}(end,:)), 1),:) - countLineAttachBd{1,indexI}(end,:));
            if aixsT == 'X'
                for indexJ = length(countLineAttachBd{1,2}):-1:1
                    if indexJ == length(countLineAttachBd{1,2})
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,1) = countLineAttachBd{1,indexI}(indexJ,1) + ...
                            localIncrease * cos((pi/(2*10))*(11-indexJ));
                    end
                end
            elseif aixsT == 'Y'
                for indexJ = length(countLineAttachBd{1,2}):-1:1
                    if indexJ == length(countLineAttachBd{1,2})
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,2) = countLineAttachBd{1,indexI}(indexJ,2) + ...
                            localIncrease * cos((pi/(2*10))*(11-indexJ));
                    end
                end
                
            elseif aixsT == 'Z'
                for indexJ = length(countLineAttachBd{1,2}):-1:1
                    if indexJ == length(countLineAttachBd{1,2})
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,3) = countLineAttachBd{1,indexI}(indexJ,3) + ...
                            localIncrease * cos((pi/(2*10))*(11-indexJ));
                    end
                end
            end
        end
    end
end


%% 判断边界边形变属于哪个面片，并且替换相应的avePoint


tempBoundAttachToCountLine   =   cell(length(countLineAttachBd), 1);
tempAvePointSet              =   cell(length(avePointSet), 1);


for indexI = 1:length(countLineAttachBd)
    tempBoundAttachToCountLine{indexI,1} = round(countLineAttachBd{1,indexI}, 2);  %% 避免误差
end

for indexI = 1:length(avePointSet)
    tempAvePointSet{indexI,1} = round(avePointSet{indexI,2}, 2);
end

relatePatchNum = [];  %% 边对应的面片
%%% 拿未形变的轮廓线与原始的均分点进行匹配，然后用相应位置的形变了的轮廓线进行替换，得到新的，形变之后的面片均分点
for indexI = 1:length(countLineAttachBd)
    %     tempBoundAttachToCountLine = eval(vpa(countLineAttachBd{1,indexI}, 4));  %% 避免误差
    for indexJ = 1:length(countLineAttachBd{1,indexI})
        for indexK = 1:length(avePointSet)
            %             tempAvePointSet = eval(vpa(avePointSet{indexK,2}, 4));
            for indexL = 1:length(avePointSet{1,2})
                if tempBoundAttachToCountLine{indexI,1}(indexJ, :) == tempAvePointSet{indexK,1}(indexL,:)
                    avePointSet{indexK,2}(indexL,:) = defBdAttachToCountLine{1,indexI}(indexJ, :);
                    relatePatchNum = [relatePatchNum; indexK];  %% 为了节省后面运算的时间，选择出改变了边界形状的面片编号
                end
            end
        end
    end
end

% hold on; scatter3(0.1*avePointSet{4,2}(:,1), 0.1*avePointSet{4,2}(:,2), 0.1*avePointSet{4,2}(:,3), 'r*')

relatePatchNum = unique(relatePatchNum);  %% 去掉形变面片编号中重复的编号

for indexI = 1:length(relatePatchNum)   %% 保存将形变之后的边界边进行保存
    
    eval(['avePoint_', num2str(relatePatchNum(indexI)), ' = ', 'avePointSet{relatePatchNum(indexI),2}', ';']);
    eval(['save avePoint_', num2str(relatePatchNum(indexI)), '.mat', ' avePoint_', num2str(relatePatchNum(indexI)), ';']);
    
end

%%  为了并行计算，把变量赋值摘出来，放在并行外面

% newMeshSet          =       cell(17, 1);   %% 存放
newAvePointSet      =       cell(17, 1);
newAveTanDir        =       cell(17, 1);

for indexI = 1:17
    
    %     eval(['load ', ' Mesh_', num2str(indexI), '.mat', ';']);   %% 导入原始数据
    %     eval(['newMeshSet{indexI} = Mesh_', num2str(indexI), ';']);
    eval(['load', ' avePoint_', num2str(indexI), '.mat', ';']);  %%  导入面片的均分边界
    eval(['newAvePointSet{indexI} = avePoint_', num2str(indexI), ';']);
    eval(['load', ' aveTanDir_', num2str(indexI), '.mat', ';']);   %% 导入均分边界对应的切线
    eval(['newAveTanDir{indexI} = aveTanDir_', num2str(indexI), ';']);
    
end


save newAvePointSet.mat newAvePointSet
save newAveTanDir.mat newAveTanDir

%% 保存更改后的均分点数据
%
% cd '..\StroNewAvePtForAddedCtLine'
% for indexI = 1:17
%
%     eval(['save PtMatrix_', num2str(indexI), '.txt', ' PtMatrix_', num2str(indexI), ' -ascii', ';'])
%     eval(['save avePoint_', num2str(indexI), '.mat', ' avePoint_', num2str(indexI), ';'])
%     %%% 修正边界切线
%     eval(['save aveTanDir_', num2str(indexI), '.mat', ' aveTanDir_', num2str(indexI), ';']);
%
% end
%
%
% cd '..\MainFcnFile'  %% 返回当前目录


%% 数据导入，进行计算，并且保存结果
aveValue = 10;

% meshOrderSet    =      xlsread('meshOrderAndPdePara.xlsx',2);     %% 面片编号的检索，该数据包含中心面片和相邻面片的面片编号
paraSet         =      xlsread('meshOrderAndPdePara.xlsx',1);    %% 读入每个曲面的三个PDE参数，这些数据为原始面片的三个参数

%%% -----------------------------------------------------------------------
%%%  判断并行pool是不是关闭了

global poolStates
try 
    
    isequal(poolStates.Connected, 1);
    
catch
    
    delete(gcp('nocreate'))   %% 防止报错，提前关闭并行中打开的worker
    c = parcluster;
    poolStates  =  parpool(c);
    
end
%--------------------------------------------------------------------------


parfor indexI = 1:length(relatePatchNum)
    middleMeshNum          =    relatePatchNum(indexI);
    
    %     meshOrderSet    =      xlsread('meshOrderAndPdePara.xlsx',2);     %% 面片编号的检索，该数据包含中心面片和相邻面片的面片编号
    %     meshOrder       =      meshOrderSet(middleMeshNum, :);    %%   中心面片及其相邻面片序列
    %     meshOrder(find(isnan(meshOrder))) = [];    %% 对于没有相邻面片的部分置空
    %     currentSheet    =      meshOrder;
    
    %     paraSet         =      xlsread('meshOrderAndPdePara.xlsx',1);    %% 读入每个曲面的三个PDE参数，这些数据为原始面片的三个参数
    Para            =      paraSet(middleMeshNum,:);        %% 提取中心面片的PDE参数，为一个1*3的矩阵，后面写入优化算法中的话就可以设置成三个变量来优化
    
    
    %%%   此处代码不可行，容易产生位置的形变
    %     if relatePatchNum(indexI) == bdDirDefNum
    %            ParaSet = [ -0.4271   -5.6914    0.0409;    %%  测试中比较好的几组参数
    %                  -0.7971   -5.3416   -0.2802;
    %                  -0.4488   -7.5946   -0.6791;
    %                  -0.7860   -6.3685   -0.1330;
    %                  -0.1562   -7.2740   -0.7545;
    %                  -0.9558   -1.9809   -0.0615;
    %                  -0.0628   -7.8013   -0.0200;
    %                  -0.2461   -5.4255   -0.3331;
    %                  -0.0637   -7.0352   -1.3739;
    %                  -0.2328   -7.7572   -0.2328;
    %                  -0.1305   -5.3329   -0.7499;
    %                  -0.7997   -3.1989   -2.4150;%% 可以试一试
    %                  -0.0366   -3.2752   -1.6533];
    %
    %         Para   =  ParaSet(randi(8,1), :)
    %         Para = [-0.0628   -7.8013   -0.0200];
    %     else
    %         Para        =      paraSet(middleMeshNum,:);        %% 提取中心面片的PDE参数，为一个1*3的矩阵，后面写入优化算法中的话就可以设置成三个变量来优化
    %     end
    
    
    %     middleMesh     =      newMeshSet{middleMeshNum};
    avePoint       =      newAvePointSet{middleMeshNum};
    boundTan       =      newAveTanDir{middleMeshNum};
    
    if middleMeshNum == bdDirDefNum
        
        deformMeshPt = DiffDirMiddleGeneration(Para, avePoint,...
            boundTan, middleMeshNum, aveValue);   %% 求解PDE时用的切线不一样
        
    else
        defPtMatrix = MiddleGeneration(Para, avePoint,...
            boundTan, middleMeshNum, aveValue);   %% three dimesional Matrix
    end
    
end
%% 组合所有面片


ptMatrix = [];
for index = 1:17
    
    eval(['load PtMatrix_', num2str(index), '.txt']);   %% 导入未形变的面片点
    eval(['ptMatrix = [ptMatrix; PtMatrix_', num2str(index), '];']);
    
end
%%% 先对外围的轮廓线进行定义，如果与变形的边界有联系，则直接修改

% deformExtendCountLineSet =    [boundAttachToA1_F1{2,2}; boundAttachToA4_F4{2,2}; boundAttachToA1_O1_A3{2,2}; boundAttachToA3_A4{2,2}];
% load deformExtendCountLineSet.mat

%%% 判断轮廓线是否具有延拓点
if strcmp(countLineAttachBd{2,1}, 'A1_F1')
    deformExtendCountLine    =    boundMotivation(countLineAttachBd{2,2}, aixsT, deltT);   %% 只有A1_F1、A4_F4和A1_O1_A3才有此项
    %     deformExtendCountLineSet =    [deformExtendCountLine; boundAttachToA4_F4{2,2}; boundAttachToA1_O1_A3{2,2}; boundAttachToA3_A4{2,2}];
    deformExtendCountLineSet(1:length(deformExtendCountLine), :) = deformExtendCountLine;
    
elseif strcmp(countLineAttachBd{2,1}, 'A4_F4')
    deformExtendCountLine    =    boundMotivation(countLineAttachBd{2,2}, aixsT, deltT);   %% 只有A1_F1、A4_F4和A1_O1_A3才有此项
    %     deformExtendCountLineSet =    [boundAttachToA1_F1{2,2}; deformExtendCountLine; boundAttachToA1_O1_A3{2,2}; boundAttachToA3_A4{2,2}];
    deformExtendCountLineSet(length(boundAttachToA1_F1{2,2})+1:length(boundAttachToA1_F1{2,2})+length(deformExtendCountLine), :) = deformExtendCountLine;
elseif strcmp(countLineAttachBd{2,1}, 'A1_O1_A3')
    deformExtendCountLine    =    boundMotivation(countLineAttachBd{2,2}, aixsT, deltT);   %% 只有A1_F1、A4_F4和A1_O1_A3才有此项
    %     deformExtendCountLineSet =    [boundAttachToA1_F1{2,2}; boundAttachToA4_F4{2,2}; deformExtendCountLine; boundAttachToA3_A4{2,2}];
    deformExtendCountLineSet(length(boundAttachToA1_F1{2,2})+length(boundAttachToA4_F4{2,2})+1:length(boundAttachToA1_F1{2,2})+...
        length(boundAttachToA4_F4{2,2})+length(deformExtendCountLine), :) = deformExtendCountLine;
    
elseif strcmp(countLineAttachBd{2,1}, 'A3_A4')
    deformExtendCountLine    =    boundMotivation(countLineAttachBd{2,2}, aixsT, deltT);   %% 只有A1_F1、A4_F4和A1_O1_A3才有此项
    %     deformExtendCountLineSet =    [boundAttachToA1_F1{2,2}; boundAttachToA4_F4{2,2}; boundAttachToA1_O1_A3{2,2}; deformExtendCountLine];
    deformExtendCountLineSet(length(boundAttachToA1_F1{2,2})+length(boundAttachToA4_F4{2,2})+length(boundAttachToA1_O1_A3{2,2})+1:length(boundAttachToA1_F1{2,2})+...
        length(boundAttachToA4_F4{2,2})+length(boundAttachToA1_O1_A3{2,2})+length(deformExtendCountLine), :) = deformExtendCountLine;
end


%% 保存更改后的均分点数据
cd '..\StroNewAvePtForAddedCtLine'  % 将新的数据保存下来，后续要调用到
for indexI = 1:17
    
    eval(['save PtMatrix_', num2str(indexI), '.txt', ' PtMatrix_', num2str(indexI), ' -ascii', ';'])
    eval(['save avePoint_', num2str(indexI), '.mat', ' avePoint_', num2str(indexI), ';'])
    %%% 修正边界切线
    eval(['save aveTanDir_', num2str(indexI), '.mat', ' aveTanDir_', num2str(indexI), ';']);
    
end


save newAvePointSet.mat newAvePointSet
save newAveTanDir.mat newAveTanDir

save deformExtendCountLineSet.mat deformExtendCountLineSet

cd '..\MainFcnFile'  %% 返回当前目录

%%
ptMatrix = 0.1 * [ptMatrix; boundAttachToF1_F4{2,2}; threeExtPt; deformExtendCountLineSet]; %% Maya导出时，数据被放大，此次处为补偿性缩小

halfTrainHead = ptMatrix;
save halfTrainHead.txt halfTrainHead  -ascii

%% 生成stl格式文件

% load selectPointIndex.mat
% load ObjFacesIndex.mat
% stlSavePath = '..\threeStlParts';    %% 存放三个stl格式模型的文件，到时候记得改路径
%
% trainHeadPt = ptMatrix(selectPointIndex, :);
%
% stlwrite('trainHead.stl', FaceIndex, trainHeadPt)  %% 生成头型stl文件
% movefile('trainHead.stl',stlSavePath)  %% 将头型stl格式文件保存到指定位置



% obj_write('trainHead.obj', trainHeadPt, FaceIndex )
% movefile('trainHead.obj', stlSavePath)  %% 将头型stl格式文件保存到指定位置


% save ptMatrix.txt ptMatrix -ascii
% hold on; scatter3(ptMatrix(:,1), ptMatrix(:,2), ptMatrix(:,3), 'filled')
% xlabel('X');ylabel('Y');zlabel('Z')
% axis equal
%}

% figure(2)
% hold on; scatter3(ptMatrix(:,1), ptMatrix(:,2), ptMatrix(:,3), 'filled')
% xlabel('X');ylabel('Y');zlabel('Z')
% axis equal
% %
% figure(2)
% load PatchIndex_9.mat
% load PatchIndex.mat
% load PtMatrix_9.txt
%
% PatchOrder = PtMatrix_9(PatchIndex_9,:);
% hold on; trisurf(PatchIndex, PatchOrder(:,1), PatchOrder(:,2), PatchOrder(:,3)); axis equal




