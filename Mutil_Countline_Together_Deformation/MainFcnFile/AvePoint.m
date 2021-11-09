%%%  ----------------Robin-------------%%%
%%% ----------------202160226------------%%%
%%% ----------------swjtu_robin@foxmail.com------------%%%
%%% Warning: ���������������Եõ����ֵ�����꣬������߽緽����ƽ�е����߷���
function avePoint = AvePoint(aveValue, boundPointMatrix, unitDisBoundMatrix, aveLength )
% delta = 1/aveValue;                          %%  ��ʾ��������
% colinearTangent = zeros(aveValue+1,3);       %%  ��߽緽����ƽ�е����߷���
avePoint = zeros(aveValue+1,3);              %%  ��ʾ���ֵ������
avePoint(1,:) = boundPointMatrix(1,:);       %%  �߽�����β���Ǿ��ֵ�
avePoint(end,:) = boundPointMatrix(end,:);
coefficient = zeros(aveValue-1,1) ;           %%  ������ʾ���ǳ��ȵı�ֵ�����������ı�ֵ
for multiple = 1:1: aveValue-1                %%  ��ʾ�ڼ��ȷ�
    for i = 1:size(unitDisBoundMatrix,1)-1
        if i == 1 && (aveLength * multiple) < unitDisBoundMatrix(i)
            avePoint(multiple+1,:) = boundPointMatrix(i,:) + ((aveLength * multiple)/unitDisBoundMatrix(i))*(boundPointMatrix(i+1,:) - boundPointMatrix(i,:));
       elseif (aveLength * multiple) > unitDisBoundMatrix(i) && (aveLength * multiple) < unitDisBoundMatrix(i+1)
            coefficient(multiple,1) = (aveLength * multiple - unitDisBoundMatrix(i,1))/(unitDisBoundMatrix(i+1,1) - unitDisBoundMatrix(i,1)) ;
            avePoint(multiple+1,:) = boundPointMatrix(i+1,:) + coefficient(multiple,1) * (boundPointMatrix(i+2,:) - boundPointMatrix(i+1,:));%% A ratio relationship            
        elseif (aveLength * multiple) == unitDisBoundMatrix(i)
            avePoint(multiple+1,:) = boundPointMatrix(i+1,:);
        end
        
    end
end
