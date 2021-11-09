function [externalDownBound, externalRightBound, externalUpBound, externalLeftBound] = externalPt(sheet,Mesh_1,Mesh_2,Mesh_3,Mesh_4,Mesh_5)
% % % load Mesh_1.mat
% % % load Mesh_2.mat
% % % load Mesh_3.mat
% % % load Mesh_4.mat
% % % load Mesh_5.mat
% % % sheet = [1 2 3 4 5];   表示的是excel表的第几个表格
% % % certainBound函数文件表示的是去找到没个面片的边界
MeshPt = struct;             %% 声明结构体
for i = 1:5
    MeshPt(i).TransData = xlsread('MeshIndex',sheet(i));
    varMesh = eval(['Mesh','_',num2str(i),';']);
    [MeshPt(i).DownBd, MeshPt(i).RightBd, MeshPt(i).UpBd, MeshPt(i).LeftBd] = certainBound( MeshPt(i).TransData, varMesh);
end
% % % extBound函数文件表示的是去遍历判断中心面片每条边在其他面片中的位置，并且返回中心面片边界对应的延拓点
externalDownBound    =  extBound(MeshPt(1).DownBd,MeshPt);
externalRightBound   =  extBound(MeshPt(1).RightBd,MeshPt);
externalUpBound      =  extBound(MeshPt(1).UpBd,MeshPt);
externalLeftBound    =  extBound(MeshPt(1).LeftBd,MeshPt);

% % % 把所有的点按照一个时针的方向排列起来
if floor(externalDownBound(end,:)) ~= floor(externalRightBound(1,:))
    externalRightBound = flipud(externalRightBound);
end
if floor(externalRightBound(end,:)) ~= floor(externalUpBound(1,:))
    externalUpBound = flipud(externalUpBound);
end
if floor(externalUpBound(end,:)) ~= floor(externalLeftBound(1,:))
    externalLeftBound = flipud(externalLeftBound);
end