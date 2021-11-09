%%% 该函数的目的在于修正边界切线，使之通用

function adjustedBdTanDir = BdTanAdjust(boundTan, avePoint)

%%%% 边界绕坐标轴旋转
downTanDir             =    boundTan(1:11,:);
rightTanDir            =    boundTan(12:22,:);
upTanDir               =    boundTan(23:33,:);
leftTanDir             =    boundTan(34:44,:);


%%% 先单位化，然后乘以边界点之间的间距，逼近真实边界切线

for indexI = 1:size(downTanDir, 2)
    downTanDir(:,indexI) = (downTanDir(:,indexI)/norm(downTanDir(:,indexI)))* ...
                           ((norm(avePoint(end,:)-avePoint(1,:)) + norm(avePoint(12,:)-avePoint(11,:)))*2);
end

for indexI = 1:size(rightTanDir, 2)
    rightTanDir(:,indexI) = (rightTanDir(:,indexI)/norm(rightTanDir(:,indexI)))* ...
                           ((norm(avePoint(10,:)-avePoint(11,:)) + norm(avePoint(22,:)-avePoint(21,:)))*2);
end

for indexI = 1:size(upTanDir, 2)
    upTanDir(:,indexI) = (upTanDir(:,indexI)/norm(upTanDir(:,indexI)))* ...
                           ((norm(avePoint(20,:)-avePoint(21,:)) + norm(avePoint(32,:)-avePoint(31,:)))*2);
end

for indexI = 1:size(leftTanDir, 2)
    leftTanDir(:,indexI) = (leftTanDir(:,indexI)/norm(leftTanDir(:,indexI)))* ...
                           ((norm(avePoint(30,:)-avePoint(31,:)) + norm(avePoint(2,:)-avePoint(1,:)))*2);
end


% deformTanDir           =    coff*[downDeformTanDir'; rightDeformTanDir'; upDeformTanDir'; leftDeformTanDir'];

adjustedBdTanDir           =    [downTanDir; rightTanDir; upTanDir; leftTanDir];



