% -------swjtu_robin@foxmail.com------%
% ------------20171213----------------%
% 该函数生成并且保存PDE计算曲面

% function PtMatrix = DiffDirMiddleGeneration(sheet, meshOrder, Para, deformAvePoint, aveTanDir, middleMesh, middleMeshNum, aveValue)
function PtMatrix = DiffDirMiddleGeneration(Para, deformAvePoint, aveTanDir, middleMeshNum, aveValue)
% for index = 1:length(meshOrder)
%     eval(['load', ' Mesh_', num2str(meshOrder(index)), '.mat']);
%     eval(['Mesh', num2str(index), ' = Mesh_', num2str(meshOrder(1)), ';']);
%     if index == 1
%         eval(['load', ' avePoint_', num2str(sheet(1)), '.mat', ';']);
% %         eval(['load', ' aveTanDir_', num2str(sheet(1)), '.mat', ';']);
%         
% %         eval(['avePoint  = ', ' avePoint_', num2str(sheet(1)), ';']);
% %         eval(['aveTanDir = ', ' aveTanDir_', num2str(sheet(1)), ';']);
%     end
% end

% [A, boundIndex, innerAvePt, alpha1, ~,noExPtMatrix,extractB] = bulidPDE(aveValue);

load bulidPdeNetWork.mat   %% 导入PDE方程的计算框架

% meshIndex       =      xlsread('MeshIndex.xlsx', middleMeshNum);

%%

a1 = Para(1); a2 = Para(2);  a3 = Para(3);  %% PDE的三个参数
transMatrix     =    DiffDirSolvePDE(deformAvePoint, aveTanDir, A, boundIndex, ...
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

%%  保存生成的二维矩阵数据

eval(['PtMatrix_', num2str(middleMeshNum), ' = ', 'PtMatrix', ';']);
eval(['save ', 'PtMatrix_', num2str(middleMeshNum),'.txt', ' PtMatrix_', num2str(middleMeshNum), ' -ascii', ';']);

%% draw the patch

% hold on; scatter3(PtMatrix(:,1), PtMatrix(:,2), PtMatrix(:,3), 'filled')
 
% xlabel('X axis')
% ylabel('Y axis')
% zlabel('Z axis')

