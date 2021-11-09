%%%  ----------------Robin-------------%%%
%%% ----------------202160226------------%%%
%%% ----------------swjtu_robin@foxmail.com------------%%%
%%% Warning: 在这个函数中你可以得到均分点的坐标，还有与边界方向相平行的切线方向
function avePoint = AvePoint(aveValue, boundPointMatrix, unitDisBoundMatrix, aveLength )
% delta = 1/aveValue;                          %%  表示均分网格
% colinearTangent = zeros(aveValue+1,3);       %%  与边界方向相平行的切线方向
avePoint = zeros(aveValue+1,3);              %%  表示均分点的坐标
avePoint(1,:) = boundPointMatrix(1,:);       %%  边界点的首尾点是均分点
avePoint(end,:) = boundPointMatrix(end,:);
coefficient = zeros(aveValue-1,1) ;           %%  参数表示的是长度的比值，来算坐标点的比值
for multiple = 1:1: aveValue-1                %%  表示第几等分
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
