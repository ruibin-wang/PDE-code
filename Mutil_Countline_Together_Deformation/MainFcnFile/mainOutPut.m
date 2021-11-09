%%%%----------TO solve the PDE using finite difference methord-------%%%
%%%%----------Robin--------------%%%
%%%----------20160316------------%%%
%%%----------Email:swjtu_robin@foxmail.com------------%%%
function [origVertAvePt,aveValue,avePoint,aveTanDir,minBondLength,X,Y,Z] = mainOutPut(Mesh_1, Mesh_2, Mesh_3, Mesh_4, Mesh_5, sheet)
X = Mesh_1(:,1);   Y = Mesh_1(:,2);  Z = Mesh_1(:,3) ;

transData = xlsread('MeshIndex', sheet(1));   %% 读入中心面片坐标的索引号
%% 找到中心面片的四条边界
%%%要注意的问题有两个，一个是边界点的顺序要按照固定的逆时针来排，另外一个是还得注意，边界的四个顶点在每条边里都有，也就是说边界
%%%顶点有重合，这个到后面要注意
[downBound, rightBound, upBound, leftBound] = certainBound(transData,Mesh_1);
if downBound(end,:) ~= rightBound(1,:) 
    rightBound = flipud(rightBound);
end
if rightBound(end,:) ~= upBound(1,:) 
    upBound = flipud(upBound);
end
if upBound(end,:) ~= leftBound(1,:) 
    leftBound = flipud(leftBound);
end


% % % totalBoundary = [downBound; rightBound; upBound; leftBound];
% % % hold on;plot3(totalBoundary(:,1),totalBoundary(:,2),totalBoundary(:,3),'b-')


%% 计算边界上每个点之间的距离，以及边界的长度
%%% 调用disBound函数
aveValue = 10;  %% 这个值是我们对边界进行均分的等分
[~, unitDisDownBound, downLength, aveDownBoundLength] = disBound(downBound, aveValue);
[~, unitDisRightBound, rightLength, aveRightBoundLength] = disBound(rightBound, aveValue);
[~, unitDisUpBound, upLength, aveUpBoundLength] = disBound(upBound, aveValue);
[~, unitDisLeftBound, leftLength, aveLeftBoundLength] = disBound(leftBound, aveValue);
boundLength = [downLength rightLength upLength leftLength];
minBondLength = min(boundLength);

%% 计算每条边上的均分点坐标，并且返回均分点与边界方向平行的切线方向
aveDownBoundPoint = AvePoint(aveValue, downBound, unitDisDownBound, aveDownBoundLength);
aveRightBoundPoint = AvePoint(aveValue, rightBound, unitDisRightBound, aveRightBoundLength);
aveUpBoundPoint = AvePoint(aveValue, upBound, unitDisUpBound, aveUpBoundLength);
aveLeftBoundPoint = AvePoint(aveValue, leftBound, unitDisLeftBound, aveLeftBoundLength);
avePoint = [aveDownBoundPoint; aveRightBoundPoint(2:1:end,:); aveUpBoundPoint(2:1:end,:); aveLeftBoundPoint(2:1:end-1,:)];
eval(['avePoint_', num2str(sheet(1)), ' =  avePoint', ';' ]);
eval(['save', ' avePoint_', num2str(sheet(1)), '.mat', ' avePoint_', num2str(sheet(1)), ';']);


% % % hold on;scatter3(avePoint(:,1),avePoint(:,2),avePoint(:,3),'g*')
% % % hold on;plot3(avePoint(:,1),avePoint(:,2),avePoint(:,3),'b-')
%% 找出原始曲面上的均分点

horAvePoint = zeros(size(transData,1),aveValue + 1,3);    %% 水平方向原始数据点的均分点，我们用一个三维矩阵来存储
for i = 1:size(transData,1)
    [~, unitDisBound, ~, aveBoundLength] = disBound(Mesh_1(transData(i,:),:), aveValue);
    horAvePoint(i,:,:) = AvePoint(aveValue, Mesh_1(transData(i,:),:), unitDisBound, aveBoundLength);
    %avePoint(i,:,:) = transAvePt;
end

%{
% % % hold on;scatter3(x,y,z,'r .')
% % % for i = 1:size(transData,1)
% % %     for j = 1:(aveValue + 1)
% % %         hold on;scatter3(horAvePoint(i,j,1),horAvePoint(i,j,2),horAvePoint(i,j,3),'g *')
% % %     end
% % % end


% % % scatter3(reshape(horAvePoint(:,:,1),size(horAvePoint,1)*size(horAvePoint,2),1),...
% % %     reshape(horAvePoint(:,:,2),size(horAvePoint,1)*size(horAvePoint,2),1), ...
% % %     reshape(horAvePoint(:,:,3),size(horAvePoint,1)*size(horAvePoint,2),1),'r o')
%}
origVertAvePt = zeros(aveValue+1,aveValue+1,3);         %%垂直方向，水平方向均分点的基础上，对前面所得的均分点进行均分
for i = 1:size(horAvePoint,2)
    [~, unitDisBound, ~, aveBoundLength] = disBound(horAvePoint(:,i,:), aveValue);
    origVertAvePt(:,i,:) = AvePoint(aveValue, horAvePoint(:,i,:), unitDisBound, aveBoundLength);
end

% % % for i = 1:(aveValue + 1)
% % %     for j = 1:(aveValue + 1)
% % %         hold on;scatter3(origVertAvePt(i,j,1),origVertAvePt(i,j,2),origVertAvePt(i,j,3),'b *')
% % %     end
% % % end

%% 导入中心面片周围的四个面片，然后找到中心面片每条边界对应的延拓点的坐标
[externalDownBound, externalRightBound, externalUpBound, externalLeftBound] = externalPt(sheet,Mesh_1,Mesh_2,Mesh_3,Mesh_4,Mesh_5);


% % % externalPoint = [externalDownBound; externalRightBound; externalUpBound; externalLeftBound];
% % % hold on;scatter3(externalUpBound(1,1),externalUpBound(1,2),externalUpBound(1,3),'b*')
% % % hold on;plot3(externalPoint(:,1), externalPoint(:,2), externalPoint(:,3),'b-')  %% 测试输出点的顺序是不是按照逆时针排序的



%% 寻找边界上每个均分点在延拓点中的最近点
divideValue = 100000;   %% 这个值是对延拓点构成的边界进行均分的份数，为了使结果更加精确，我们要尽量把这个值做的大一些
downNearPoint = findNearPoint(aveDownBoundPoint, externalDownBound, divideValue);
rightNearPoint = findNearPoint(aveRightBoundPoint, externalRightBound, divideValue);
upNearPoint = findNearPoint(aveUpBoundPoint, externalUpBound, divideValue);
leftNearPoint = findNearPoint(aveLeftBoundPoint, externalLeftBound, divideValue);

%% 计算均分点的切线的方向

downAveTanDirV = downAveNunColinearTanDir(aveValue, downBound, unitDisDownBound, aveDownBoundLength, leftBound,  downNearPoint, transData, Mesh_1);
rightAveTanDirU = rightAveNunColinearTanDir(aveValue, rightBound, unitDisRightBound, aveRightBoundLength, downBound,  rightNearPoint, transData, Mesh_1);
upAveTanDirV = upAveNunColinearTanDir(aveValue, upBound, unitDisUpBound, aveUpBoundLength, rightBound,  upNearPoint, transData, Mesh_1);
leftAveTanDirU = leftAveNunColinearTanDir(aveValue, leftBound, unitDisLeftBound, aveLeftBoundLength, upBound,  leftNearPoint, transData, Mesh_1);
aveTanDir = [downAveTanDirV; rightAveTanDirU; upAveTanDirV; leftAveTanDirU];

eval(['aveTanDir_', num2str(sheet(1)), ' =  aveTanDir', ';' ]);
eval(['save', ' aveTanDir_', num2str(sheet(1)), '.mat', ' aveTanDir_', num2str(sheet(1)), ';']);



eval(['avePoint_', num2str(sheet(1)), ' =  avePoint', ';' ]);
eval(['save', ' avePoint_', num2str(sheet(1)), '.mat', ' avePoint_', num2str(sheet(1)), ';']);
eval(['aveTanDir_', num2str(sheet(1)), ' =  aveTanDir', ';' ]);
eval(['save', ' aveTanDir_', num2str(sheet(1)), '.mat', ' aveTanDir_', num2str(sheet(1)), ';']);



