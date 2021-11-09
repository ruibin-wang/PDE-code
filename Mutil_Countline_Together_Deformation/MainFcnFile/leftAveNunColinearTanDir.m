%%%%----------TO find the extern point of each boundary-------%%%
%%%%----------Robin--------------%%%
%%%----------20160301------------%%%
%%%----------Email:swjtu_robin@foxmail.com------------%%%
function aveTanDir = leftAveNunColinearTanDir(aveValue, boundPointMatrix, unitDisBoundMatrix, aveLength, upVertBoundMatrix,  nearPoint, transData, Vertices)
%%% Warning�����еĵ㶼�ǰ�����ʱ���˳����������еģ����Լ�������߷�����ʱ��������ϵ���������෴��
%%% ������ǻ���main�����������˵���͵���
deltaU = 1/aveValue;
% deltaV = 1/aveValue;
avePoint = zeros(aveValue+1,3);
avePoint(1,:) = boundPointMatrix(1,:);
avePoint(end,:) = boundPointMatrix(end,:);
innerPtBesideAveTanDir = zeros(aveValue-1,6);  %%���ֵ������ԭʼ���ݵ㣬������ֵ������ֵ�����꣬1:3�з���ǰһ�����ݵ㣬4:6�з��þ��ֵ�ĺ�һ�����ݵ�  
innerAveTanPt = zeros(aveValue+1,3);     %% ָ�������ڲ�ľ��ֵ����߷����Ӧ�ĵ�
innerAveTanPt(1,:) = Vertices(transData(1,2),:);
innerAveTanPt(end,:) = Vertices(transData(end,2),:);
% outAveTanDir = zeros(aveValue-1,3);       %% ���ֵ�ָ�������������߷���

coefficient = zeros(aveValue-1,1) ;
for multiple = 1:1: aveValue-1
    for i = 1:size(unitDisBoundMatrix,1)-1
        if i == 1 && (aveLength * multiple) < unitDisBoundMatrix(i)
            avePoint(multiple+1,:) = boundPointMatrix(i,:) + ((aveLength * multiple)/unitDisBoundMatrix(i))*(boundPointMatrix(i+1,:) - boundPointMatrix(i,:));
            %%% �洢���ֵ������ԭʼ���ݵ�
            innerPtBesideAveTanDir(multiple,1:3) = upVertBoundMatrix(end,:) - upVertBoundMatrix(end-1,:);
            innerPtBesideAveTanDir(multiple,4:6) = Vertices(transData(i+1,2),:) - boundPointMatrix(i+1,:);
            %%% �ò�ֵ������ֵ�ָ�������ڲ�����߶�Ӧ�ĵ�
            innerAveTanPt(multiple+1,:) = avePoint(multiple+1,:) + (((aveLength * multiple)/unitDisBoundMatrix(i)) * innerPtBesideAveTanDir(multiple,4:6) + ... 
                +((unitDisBoundMatrix(i)-aveLength * multiple)/unitDisBoundMatrix(i))*innerPtBesideAveTanDir(multiple,1:3));
            %%% AB = B - A   A = B - AB
        elseif (aveLength * multiple) > unitDisBoundMatrix(i) && (aveLength * multiple) < unitDisBoundMatrix(i+1)
            coefficient(multiple,1) = (aveLength * multiple - unitDisBoundMatrix(i,1))/(unitDisBoundMatrix(i+1,1) - unitDisBoundMatrix(i,1));
            avePoint(multiple+1,:) = boundPointMatrix(i+1,:) + coefficient(multiple,1) * (boundPointMatrix(i+2,:) - boundPointMatrix(i+1,:));%% A ratio relationship
            %%% �洢���ֵ������ԭʼ���ݵ�
            innerPtBesideAveTanDir(multiple,1:3) = Vertices(transData(i+1,2),:)-boundPointMatrix(i+1,:);
            innerPtBesideAveTanDir(multiple,4:6) = Vertices(transData(i+2,2),:)- boundPointMatrix(i+2,:);
            %%% �ò�ֵ������ֵ�ָ�������ڲ�����߶�Ӧ�ĵ�
            innerAveTanPt(multiple+1,:) = avePoint(multiple+1,:) + ((aveLength * multiple - unitDisBoundMatrix(i))* innerPtBesideAveTanDir(multiple,4:6)/Distance(boundPointMatrix,i+1,i+2)+ ... 
                +(unitDisBoundMatrix(i+1) - aveLength * multiple)*innerPtBesideAveTanDir(multiple,1:3)/Distance(boundPointMatrix,i+1,i+2));
            
  
        elseif (aveLength * multiple) == unitDisBoundMatrix(i) 
            avePoint(multiple+1,:) = boundPointMatrix(i+1,:);
            innerAveTanPt(multiple+1,:) = Vertices(transData(i+1,2),:);
        end
    end
end
% hold on; scatter3(innerAveTanPt(:,1), innerAveTanPt(:,2), innerAveTanPt(:,3),'g*')
% hold on; scatter3(nearPoint(:,1), nearPoint(:,2), nearPoint(:,3),'b*')
%% �������ĺϳ�
aveTanDir = innerAveTanPt - nearPoint;
aveTanDir = aveTanDir/(2*deltaU);