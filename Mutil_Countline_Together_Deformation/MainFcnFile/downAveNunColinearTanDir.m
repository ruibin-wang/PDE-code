%%%%----------TO find the extern point of each boundary-------%%%
%%%%----------Robin--------------%%%
%%%----------20160301------------%%%
%%%----------Email:swjtu_robin@foxmail.com------------%%%
function aveTanDir = downAveNunColinearTanDir(aveValue, boundPointMatrix, unitDisBoundMatrix, aveLength, leftVertBoundMatrix,  nearPoint, transData, Vertices)
%%% Warning：所有的点都是按照逆时针的顺序运算和排列的，所以计算的切线方向有时候会和坐标系的正方向相反，
%%% 这个我们会在main函数里面进行说明和调整
% deltaU = 1/aveValue;
deltaV = 1/aveValue;
avePoint = zeros(aveValue+1,3);
avePoint(1,:) = boundPointMatrix(1,:);
avePoint(end,:) = boundPointMatrix(end,:);
innerPtBesideAveTanDir = zeros(aveValue-1,6);  %%均分点两侧的原始数据点，用来插值插出均分点的坐标，1:3列放置前一个数据点，4:6列放置均分点的后一个数据点  
innerAveTanPt = zeros(aveValue+1,3);     %% 指向曲面内侧的均分点切线方向对应的点
%%%因为边界的四个顶点是两条边界的交汇，而且还跟延拓点有关系，所以顶点要单独处理
innerAveTanPt(1,:) = Vertices(transData(size(transData,1)-1,1),:);
innerAveTanPt(end,:) = Vertices(transData(size(transData,1)-1,end),:);
%%% 测试点的位置
% scatter3(Vertices(transData(size(transData,1)-1,end),1), Vertices(transData(size(transData,1)-1,end),2), Vertices(transData(size(transData,1)-1,end),3), 'b*')
% hold on
% outAveTanDir = zeros(aveValue+1,3);       %% 均分点指向曲面外侧的切线方向

coefficient = zeros(aveValue-1,1) ;
for multiple = 1:1: aveValue-1
    for i = 1:size(unitDisBoundMatrix,1)-1
        if i == 1 && (aveLength * multiple) < unitDisBoundMatrix(i)
            avePoint(multiple+1,:) = boundPointMatrix(i,:) + ((aveLength * multiple)/unitDisBoundMatrix(i))*(boundPointMatrix(i+1,:) - boundPointMatrix(i,:));
            %%% 存储均分点两侧的原始数据点
            innerPtBesideAveTanDir(multiple+1,1:3) = leftVertBoundMatrix(end-1,:) - leftVertBoundMatrix(end,:);
            innerPtBesideAveTanDir(multiple+1,4:6) = Vertices(transData(size(transData,1)-1,i+1),:) - boundPointMatrix(i+1,:);
            %%% 用插值插出均分点指向曲面内侧的切线对应的点
            innerAveTanPt(multiple+1,:) = avePoint(multiple+1,:) + (((aveLength * multiple)/unitDisBoundMatrix(i)) * innerPtBesideAveTanDir(multiple+1,4:6) + ...
                +((unitDisBoundMatrix(i)-aveLength * multiple)/unitDisBoundMatrix(i))*innerPtBesideAveTanDir(multiple+1,1:3));
            %%% AB = B - A   A = B - AB
        elseif (aveLength * multiple) > unitDisBoundMatrix(i) && (aveLength * multiple) < unitDisBoundMatrix(i+1)
            coefficient(multiple,1) = (aveLength * multiple - unitDisBoundMatrix(i,1))/(unitDisBoundMatrix(i+1,1) - unitDisBoundMatrix(i,1));
            avePoint(multiple+1,:) = boundPointMatrix(i+1,:) + coefficient(multiple,1) * (boundPointMatrix(i+2,:) - boundPointMatrix(i+1,:));%% A ratio relationship
            %%% 存储均分点两侧的原始数据点
            innerPtBesideAveTanDir(multiple+1,1:3) = Vertices(transData(size(transData,1)-1,i+1),:)-boundPointMatrix(i+1,:);
            innerPtBesideAveTanDir(multiple+1,4:6) = Vertices(transData(size(transData,1)-1,i+2),:) - boundPointMatrix(i+2,:);
            %%% 用插值插出均分点指向曲面内侧的切线对应的点
            innerAveTanPt(multiple+1,:) = avePoint(multiple+1,:) + ((aveLength * multiple - unitDisBoundMatrix(i))* innerPtBesideAveTanDir(multiple+1,4:6)/Distance(boundPointMatrix,i+1,i+2)+ ...
                + (unitDisBoundMatrix(i+1) - aveLength * multiple)*innerPtBesideAveTanDir(multiple+1,1:3)/Distance(boundPointMatrix,i+1,i+2));
            
  
        elseif (aveLength * multiple) == unitDisBoundMatrix(i) 
            avePoint(multiple+1,:) = boundPointMatrix(i+1,:);
            innerAveTanPt(multiple+1,:) = Vertices(transData(size(transData,1)-1,i+1),:);
        end
    end
end

%  hold on; scatter3(innerAveTanPt(:,1), innerAveTanPt(:,2), innerAveTanPt(:,3),'g *')
% hold on; scatter3(nearPoint(:,1), nearPoint(:,2), nearPoint(:,3),'b *')
%% 切向量的合成
aveTanDir = innerAveTanPt - nearPoint;
% Matrix = [innerAveTanPt;innerAveTanPt];
% for i = 1:length(Matrix)-1
%     x = [Matrix(i,1),Matrix(i+1,1)];
%     y = [Matrix(i,2),Matrix(i+1,2)];
%     z = [Matrix(i,3),Matrix(i+1,3)];
%     plot3(x,y,z,'b-')
%     grid on;
%     i = i + 1;
% end
aveTanDir = aveTanDir/(2*deltaV);