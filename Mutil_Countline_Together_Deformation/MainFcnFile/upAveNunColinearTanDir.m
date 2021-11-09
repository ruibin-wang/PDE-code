%%%%----------TO find the extern point of each boundary-------%%%
%%%%----------Robin--------------%%%
%%%----------20160301------------%%%
%%%----------Email:swjtu_robin@foxmail.com------------%%%
function aveTanDir = upAveNunColinearTanDir(aveValue, boundPointMatrix, unitDisBoundMatrix, aveLength, rightVertBoundMatrix,  nearPoint, transData, Vertices)
%%% Warning�����еĵ㶼�ǰ�����ʱ���˳����������еģ����Լ�������߷�����ʱ��������ϵ���������෴��
%%% ������ǻ���main�����������˵���͵���
% deltaU = 1/aveValue;
deltaV = 1/aveValue;
avePoint = zeros(aveValue+1,3);
avePoint(1,:) = boundPointMatrix(1,:);
avePoint(end,:) = boundPointMatrix(end,:);
innerPtBesideAveTanDir = zeros(aveValue-1,6); %%���ֵ������ԭʼ���ݵ㣬������ֵ������ֵ�����꣬1:3�з���ǰһ�����ݵ㣬4:6�з��þ��ֵ�ĺ�һ�����ݵ�  
innerAveTanPt = zeros(aveValue+1,3);    %% ָ�������ڲ�ľ��ֵ����߷����Ӧ�ĵ�
innerAveTanPt(1,:) = Vertices(transData(2,end),:);
innerAveTanPt(end,:) = Vertices(transData(2,1),:);


% outAveTanDir = zeros(aveValue,3);      %% ���ֵ�ָ�������������߷���

coefficient = zeros(aveValue-1,1) ;
for multiple = 1:1: aveValue-1
    for i = 1:size(unitDisBoundMatrix,1)-1
        if i == 1 && (aveLength * multiple) < unitDisBoundMatrix(i)
            avePoint(multiple+1,:) = boundPointMatrix(i,:) + ((aveLength * multiple)/unitDisBoundMatrix(i))*(boundPointMatrix(i+1,:) - boundPointMatrix(i,:));
            %%% �洢���ֵ������ԭʼ���ݵ�
            innerPtBesideAveTanDir(multiple+1,1:3) = rightVertBoundMatrix(end-1,:) - rightVertBoundMatrix(end,:);
            innerPtBesideAveTanDir(multiple+1,4:6) = Vertices(transData(2,end-1),:) - boundPointMatrix(i+1,:);
            %%% �ò�ֵ������ֵ�ָ�������ڲ�����߶�Ӧ�ĵ�
            innerAveTanPt(multiple+1,:) = avePoint(multiple+1,:) + (((aveLength * multiple)/unitDisBoundMatrix(i)) * innerPtBesideAveTanDir(multiple+1,4:6)+ ...
                + ((unitDisBoundMatrix(i)-aveLength * multiple)/unitDisBoundMatrix(i))*innerPtBesideAveTanDir(multiple+1,1:3));
            
        elseif (aveLength * multiple) > unitDisBoundMatrix(i) && (aveLength * multiple) < unitDisBoundMatrix(i+1)
            coefficient(multiple,1) = (aveLength * multiple - unitDisBoundMatrix(i,1))/(unitDisBoundMatrix(i+1,1) - unitDisBoundMatrix(i,1));
            avePoint(multiple+1,:) = boundPointMatrix(i+1,:) + coefficient(multiple,1) * (boundPointMatrix(i+2,:) - boundPointMatrix(i+1,:));%% A ratio relationship
            %%% �洢���ֵ������ԭʼ���ݵ�
            innerPtBesideAveTanDir(multiple+1,1:3) = Vertices(transData(2,end-i),:)-boundPointMatrix(i+1,:);
            innerPtBesideAveTanDir(multiple+1,4:6) = Vertices(transData(2,end-(i+1)),:) - boundPointMatrix(i+2,:);
            %%% �ò�ֵ������ֵ�ָ�������ڲ�����߶�Ӧ�ĵ�
            innerAveTanPt(multiple+1,:) = avePoint(multiple+1,:) + ((aveLength * multiple - unitDisBoundMatrix(i))* innerPtBesideAveTanDir(multiple+1,4:6)/Distance(boundPointMatrix,i+1,i+2)+ ...
                +(unitDisBoundMatrix(i+1) - aveLength * multiple)*innerPtBesideAveTanDir(multiple+1,1:3)/Distance(boundPointMatrix,i+1,i+2));
            
  
        elseif (aveLength * multiple) == unitDisBoundMatrix(i) 
            avePoint(multiple+1,:) = boundPointMatrix(i+1,:);
            innerAveTanPt(multiple+1,:) = Vertices(transData(2,end-i),:);
        end
    end
end
% hold on; scatter3(innerAveTanPt(:,1), innerAveTanPt(:,2), innerAveTanPt(:,3),'g*')
% hold on; scatter3(nearPoint(:,1), nearPoint(:,2), nearPoint(:,3),'b*')
%% �������ĺϳ�
aveTanDir = nearPoint - innerAveTanPt;
aveTanDir = aveTanDir/(2*deltaV);
