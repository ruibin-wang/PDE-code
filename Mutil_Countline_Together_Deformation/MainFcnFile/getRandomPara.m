% 该文件用于从已知的固定区间内取随机值，作为PDE参数的曲面的参数
function  randPara = getRandomPara(MeshNum)

paraIntervalSet         =      xlsread('meshOrderAndPdePara.xlsx',3);    %% variation intervals of the three parameters
ParaInterval            =      paraIntervalSet(MeshNum, :);

randPara1               =     (ParaInterval(2) - ParaInterval(1))*rand(1) + ParaInterval(1);  %% 从参数区间内产生一个随机数，生成新的曲面形状
randPara2               =     (ParaInterval(4) - ParaInterval(3))*rand(1) + ParaInterval(3);
randPara3               =     (ParaInterval(6) - ParaInterval(5))*rand(1) + ParaInterval(5);
randPara                =     [randPara1, randPara2, randPara3];