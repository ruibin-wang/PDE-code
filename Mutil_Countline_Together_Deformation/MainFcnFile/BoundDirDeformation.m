function deformTanDir = BoundDirDeformation(boundTan, avePoint, deformAngle, coff)

%%%% 边界绕坐标轴旋转
downTanDir             =    boundTan(1:11,:);
rightTanDir            =    boundTan(12:22,:);
upTanDir               =    boundTan(23:33,:);
leftTanDir             =    boundTan(34:44,:);


downTransMartix        =    makehgtform('zrotate', deformAngle(1));
rightTransMartix       =    makehgtform('xrotate', deformAngle(2));
upTransMartix          =    makehgtform('zrotate', deformAngle(3));
leftTransMartix        =    makehgtform('xrotate', deformAngle(4));


downDeformTanDir       =    downTransMartix(1:3,1:3) * downTanDir';
rightDeformTanDir      =    rightTransMartix(1:3,1:3) * rightTanDir';
upDeformTanDir         =    upTransMartix(1:3,1:3) * upTanDir';
leftDeformTanDir       =    leftTransMartix(1:3,1:3) * leftTanDir';

%%% 先单位化，然后乘以边界点之间的间距，逼近真实边界切线
%%% 该部分内容已经在前处理中实现，因此无需再算

for indexI = 1:size(downDeformTanDir, 2)
    downDeformTanDir(:,indexI) = (downDeformTanDir(:,indexI)/norm(downDeformTanDir(:,indexI)))* ...
                           ((norm(avePoint(end,:)-avePoint(1,:)) + norm(avePoint(12,:)-avePoint(11,:)))*2);
end

for indexI = 1:size(rightDeformTanDir, 2)
    rightDeformTanDir(:,indexI) = (rightDeformTanDir(:,indexI)/norm(rightDeformTanDir(:,indexI)))* ...
                           ((norm(avePoint(10,:)-avePoint(11,:)) + norm(avePoint(22,:)-avePoint(21,:)))*2);
end

for indexI = 1:size(upDeformTanDir, 2)
    upDeformTanDir(:,indexI) = (upDeformTanDir(:,indexI)/norm(upDeformTanDir(:,indexI)))* ...
                           ((norm(avePoint(20,:)-avePoint(21,:)) + norm(avePoint(32,:)-avePoint(31,:)))*2);
end

for indexI = 1:size(leftDeformTanDir, 2)
    leftDeformTanDir(:,indexI) = (leftDeformTanDir(:,indexI)/norm(leftDeformTanDir(:,indexI)))* ...
                           ((norm(avePoint(30,:)-avePoint(31,:)) + norm(avePoint(2,:)-avePoint(1,:)))*2);
end


% deformTanDir           =    coff*[downDeformTanDir'; rightDeformTanDir'; upDeformTanDir'; leftDeformTanDir'];
if deformAngle(1) ~= 0
    deformTanDir           =    [coff*downDeformTanDir'; rightDeformTanDir'; upDeformTanDir'; leftDeformTanDir'];
elseif deformAngle(2) ~= 0
    deformTanDir           =    [downDeformTanDir'; coff*rightDeformTanDir'; upDeformTanDir'; leftDeformTanDir'];
elseif deformAngle(3) ~= 0
    deformTanDir           =    [downDeformTanDir'; rightDeformTanDir'; coff*upDeformTanDir'; leftDeformTanDir'];
elseif deformAngle(4) ~= 0
    deformTanDir           =    [downDeformTanDir'; rightDeformTanDir'; upDeformTanDir'; coff*leftDeformTanDir'];
else 
    deformTanDir           =    [downDeformTanDir'; rightDeformTanDir'; upDeformTanDir'; leftDeformTanDir'];
end




