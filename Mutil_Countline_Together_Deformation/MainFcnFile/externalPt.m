function [externalDownBound, externalRightBound, externalUpBound, externalLeftBound] = externalPt(sheet,Mesh_1,Mesh_2,Mesh_3,Mesh_4,Mesh_5)
% % % load Mesh_1.mat
% % % load Mesh_2.mat
% % % load Mesh_3.mat
% % % load Mesh_4.mat
% % % load Mesh_5.mat
% % % sheet = [1 2 3 4 5];   ��ʾ����excel��ĵڼ������
% % % certainBound�����ļ���ʾ����ȥ�ҵ�û����Ƭ�ı߽�
MeshPt = struct;             %% �����ṹ��
for i = 1:5
    MeshPt(i).TransData = xlsread('MeshIndex',sheet(i));
    varMesh = eval(['Mesh','_',num2str(i),';']);
    [MeshPt(i).DownBd, MeshPt(i).RightBd, MeshPt(i).UpBd, MeshPt(i).LeftBd] = certainBound( MeshPt(i).TransData, varMesh);
end
% % % extBound�����ļ���ʾ����ȥ�����ж�������Ƭÿ������������Ƭ�е�λ�ã����ҷ���������Ƭ�߽��Ӧ�����ص�
externalDownBound    =  extBound(MeshPt(1).DownBd,MeshPt);
externalRightBound   =  extBound(MeshPt(1).RightBd,MeshPt);
externalUpBound      =  extBound(MeshPt(1).UpBd,MeshPt);
externalLeftBound    =  extBound(MeshPt(1).LeftBd,MeshPt);

% % % �����еĵ㰴��һ��ʱ��ķ�����������
if floor(externalDownBound(end,:)) ~= floor(externalRightBound(1,:))
    externalRightBound = flipud(externalRightBound);
end
if floor(externalRightBound(end,:)) ~= floor(externalUpBound(1,:))
    externalUpBound = flipud(externalUpBound);
end
if floor(externalUpBound(end,:)) ~= floor(externalLeftBound(1,:))
    externalLeftBound = flipud(externalLeftBound);
end