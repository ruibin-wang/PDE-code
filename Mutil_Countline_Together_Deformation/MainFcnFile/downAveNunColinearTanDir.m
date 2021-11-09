%%%%----------TO find the extern point of each boundary-------%%%
%%%%----------Robin--------------%%%
%%%----------20160301------------%%%
%%%----------Email:swjtu_robin@foxmail.com------------%%%
function aveTanDir = downAveNunColinearTanDir(aveValue, boundPointMatrix, unitDisBoundMatrix, aveLength, leftVertBoundMatrix,  nearPoint, transData, Vertices)
%%% Warning�����еĵ㶼�ǰ�����ʱ���˳����������еģ����Լ�������߷�����ʱ��������ϵ���������෴��
%%% ������ǻ���main�����������˵���͵���
% deltaU = 1/aveValue;
deltaV = 1/aveValue;
avePoint = zeros(aveValue+1,3);
avePoint(1,:) = boundPointMatrix(1,:);
avePoint(end,:) = boundPointMatrix(end,:);
innerPtBesideAveTanDir = zeros(aveValue-1,6);  %%���ֵ������ԭʼ���ݵ㣬������ֵ������ֵ�����꣬1:3�з���ǰһ�����ݵ㣬4:6�з��þ��ֵ�ĺ�һ�����ݵ�  
innerAveTanPt = zeros(aveValue+1,3);     %% ָ�������ڲ�ľ��ֵ����߷����Ӧ�ĵ�
%%%��Ϊ�߽���ĸ������������߽�Ľ��㣬���һ������ص��й�ϵ�����Զ���Ҫ��������
innerAveTanPt(1,:) = Vertices(transData(size(transData,1)-1,1),:);
innerAveTanPt(end,:) = Vertices(transData(size(transData,1)-1,end),:);
%%% ���Ե��λ��
% scatter3(Vertices(transData(size(transData,1)-1,end),1), Vertices(transData(size(transData,1)-1,end),2), Vertices(transData(size(transData,1)-1,end),3), 'b*')
% hold on
% outAveTanDir = zeros(aveValue+1,3);       %% ���ֵ�ָ�������������߷���

coefficient = zeros(aveValue-1,1) ;
for multiple = 1:1: aveValue-1
    for i = 1:size(unitDisBoundMatrix,1)-1
        if i == 1 && (aveLength * multiple) < unitDisBoundMatrix(i)
            avePoint(multiple+1,:) = boundPointMatrix(i,:) + ((aveLength * multiple)/unitDisBoundMatrix(i))*(boundPointMatrix(i+1,:) - boundPointMatrix(i,:));
            %%% �洢���ֵ������ԭʼ���ݵ�
            innerPtBesideAveTanDir(multiple+1,1:3) = leftVertBoundMatrix(end-1,:) - leftVertBoundMatrix(end,:);
            innerPtBesideAveTanDir(multiple+1,4:6) = Vertices(transData(size(transData,1)-1,i+1),:) - boundPointMatrix(i+1,:);
            %%% �ò�ֵ������ֵ�ָ�������ڲ�����߶�Ӧ�ĵ�
            innerAveTanPt(multiple+1,:) = avePoint(multiple+1,:) + (((aveLength * multiple)/unitDisBoundMatrix(i)) * innerPtBesideAveTanDir(multiple+1,4:6) + ...
                +((unitDisBoundMatrix(i)-aveLength * multiple)/unitDisBoundMatrix(i))*innerPtBesideAveTanDir(multiple+1,1:3));
            %%% AB = B - A   A = B - AB
        elseif (aveLength * multiple) > unitDisBoundMatrix(i) && (aveLength * multiple) < unitDisBoundMatrix(i+1)
            coefficient(multiple,1) = (aveLength * multiple - unitDisBoundMatrix(i,1))/(unitDisBoundMatrix(i+1,1) - unitDisBoundMatrix(i,1));
            avePoint(multiple+1,:) = boundPointMatrix(i+1,:) + coefficient(multiple,1) * (boundPointMatrix(i+2,:) - boundPointMatrix(i+1,:));%% A ratio relationship
            %%% �洢���ֵ������ԭʼ���ݵ�
            innerPtBesideAveTanDir(multiple+1,1:3) = Vertices(transData(size(transData,1)-1,i+1),:)-boundPointMatrix(i+1,:);
            innerPtBesideAveTanDir(multiple+1,4:6) = Vertices(transData(size(transData,1)-1,i+2),:) - boundPointMatrix(i+2,:);
            %%% �ò�ֵ������ֵ�ָ�������ڲ�����߶�Ӧ�ĵ�
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
%% �������ĺϳ�
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