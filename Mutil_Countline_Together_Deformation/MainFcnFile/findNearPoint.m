%%%  ----------------Robin-------------%%%
%%% ----------------20160301------------%%%
%%% ----------------swjtu_robin@foxmail.com------------%%%
%%% 在这个函数文件里，我们尽量
function nearPoint = findNearPoint(avePoint, externalPoint, subDivideValue)
%% subdivide the element between the near original popint of externalPoint martix 

[unitDisExtend, aveExtendLength] = disBound(externalPoint, subDivideValue);
subDividePoint = AvePoint(subDivideValue, externalPoint, unitDisExtend, aveExtendLength);   
nearPoint = zeros(size(avePoint,1),3);
parfor i = 1:size(avePoint,1)
    kdtree = createns(subDividePoint,'NSMethod','kdtree','Distance','euclidean');
    [index, ~] = knnsearch(kdtree, avePoint(i,:));
    nearPoint(i,:) =  subDividePoint(index,:);
end

% % % hold on;scatter3(nearPoint(:,1),nearPoint(:,2),nearPoint(:,3),'g*')



