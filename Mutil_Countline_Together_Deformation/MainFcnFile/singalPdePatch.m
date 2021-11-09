% -------swjtu_robin@foxmail.com------%
% ------------20171213----------------%

% �˺�����������PDE�������ݵ�
function halfTrainHead = singalPdePatch(middleMeshNum, deltT, DeformBoundIndex, Para, aveValue)

meshOrderSet    =      xlsread('meshOrderAndPdePara.xlsx',2);     %% ��Ƭ��ŵļ����������ݰ���������Ƭ��������Ƭ����Ƭ���
meshOrder       =      meshOrderSet(middleMeshNum, :);    %%   ������Ƭ����������Ƭ����
meshOrder(find(isnan(meshOrder))) = [];    %% ����û��������Ƭ�Ĳ����ÿ�
currentSheet    =      meshOrder;

eval(['load ', ' Mesh_', num2str(middleMeshNum), '.mat', ';']);   %% ����ԭʼ����
eval(['middleMesh = ', ' Mesh_', num2str(middleMeshNum), ';']);   

eval(['load', ' avePoint_', num2str(middleMeshNum), '.mat', ';']);  %%  ������Ƭ�ľ��ֱ߽�
eval(['avePoint =', ' avePoint_', num2str(currentSheet(1)), ';']);
eval(['load', ' aveTanDir_', num2str(middleMeshNum), '.mat', ';']);   %% ������ֱ߽��Ӧ������
eval(['boundTan =', ' aveTanDir_', num2str(currentSheet(1)), ';']);

%%  �α䷽���ȷ��
deformDirSet  =   cell(1,4);  %% �����α䷽�����渳ֵ

for indexI = 1:length(deformDirSet)
    deformDirSet{indexI} =  DeformBoundIndex{middleMeshNum, indexI + 1};  
end

currentDeformAvePoint  =      avePoint;  

%%  �����������Ƭ���ڵ���Ƭ
% ע�⣺���ֱ߽�������ֵҪ�Ⱦ��ֱ߽��ĸ���Ҫ�࣬��Ϊ�ڹյ㴦������������
% ע�⣺�������ұ߽���ж���MeshIndex���ݱ��У�������Ӧ��λ����ƥ��

for indexI = 1:length(deformDirSet)
    switch indexI
        case 1   %% 'Down' ���±߽�
            downAvePoint    =      avePoint(1:11,:);
            downDeltT       =      deltT(indexI);        %% �α���
            downDeformDir   =      deformDirSet{indexI};        %% �±߽���α䷽��
            downDeformBd    =      boundMotivation(downAvePoint, downDeformDir, downDeltT);   %%  �����α�ı߽�
            currentDeformAvePoint(1:11, :)  =  downDeformBd;
            downDeformDir   =      boundTan(1:11, :);
            downNeighbDeformMeshPt          =  getDeformMeshPt(middleMeshNum, downAvePoint, downDeformDir, downDeformBd, aveValue);   
            % �������α�֮���PDE�������ݣ�������Ϊ��ά����
            
            
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

%%  ���㵱ǰ������Ƭ��Ӧ��PDE��������

currentDeformMeshPt   =    MiddleGeneration(currentSheet, meshOrder, Para, currentDeformAvePoint, boundTan, middleMesh, middleMeshNum, aveValue);   %% three dimesional Matrix
% currentDeformMeshPt   =    Generation(currentSheet, meshOrder, Para, currentDeformAvePoint, boundTan, middleMesh, middleMeshNum, aveValue);   %% three dimesional Matrix

%%  �ϲ����е��������ݣ������ѱ��εģ�

halfTrainHead = [];

for middleMeshNum = 1:17
   
    eval(['load', ' PtMatrix_', num2str(middleMeshNum),'.txt']);
    eval(['halfTrainHead = [ halfTrainHead; ', 'PtMatrix_', num2str(middleMeshNum),']', ';']);
   
end

save halfTrainHead.txt halfTrainHead -ascii


