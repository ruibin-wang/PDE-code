%%% 首先对文档进行分析，发现数据都在括号中的规律，然后定位所需要的数据在文档的第几个括号中即可

function [totalTrCoffCd, trTailCoffCl] = ReadFluentFiles

% clear;clc

fid          =       fopen('Drag','r');   %% 读取数据文件
totalChar    =       fscanf(fid, '%c');
fclose(fid);

leftBrackets   =       find(totalChar == '(');    %% 按照字符，找出左括号对应的索引
rightBrackets  =       find(totalChar == ')');    %% 按照字符，找出右括号对应的索引

% orgPressViscousNet  =  1:36;  %% 创建初始化数据，并保存，使得数据第一行是1:36的数值
% coffPressViscousNet = 1:36;   

%% Pressure, viscous of the train(including its head, middle and tail)

tempOrgPressViscousNet    =    [];     %% 用来存放原始压力粘性力还有其总和的数值
% 数组结构为[HdPress(1,2,3), HdViscous(1,2,3), HdTotal(1,2,3), ...
%              MidPress(1,2,3), MidViscous(1,2,3), MidTotal(1,2,3), ...
%                  TailPress(1,2,3), TailViscous(1,2,3), TailTotal(1,2,3), ...] 
%  以上括号中的(1,2,3)分别表示 在(1,0,0),(0,1,0),(0,0,1)方向上的力或系数

tempCoffPressViscousNet  =     [];   %% 用来存放orgPressViscousNet对应的系数，结构与其相同
indexOrgData             =     [2 8 14 20];  %% 头车、中间、尾车的压力值、粘性力值以及 总力索引
indexCoffData            =     [5 11 17 23];  %% 头车、中间、尾车的压力系数、粘性力系数，总值的索引


for indexI = 1:length(indexOrgData)
    for indexJ = 0:2  %% 根据数据表中的结构
        
        tempOrgVector            =   str2num(totalChar(leftBrackets(indexOrgData(indexI)+indexJ)+1 : rightBrackets(indexOrgData(indexI)+indexJ)-1));
        tempCoffVector           =   str2num(totalChar(leftBrackets(indexCoffData(indexI)+indexJ)+1 : rightBrackets(indexCoffData(indexI)+indexJ)-1));
        tempOrgPressViscousNet   =   [tempOrgPressViscousNet, tempOrgVector];
        tempCoffPressViscousNet  =   [tempCoffPressViscousNet, tempCoffVector]; 
        
    end
end

%% 导出需要的数据，头车尾车，还有中间车的压力系数和尾车的升力系数

% trHdCoffCd       =      tempCoffPressViscousNet(7);     %% 车头的阻力系数
% trMidCoffCd      =      tempCoffPressViscousNet(16);    %% 中间车的阻力系数
% trTailCoffCd     =      tempCoffPressViscousNet(25);    %% 车尾的阻力系数

totalTrCoffCd    =      tempCoffPressViscousNet(34);    %% 整车的阻力系数，为返回值

trTailCoffCl     =      tempCoffPressViscousNet(26);    %% 尾车的升力系数，为返回值

% delete Drag Lift

%% 保存数据

load orgPressViscousNet.mat   %% 导入预存数据，加入新的一行
load coffPressViscousNet.mat 

orgPressViscousNet     =   [orgPressViscousNet; tempOrgPressViscousNet];
coffPressViscousNet    =   [coffPressViscousNet; tempCoffPressViscousNet]; 

save orgPressViscousNet.mat orgPressViscousNet
save coffPressViscousNet.mat coffPressViscousNet


%{

C=exist('lift','file');
if C==2
    delete lift;
end
system('fluentopt.bat');
D=exist('lift','file');
while D~=2
    D=exist('lift','file');
end
%}