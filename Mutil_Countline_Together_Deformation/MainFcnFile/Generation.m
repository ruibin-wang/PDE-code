% -------swjtu_robin@foxmail.com------%
% ------------20171213----------------%
% 该函数生成并且保存PDE计算曲面

function deformMeshPt = Generation(sheet, meshOrder, Para, deformAvePoint, aveTanDir, middleMesh, middleMeshNum, aveValue)

for index = 1:length(meshOrder)
    eval(['load', ' Mesh_', num2str(meshOrder(index)), '.mat']);
    eval(['Mesh', num2str(index), ' = Mesh_', num2str(meshOrder(1)), ';']);
    if index == 1
        eval(['load', ' avePoint_', num2str(sheet(1)), '.mat', ';']);
        eval(['load', ' aveTanDir_', num2str(sheet(1)), '.mat', ';']);
        
%         eval(['avePoint  = ', ' avePoint_', num2str(sheet(1)), ';']);
%         eval(['aveTanDir = ', ' aveTanDir_', num2str(sheet(1)), ';']);
    end
end

% [A, boundIndex, innerAvePt, alpha1, ~,noExPtMatrix,extractB] = bulidPDE(aveValue);

load bulidPdeNetWork.mat   %% 导入PDE方程的计算框架

meshIndex       =      xlsread('MeshIndex.xlsx', middleMeshNum);

%%

a1 = Para(1); a2 = Para(2);  a3 = Para(3);  %% PDE的三个参数
transMatrix     =    solvePDE(deformAvePoint, aveTanDir, A, boundIndex, ...
    innerAvePt, alpha1, noExPtMatrix, extractB, aveValue, a1, a2, a3);  %% 求解PDE曲面
transMatrixX    =    transMatrix{1};
transMatrixY    =    transMatrix{2};
transMatrixZ    =    transMatrix{3};
deformMeshPt    =    zeros(aveValue+1,aveValue+1,3);     %% 三维坐标系保存PDE解的三个维度值以及面片索引

PtMatrix = zeros(size(transMatrixX,1)*size(transMatrixX,2),3);  %% 把PDE三维数据转换成二维的矩阵

for i = 1:size(transMatrixX,1)
    for j = 1:size(transMatrixX,2)
        
        PtMatrix((i-1)*size(transMatrixX,2)+ j,1) = transMatrixX(i,j);
        PtMatrix((i-1)*size(transMatrixX,2)+ j,2) = transMatrixY(i,j);
        PtMatrix((i-1)*size(transMatrixX,2)+ j,3) = transMatrixZ(i,j);
        
        deformMeshPt(i,j,1) = transMatrixX(i,j);
        deformMeshPt(i,j,2) = transMatrixY(i,j);
        deformMeshPt(i,j,3) = transMatrixZ(i,j);
        
    end
end

%% 判断中心曲面的临近曲面

initAveMeshBound = aveBoundPoint(middleMesh, middleMeshNum);  %% 重新计算原始面片的边界均分点
[lackBound_1, lackBound_2, lackBound_3] = FindLackBound(initAveMeshBound, deformAvePoint); %% 计算中心曲面边界临近曲面的缺省情况

lackBoundSet        =       [lackBound_1, lackBound_2, lackBound_3];

if isempty(lackBoundSet) == 0
    
    switch lackBoundSet
        case 'Down'
            lackDownBound    =   findNearPoint(deformAvePoint(1:11,:), middleMesh(meshIndex(end,:),:), 100000);
            PtMatrix         =   [PtMatrix; lackDownBound];
            
        case 'Right'
            lackRightBound   =   findNearPoint(deformAvePoint(11:21,:), middleMesh(meshIndex(:,end),:), 100000);
            PtMatrix         =   [PtMatrix; lackRightBound];
            
        case 'Up'
            lackUpBound      =   findNearPoint(deformAvePoint(21:31,:), middleMesh(meshIndex(1,:),:), 100000);
            PtMatrix         =   [PtMatrix; lackUpBound];
            
        case 'Left'
            lackLeftBound    =   findNearPoint([deformAvePoint(31:40,:); deformAvePoint(1,:)], middleMesh(meshIndex(:,1),:), 100000);
            PtMatrix         =   [PtMatrix; lackLeftBound];
            
        case 'DownRight'
            lackDownBound    =   findNearPoint(deformAvePoint(1:11,:), middleMesh(meshIndex(end,:),:), 100000);
            lackRightBound   =   findNearPoint(deformAvePoint(11:21,:), middleMesh(meshIndex(:,end),:), 100000);
            lackBoundPoint   =   [lackDownBound; middleMesh(meshIndex(end,end),:); lackRightBound];
            PtMatrix         =   [PtMatrix; lackBoundPoint];
            
        case 'RightUp'
            lackRightBound   =   findNearPoint(deformAvePoint(11:21,:), middleMesh(meshIndex(:,end),:), 100000);
            lackUpBound      =   findNearPoint(deformAvePoint(21:31,:), middleMesh(meshIndex(1,:),:), 100000);
            lackBoundPoint   =   [lackRightBound; middleMesh(meshIndex(1,end),:); lackUpBound];
            PtMatrix         =   [PtMatrix; lackBoundPoint];
            
        case 'UpLeft'
            lackUpBound      =   findNearPoint(deformAvePoint(21:31,:), middleMesh(meshIndex(1,:),:), 100000);
            lackLeftBound    =   findNearPoint([deformAvePoint(31:40,:); deformAvePoint(1,:)], middleMesh(meshIndex(:,1),:), 100000);
            lackBoundPoint   =   [lackUpBound; middleMesh(meshIndex(1,1),:); lackLeftBound];
            PtMatrix         =   [PtMatrix; lackBoundPoint];
            
        case 'DownLeft'
            lackDownBound    =   findNearPoint(deformAvePoint(1:11,:), middleMesh(meshIndex(end,:),:), 100000);
            lackLeftBound    =   findNearPoint([deformAvePoint(31:40,:); deformAvePoint(1,:)], middleMesh(meshIndex(:,1),:), 100000);
            lackBoundPoint   =   [lackDownBound; middleMesh(meshIndex(end,1),:); lackLeftBound];
            PtMatrix         =   [PtMatrix; lackBoundPoint];
            
        case 'DownRightLeft'
            lackDownBound    =   findNearPoint(deformAvePoint(1:11,:), middleMesh(meshIndex(end,:),:), 100000);
            lackRightBound   =   findNearPoint(deformAvePoint(11:21,:), middleMesh(meshIndex(:,end),:), 100000);
            lackLeftBound    =   findNearPoint([deformAvePoint(31:40,:); deformAvePoint(1,:)], middleMesh(meshIndex(:,1),:), 100000);
            lackBoundPoint   =   [lackDownBound; middleMesh(meshIndex(end,end),:); lackRightBound; lackLeftBound; middleMesh(meshIndex(end,1),:)];
            PtMatrix         =   [PtMatrix; lackBoundPoint];
            
    end
end

%%  保存生成的二维矩阵数据

eval(['PtMatrix_', num2str(middleMeshNum), ' = ', 'PtMatrix', ';']);
eval(['save ', 'PtMatrix_', num2str(middleMeshNum),'.txt', ' PtMatrix_', num2str(middleMeshNum), ' -ascii', ';']);

%% draw the patch

% hold on; scatter3(PtMatrix(:,1), PtMatrix(:,2), PtMatrix(:,3), 'filled')
% 
% xlabel('X axis')
% ylabel('Y axis')
% zlabel('Z axis')

