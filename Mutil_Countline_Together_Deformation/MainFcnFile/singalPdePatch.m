% -------swjtu_robin@foxmail.com------%
% ------------20171213----------------%

% 此函数用于生成PDE曲面数据点
function halfTrainHead = singalPdePatch(middleMeshNum, deltT, DeformBoundIndex, Para, aveValue)

meshOrderSet    =      xlsread('meshOrderAndPdePara.xlsx',2);     %% 面片编号的检索，该数据包含中心面片和相邻面片的面片编号
meshOrder       =      meshOrderSet(middleMeshNum, :);    %%   中心面片及其相邻面片序列
meshOrder(find(isnan(meshOrder))) = [];    %% 对于没有相邻面片的部分置空
currentSheet    =      meshOrder;

eval(['load ', ' Mesh_', num2str(middleMeshNum), '.mat', ';']);   %% 导入原始数据
eval(['middleMesh = ', ' Mesh_', num2str(middleMeshNum), ';']);   

eval(['load', ' avePoint_', num2str(middleMeshNum), '.mat', ';']);  %%  导入面片的均分边界
eval(['avePoint =', ' avePoint_', num2str(currentSheet(1)), ';']);
eval(['load', ' aveTanDir_', num2str(middleMeshNum), '.mat', ';']);   %% 导入均分边界对应的切线
eval(['boundTan =', ' aveTanDir_', num2str(currentSheet(1)), ';']);

%%  形变方向的确定
deformDirSet  =   cell(1,4);  %% 定义形变方向，下面赋值

for indexI = 1:length(deformDirSet)
    deformDirSet{indexI} =  DeformBoundIndex{middleMeshNum, indexI + 1};  
end

currentDeformAvePoint  =      avePoint;  

%%  计算和中心面片相邻的面片
% 注意：均分边界点的切线值要比均分边界点的个数要多，因为在拐点处，有两个切线
% 注意：上下左右边界的判断与MeshIndex数据表中，检索对应的位置相匹配

for indexI = 1:length(deformDirSet)
    switch indexI
        case 1   %% 'Down' 即下边界
            downAvePoint    =      avePoint(1:11,:);
            downDeltT       =      deltT(indexI);        %% 形变量
            downDeformDir   =      deformDirSet{indexI};        %% 下边界的形变方向
            downDeformBd    =      boundMotivation(downAvePoint, downDeformDir, downDeltT);   %%  返回形变的边界
            currentDeformAvePoint(1:11, :)  =  downDeformBd;
            downDeformDir   =      boundTan(1:11, :);
            downNeighbDeformMeshPt          =  getDeformMeshPt(middleMeshNum, downAvePoint, downDeformDir, downDeformBd, aveValue);   
            % 计算获得形变之后的PDE曲面数据，该数据为三维矩阵
            
            
        case 2  %%  'Right'
            rightAvePoint   =      avePoint(11:21,:);
            rightDeltT      =      deltT(indexI);        %% level of the deformation
            rightDeformDir  =      deformDirSet{indexI};        %% direction of the deformation
            rightDeformBd   =      boundMotivation(rightAvePoint, rightDeformDir, rightDeltT);   %%  return the deformed boundary points
            currentDeformAvePoint(11:21, :)  =  rightDeformBd;
            rightDeformDir  =      boundTan(12:22, :);
            rightNeighbDeformMeshPt          =  getDeformMeshPt(middleMeshNum, rightAvePoint, rightDeformDir, rightDeformBd, aveValue);   %% get the deformation of the neighbour mesh
            
            
        case 3  %%  'Up'
            upAvePoint      =      avePoint(21:31,:);
            upDeltT         =      deltT(indexI);        %% level of the deformation
            upDeformDir     =      deformDirSet{indexI};        %% direction of the deformation
            upDeformBd      =      boundMotivation(upAvePoint, upDeformDir, upDeltT);   %%  return the deformed boundary points
            currentDeformAvePoint(21:31, :)  =  upDeformBd;
            upDeformDir     =      boundTan(23:33, :);
            upNeighbDeformMeshPt             =  getDeformMeshPt(middleMeshNum, upAvePoint, upDeformDir, upDeformBd, aveValue);   %% get the deformation of the neighbour mesh
            
            
        case 4   %%  'Left'
            leftAvePoint    =      [avePoint(31:40,:); avePoint(1,:)];
            leftDeltT       =      deltT(indexI);        %% level of the deformation
            leftDeformDir   =      deformDirSet{indexI};        %% direction of the deformation
            leftDeformBd    =      boundMotivation(leftAvePoint, leftDeformDir, leftDeltT);   %%  return the deformed boundary points
            currentDeformAvePoint(31:40, :)  =  leftDeformBd(1:end-1, :);  %% the last point of this boundary is the same as the first one of the avePoint
            leftDeformDir   =      boundTan(34:44, :);
            leftNeighbDeformMeshPt           =  getDeformMeshPt(middleMeshNum, leftAvePoint, leftDeformDir, leftDeformBd, aveValue);   %% get the deformation of the neighbour mesh
            
    end
end

%%  计算当前中心面片对应的PDE曲面数据

currentDeformMeshPt   =    MiddleGeneration(currentSheet, meshOrder, Para, currentDeformAvePoint, boundTan, middleMesh, middleMeshNum, aveValue);   %% three dimesional Matrix
% currentDeformMeshPt   =    Generation(currentSheet, meshOrder, Para, currentDeformAvePoint, boundTan, middleMesh, middleMeshNum, aveValue);   %% three dimesional Matrix

%%  合并所有的曲面数据（包含已变形的）

halfTrainHead = [];

for middleMeshNum = 1:17
   
    eval(['load', ' PtMatrix_', num2str(middleMeshNum),'.txt']);
    eval(['halfTrainHead = [ halfTrainHead; ', 'PtMatrix_', num2str(middleMeshNum),']', ';']);
   
end

save halfTrainHead.txt halfTrainHead -ascii


