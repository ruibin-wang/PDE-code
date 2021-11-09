%%% ���ñ߽�ߵ�������Ƭ�ڱ߽�ߴ�����ͬ�ı߽����ߣ��˴�����ָͬ���Ǵ�С���
%%% �߽紦������Ƭ�����߷����෴
%%% �ú���������Ϊ��ͳһ������Ƭ��Ӧ�����ߣ���һ������߽�����߷������ı�ʱ������һ����������߻����ŷ��������ı�

function MatchBdDirDef(bdDirDefNum, deformTanDir)

load avePointSet.mat     %% �洢����������Ƭ�ľ��ֵ㣬ֱ�ӵ���

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
    
