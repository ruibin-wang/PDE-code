% ���ļ����ڴ���֪�Ĺ̶�������ȡ���ֵ����ΪPDE����������Ĳ���
function  randPara = getRandomPara(MeshNum)

paraIntervalSet         =      xlsread('meshOrderAndPdePara.xlsx',3);    %% variation intervals of the three parameters
ParaInterval            =      paraIntervalSet(MeshNum, :);

randPara1               =     (ParaInterval(2) - ParaInterval(1))*rand(1) + ParaInterval(1);  %% �Ӳ��������ڲ���һ��������������µ�������״
randPara2               =     (ParaInterval(4) - ParaInterval(3))*rand(1) + ParaInterval(3);
randPara3               =     (ParaInterval(6) - ParaInterval(5))*rand(1) + ParaInterval(5);
randPara                =     [randPara1, randPara2, randPara3];