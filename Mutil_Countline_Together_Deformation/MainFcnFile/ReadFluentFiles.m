%%% ���ȶ��ĵ����з������������ݶ��������еĹ��ɣ�Ȼ��λ����Ҫ���������ĵ��ĵڼ��������м���

function [totalTrCoffCd, trTailCoffCl] = ReadFluentFiles

% clear;clc

fid          =       fopen('Drag','r');   %% ��ȡ�����ļ�
totalChar    =       fscanf(fid, '%c');
fclose(fid);

leftBrackets   =       find(totalChar == '(');    %% �����ַ����ҳ������Ŷ�Ӧ������
rightBrackets  =       find(totalChar == ')');    %% �����ַ����ҳ������Ŷ�Ӧ������

% orgPressViscousNet  =  1:36;  %% ������ʼ�����ݣ������棬ʹ�����ݵ�һ����1:36����ֵ
% coffPressViscousNet = 1:36;   

%% Pressure, viscous of the train(including its head, middle and tail)

tempOrgPressViscousNet    =    [];     %% �������ԭʼѹ��ճ�����������ܺ͵���ֵ
% ����ṹΪ[HdPress(1,2,3), HdViscous(1,2,3), HdTotal(1,2,3), ...
%              MidPress(1,2,3), MidViscous(1,2,3), MidTotal(1,2,3), ...
%                  TailPress(1,2,3), TailViscous(1,2,3), TailTotal(1,2,3), ...] 
%  ���������е�(1,2,3)�ֱ��ʾ ��(1,0,0),(0,1,0),(0,0,1)�����ϵ�����ϵ��

tempCoffPressViscousNet  =     [];   %% �������orgPressViscousNet��Ӧ��ϵ�����ṹ������ͬ
indexOrgData             =     [2 8 14 20];  %% ͷ�����м䡢β����ѹ��ֵ��ճ����ֵ�Լ� ��������
indexCoffData            =     [5 11 17 23];  %% ͷ�����м䡢β����ѹ��ϵ����ճ����ϵ������ֵ������


for indexI = 1:length(indexOrgData)
    for indexJ = 0:2  %% �������ݱ��еĽṹ
        
        tempOrgVector            =   str2num(totalChar(leftBrackets(indexOrgData(indexI)+indexJ)+1 : rightBrackets(indexOrgData(indexI)+indexJ)-1));
        tempCoffVector           =   str2num(totalChar(leftBrackets(indexCoffData(indexI)+indexJ)+1 : rightBrackets(indexCoffData(indexI)+indexJ)-1));
        tempOrgPressViscousNet   =   [tempOrgPressViscousNet, tempOrgVector];
        tempCoffPressViscousNet  =   [tempCoffPressViscousNet, tempCoffVector]; 
        
    end
end

%% ������Ҫ�����ݣ�ͷ��β���������м䳵��ѹ��ϵ����β��������ϵ��

% trHdCoffCd       =      tempCoffPressViscousNet(7);     %% ��ͷ������ϵ��
% trMidCoffCd      =      tempCoffPressViscousNet(16);    %% �м䳵������ϵ��
% trTailCoffCd     =      tempCoffPressViscousNet(25);    %% ��β������ϵ��

totalTrCoffCd    =      tempCoffPressViscousNet(34);    %% ����������ϵ����Ϊ����ֵ

trTailCoffCl     =      tempCoffPressViscousNet(26);    %% β��������ϵ����Ϊ����ֵ

% delete Drag Lift

%% ��������

load orgPressViscousNet.mat   %% ����Ԥ�����ݣ������µ�һ��
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