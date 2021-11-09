function avePoint = aveBoundPoint(Mesh_1,  sheet)
% aveDownBoundPoint, aveRightBoundPoint, aveUpBoundPoint, aveLeftBoundPoint,


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
[unitDisDownBound, aveDownBoundLength] = disBound(downBound, aveValue);
[unitDisRightBound, aveRightBoundLength] = disBound(rightBound, aveValue);
[unitDisUpBound, aveUpBoundLength] = disBound(upBound, aveValue);
[unitDisLeftBound, aveLeftBoundLength] = disBound(leftBound, aveValue);

%% ����ÿ�����ϵľ��ֵ����꣬���ҷ��ؾ��ֵ���߽緽��ƽ�е����߷���
aveDownBoundPoint = AvePoint(aveValue, downBound, unitDisDownBound, aveDownBoundLength);
aveRightBoundPoint = AvePoint(aveValue, rightBound, unitDisRightBound, aveRightBoundLength);
aveUpBoundPoint = AvePoint(aveValue, upBound, unitDisUpBound, aveUpBoundLength);
aveLeftBoundPoint = AvePoint(aveValue, leftBound, unitDisLeftBound, aveLeftBoundLength);
avePoint = [aveDownBoundPoint; aveRightBoundPoint(2:1:end,:); aveUpBoundPoint(2:1:end,:); aveLeftBoundPoint(2:1:end-1,:)];