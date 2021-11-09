%%%%----------TO find the extern point of each boundary-------%%%
%%%%----------Robin--------------%%%
%%%----------20160229------------%%%
%%% Waring:When the first time you want to find the externalPoint ,you
%%% should take all the noted sign off ,and when you have got the
%%% externalPoint you should note some lines as it was before.
function [externalDownBound, externalLeftBound, externalUpBound, externalRightBound] = findExternalPoint
load Mesh_2.mat;
% % % rightFaceX = Mesh_2(:,1);   rightFaceY = Mesh_2(:,2);  rightFaceZ = Mesh_2(:,3) ;
% % % hold on;scatter3(rightFaceX,rightFaceY,rightFaceZ,'r .');
rightFaceTransData = xlsread('MeshIndex_2',1);    %%导入excel文件把数据做成一个矩阵
% % % rightFaceBoundWide = size(rightFaceTransData,1) ; %%矩阵的行
% % % rightFaceBoundLength = size(rightFaceTransData,2) ; %%矩阵的列
% % % 
% % % %% Find the extension point and put it in a matrix
% % % 
% % % rightFaceRightBound = Mesh_2(rightFaceTransData(:,1),:);   %%  先找到第一列的索引号，然后用索引号去找data中的具体点
% % % rightFaceLeftBound = Mesh_2(rightFaceTransData(:,rightFaceBoundLength),:);
% % % rightFaceUpBound = Mesh_2(rightFaceTransData(1,:),:);
% % % rightFaceDownBound = Mesh_2(rightFaceTransData(rightFaceBoundWide,:),:);
% % % 
% % % hold on;scatter3(rightFaceDownBound(:,1),rightFaceDownBound(:,2),rightFaceDownBound(:,3),'b*')

externalDownBound = Mesh_2(rightFaceTransData(2,:),:);
% % % hold on;scatter3(externalDownBound(:,1),externalDownBound(:,2),externalDownBound(:,3),'b*')
%% The boundary of upFace

load Mesh_3.mat;
% % % upFaceX = Mesh_3(:,1);   upFaceY = Mesh_3(:,2);  upFaceZ = Mesh_3(:,3) ;
% % % scatter3(upFaceX,upFaceY,upFaceZ,'r .');
% % % hold on;
upFaceTransData = xlsread('MeshIndex_3',1);    %%导入excel文件把数据做成一个矩阵
% % % upFaceBoundWide = size(upFaceTransData,1) ; %%矩阵的行
% % % upFaceBoundLength = size(upFaceTransData,2) ; %%矩阵的列
% % % 
% % % upFaceRightBound = Mesh_3(upFaceTransData(:,1),:);   %%  先找到第一列的索引号，然后用索引号去找data中的具体点
% % % upFaceLeftBound = Mesh_3(upFaceTransData(:,upFaceBoundLength),:);
% % % upFaceUpBound = Mesh_3(upFaceTransData(1,:),:);
% % % upFaceDownBound = Mesh_3(upFaceTransData(upFaceBoundWide,:),:);
% % % 
% % % hold on;scatter3(upFaceLeftBound(:,1),upFaceLeftBound(:,2),upFaceLeftBound(:,3),'b*')

externalRightBound = Mesh_3(upFaceTransData(:,2),:); 
% % % hold on;scatter3(externalRightBound(:,1),externalRightBound(:,2),externalRightBound(:,3),'b*')
%% The boundary of leftFace

load Mesh_4.mat;
% % % leftFaceX = Mesh_4(:,1);   leftFaceY = Mesh_4(:,2);  leftFaceZ = Mesh_4(:,3) ;
% % % scatter3(leftFaceX,leftFaceY,leftFaceZ,'r .');
% % % hold on;
leftFaceTransData = xlsread('MeshIndex_4',1);    %%导入excel文件把数据做成一个矩阵
leftFaceBoundWide = size(leftFaceTransData,1) ; %%矩阵的行
% % % leftFaceBoundLength = size(leftFaceTransData,2) ; %%矩阵的列
% % % leftFaceRightBound = Mesh_4(leftFaceTransData(:,1),:);   %%  先找到第一列的索引号，然后用索引号去找data中的具体点
% % % leftFaceLeftBound = Mesh_4(leftFaceTransData(:,leftFaceBoundLength),:);
% % % leftFaceUpBound = Mesh_4(leftFaceTransData(1,:),:);
% % % leftFaceDownBound = Mesh_4(leftFaceTransData(leftFaceBoundWide,:),:);

% % % hold on; scatter3(leftFaceDownBound(:,1),leftFaceDownBound(:,2),leftFaceDownBound(:,3),'b*')

externalUpBound = Mesh_4(leftFaceTransData(leftFaceBoundWide-1,:),:);
% % % hold on; scatter3(externalUpBound(:,1),externalUpBound(:,2),externalUpBound(:,3),'b*')
%% The boundary of downFace

load Mesh_5.mat;
% % % downFaceX = Mesh_5(:,1);   downFaceY = Mesh_5(:,2);  downFaceZ = Mesh_5(:,3) ;
% % % scatter3(downFaceX,downFaceY,downFaceZ,'r .');
% % % hold on;
downFaceTransData = xlsread('MeshIndex_5',1);    %%导入excel文件把数据做成一个矩阵
% % % downFaceBoundWide = size(downFaceTransData,1) ; %%矩阵的行
downFaceBoundLength = size(downFaceTransData,2) ; %%矩阵的列

% % % downFaceRightBound = Mesh_5(downFaceTransData(:,1),:);   %%  先找到第一列的索引号，然后用索引号去找data中的具体点
% % % downFaceLeftBound = Mesh_5(downFaceTransData(:,downFaceBoundLength),:);
% % % downFaceUpBound = Mesh_5(downFaceTransData(1,:),:);
% % % downFaceDownBound = Mesh_5(downFaceTransData(downFaceBoundWide,:),:);
% % % hold on;scatter3(downFaceRightBound(:,1),downFaceRightBound(:,2),downFaceRightBound(:,3),'b*')

externalLeftBound = Mesh_5(downFaceTransData(:,downFaceBoundLength-1),:);
% % % hold on;scatter3(externalLeftBound(:,1),externalLeftBound(:,2),externalLeftBound(:,3),'b*')
