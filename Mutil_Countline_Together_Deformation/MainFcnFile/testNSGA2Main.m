% function testNSGA2main
clear;clc
%% �������ã�ÿ���������е�ʱ����Ҫ���ñ�����ԭ����ʼ״̬
% ����ṹΪ[HdPress(1,2,3), HdViscous(1,2,3), HdTotal(1,2,3), ...
%              MidPress(1,2,3), MidViscous(1,2,3), MidTotal(1,2,3), ...
%                  TailPress(1,2,3), TailViscous(1,2,3), TailTotal(1,2,3), ...] 
%  ���������е�(1,2,3)�ֱ��ʾ ��(1,0,0),(0,1,0),(0,0,1)�����ϵ�����ϵ��
% 
% ��������ϵ���ھ����е�����Ϊ��34�У�β���������ھ����е�����Ϊ��26��

orgPressViscousNet  =  1:36;  %% ������ʼ�����ݣ������棬ʹ�����ݵ�һ����1:36����ֵ
coffPressViscousNet = 1:36;
generationParaSets  = 1:10;   %% ���ʮ�������������˴����г�ʼ����Ȼ�󱣴�

save orgPressViscousNet.mat orgPressViscousNet
save coffPressViscousNet.mat coffPressViscousNet
save generationParaSets.mat generationParaSets

%% ��ǰ�򿪲���

global poolStates
delete(gcp('nocreate'))   %% ��ֹ������ǰ�رղ����д򿪵�worker
c = parcluster;
poolStates  =  parpool(c);

%% �����Ŵ��㷨����

load paraRanges.mat %% ������״���Ʋ����ı仯����

M         =        2;   %% the dimension of the objective space
V         =        10;  %% dimension of decision variable space
min_range =        paraRanges(:,1);  %% range for the variables in the decision variable space
max_range =        paraRanges(:,2);
pop       =        20;   %% Population size, must be an integer, more than 20
gen       =        5;   %% Total number of generations, must be an integer, more than 5
nsga_2(M, V, min_range, max_range, pop, gen)

