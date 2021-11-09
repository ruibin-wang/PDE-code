%%% 共用边界边的两个面片在边界边处有相同的边界切线，此处的相同指的是大小相等
%%% 边界处两个面片的切线方向相反
%%% 该函数的作用为：统一相邻面片对应的切线，当一个曲面边界的切线方向发生改变时，另外一个曲面的曲线会沿着反方向发生改变

function MatchBdDirDef(bdDirDefNum, deformTanDir)

load avePointSet.mat     %% 存储的是所有面片的均分点，直接导入

bdDefAvePt               =     avePointSet{bdDirDefNum, 2};  
  
boundPt_DirSet{1,1}      =     bdDefAvePt(1:11, :);  %% downAvePt
boundPt_DirSet{2,1}      =     bdDefAvePt(11:21, :);  %% rightAvePt
boundPt_DirSet{3,1}      =     bdDefAvePt(21:31, :);  %% upAvePt
boundPt_DirSet{4,1}      =     [bdDefAvePt(31:40, :); bdDefAvePt(1, :)];  %% leftAvePt


boundPt_DirSet{1,2}      =     deformTanDir(1:11, :);  %% downAvePt
boundPt_DirSet{2,2}      =     deformTanDir(12:22, :);  %% rightAvePt
boundPt_DirSet{3,2}      =     deformTanDir(23:33, :);  %% upAvePt
boundPt_DirSet{4,2}      =     deformTanDir(34:44, :);  %% leftAvePt


for indexI = 1:length(boundPt_DirSet)
    DefBdDirAssign(bdDirDefNum, boundPt_DirSet{indexI, 1}, boundPt_DirSet{indexI, 2})
end
    
