%%%%----------TO solve the PDE using finite difference methord-------%%%
%%%%----------Robin--------------%%%
%%%----------20160316------------%%%
%%%----------Email:swjtu_robin@foxmail.com------------%%%
function [origVertAvePt,aveValue,avePoint,aveTanDir,minBondLength,X,Y,Z] = mainOutPut(Mesh_1, Mesh_2, Mesh_3, Mesh_4, Mesh_5, sheet)
X = Mesh_1(:,1);   Y = Mesh_1(:,2);  Z = Mesh_1(:,3) ;

transData = xlsread('MeshIndex', sheet(1));   %% ����������Ƭ�����������
%% �ҵ�������Ƭ�������߽�
%%%Ҫע���������������һ���Ǳ߽���˳��Ҫ���չ̶�����ʱ�����ţ�����һ���ǻ���ע�⣬�߽���ĸ�������ÿ�����ﶼ�У�Ҳ����˵�߽�
%%%�������غϣ����������Ҫע��
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


%% ����߽���ÿ����֮��ľ��룬�Լ��߽�ĳ���
%%% ����disBound����
aveValue = 10;  %% ���ֵ�����ǶԱ߽���о��ֵĵȷ�
[~, unitDisDownBound, downLength, aveDownBoundLength] = disBound(downBound, aveValue);
[~, unitDisRightBound, rightLength, aveRightBoundLength] = disBound(rightBound, aveValue);
[~, unitDisUpBound, upLength, aveUpBoundLength] = disBound(upBound, aveValue);
[~, unitDisLeftBound, leftLength, aveLeftBoundLength] = disBound(leftBound, aveValue);
boundLength = [downLength rightLength upLength leftLength];
minBondLength = min(boundLength);

%% ����ÿ�����ϵľ��ֵ����꣬���ҷ��ؾ��ֵ���߽緽��ƽ�е����߷���
aveDownBoundPoint = AvePoint(aveValue, downBound, unitDisDownBound, aveDownBoundLength);
aveRightBoundPoint = AvePoint(aveValue, rightBound, unitDisRightBound, aveRightBoundLength);
aveUpBoundPoint = AvePoint(aveValue, upBound, unitDisUpBound, aveUpBoundLength);
aveLeftBoundPoint = AvePoint(aveValue, leftBound, unitDisLeftBound, aveLeftBoundLength);
avePoint = [aveDownBoundPoint; aveRightBoundPoint(2:1:end,:); aveUpBoundPoint(2:1:end,:); aveLeftBoundPoint(2:1:end-1,:)];
eval(['avePoint_', num2str(sheet(1)), ' =  avePoint', ';' ]);
eval(['save', ' avePoint_', num2str(sheet(1)), '.mat', ' avePoint_', num2str(sheet(1)), ';']);


% % % hold on;scatter3(avePoint(:,1),avePoint(:,2),avePoint(:,3),'g*')
% % % hold on;plot3(avePoint(:,1),avePoint(:,2),avePoint(:,3),'b-')
%% �ҳ�ԭʼ�����ϵľ��ֵ�

horAvePoint = zeros(size(transData,1),aveValue + 1,3);    %% ˮƽ����ԭʼ���ݵ�ľ��ֵ㣬������һ����ά�������洢
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
origVertAvePt = zeros(aveValue+1,aveValue+1,3);         %%��ֱ����ˮƽ������ֵ�Ļ����ϣ���ǰ�����õľ��ֵ���о���
for i = 1:size(horAvePoint,2)
    [~, unitDisBound, ~, aveBoundLength] = disBound(horAvePoint(:,i,:), aveValue);
    origVertAvePt(:,i,:) = AvePoint(aveValue, horAvePoint(:,i,:), unitDisBound, aveBoundLength);
end

% % % for i = 1:(aveValue + 1)
% % %     for j = 1:(aveValue + 1)
% % %         hold on;scatter3(origVertAvePt(i,j,1),origVertAvePt(i,j,2),origVertAvePt(i,j,3),'b *')
% % %     end
% % % end

%% ����������Ƭ��Χ���ĸ���Ƭ��Ȼ���ҵ�������Ƭÿ���߽��Ӧ�����ص������
[externalDownBound, externalRightBound, externalUpBound, externalLeftBound] = externalPt(sheet,Mesh_1,Mesh_2,Mesh_3,Mesh_4,Mesh_5);


% % % externalPoint = [externalDownBound; externalRightBound; externalUpBound; externalLeftBound];
% % % hold on;scatter3(externalUpBound(1,1),externalUpBound(1,2),externalUpBound(1,3),'b*')
% % % hold on;plot3(externalPoint(:,1), externalPoint(:,2), externalPoint(:,3),'b-')  %% ����������˳���ǲ��ǰ�����ʱ�������



%% Ѱ�ұ߽���ÿ�����ֵ������ص��е������
divideValue = 100000;   %% ���ֵ�Ƕ����ص㹹�ɵı߽���о��ֵķ�����Ϊ��ʹ������Ӿ�ȷ������Ҫ���������ֵ���Ĵ�һЩ
downNearPoint = findNearPoint(aveDownBoundPoint, externalDownBound, divideValue);
rightNearPoint = findNearPoint(aveRightBoundPoint, externalRightBound, divideValue);
upNearPoint = findNearPoint(aveUpBoundPoint, externalUpBound, divideValue);
leftNearPoint = findNearPoint(aveLeftBoundPoint, externalLeftBound, divideValue);

%% ������ֵ�����ߵķ���

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



