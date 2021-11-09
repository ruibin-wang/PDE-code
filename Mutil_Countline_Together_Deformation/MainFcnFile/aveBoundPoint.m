function avePoint = aveBoundPoint(Mesh_1,  sheet)
% aveDownBoundPoint, aveRightBoundPoint, aveUpBoundPoint, aveLeftBoundPoint,


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
[unitDisDownBound, aveDownBoundLength] = disBound(downBound, aveValue);
[unitDisRightBound, aveRightBoundLength] = disBound(rightBound, aveValue);
[unitDisUpBound, aveUpBoundLength] = disBound(upBound, aveValue);
[unitDisLeftBound, aveLeftBoundLength] = disBound(leftBound, aveValue);

%% 计算每条边上的均分点坐标，并且返回均分点与边界方向平行的切线方向
aveDownBoundPoint = AvePoint(aveValue, downBound, unitDisDownBound, aveDownBoundLength);
aveRightBoundPoint = AvePoint(aveValue, rightBound, unitDisRightBound, aveRightBoundLength);
aveUpBoundPoint = AvePoint(aveValue, upBound, unitDisUpBound, aveUpBoundLength);
aveLeftBoundPoint = AvePoint(aveValue, leftBound, unitDisLeftBound, aveLeftBoundLength);
avePoint = [aveDownBoundPoint; aveRightBoundPoint(2:1:end,:); aveUpBoundPoint(2:1:end,:); aveLeftBoundPoint(2:1:end-1,:)];