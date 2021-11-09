%%% �ú���������Ϊͨ�������Ĳ����ı�������ߵ���״
%%% �ı�ƫ΢�ַ���������
%%% �ı�߽����ߵķ���

function ptMatrix = CounterLineDeformationForAddedCountLine(countLineAttachBd, aixsT, deltT, bdDirDefNum, deformAngle, coff)


avePointSet = cell(17,1);
cd '..\StroNewAvePtForAddedCtLine'

for indexI = 1:17
    
    eval(['load avePoint_', num2str(indexI), '.mat', ' ;']);
    eval(['load Mesh_', num2str(indexI), '.mat', ' ;']);
    eval(['load PtMatrix_', num2str(indexI), '.txt']);   %% ����δ�α����Ƭ��,�Ը���֮ǰ���㱣�������
    %     eval(['temp = avePoint_', num2str(indexI), ';']);
    %     hold on; plot3(temp(:,1), temp(:,2), temp(:,3), '-')
    avePointSet{indexI, 1} = indexI;
    eval(['avePointSet{', num2str(indexI), ', 2} = ', 'avePoint_', num2str(indexI), ';']);
    eval(['load aveTanDir_', num2str(indexI), '.mat']);
    
end

load deformExtendCountLineSet.mat

cd '..\MainFcnFile'  %% ͨ������������¸����Ѿ��α���Ĳ���
for indexI = 1:17
    
    eval(['save PtMatrix_', num2str(indexI), '.txt', ' PtMatrix_', num2str(indexI), ' -ascii', ';'])
    eval(['save avePoint_', num2str(indexI), '.mat', ' avePoint_', num2str(indexI), ';'])
    %%% �����߽�����
    %     eval(['aveTanDir_', num2str(indexI), ' =  BdTanAdjust(', 'aveTanDir_', num2str(indexI), ', avePoint_', num2str(indexI), ');']);
    eval(['save aveTanDir_', num2str(indexI), '.mat', ' aveTanDir_', num2str(indexI), ';']);
    
end

save deformExtendCountLineSet.mat


%%% �ò���Ϊ�����ߵĶ��壬ֻ����һ�Σ����ұ����� DATA.mat ��

%% ���ɺ����������
%%% ����Ƭ�߽�����������ע�⣺������Ƭ�غϵĶ���ֻ����һ�������ڽ��л�ԭ�����ʱ��ÿ��Ǻ��α�󶥵�������λ��

% CountLineName = ['A1_F1';'A2_F2';'A3_F3';'A4_F4';'B1_B4';...
%                     'C1_C4';'D1_D4';'E1_E4';'A1_O1_A3';'originalExtendA1_F1';'originalExtendA4_F4'];

A1_F1 =    [avePoint_3(1,:); avePoint_3(end:-1:31,:); avePoint_6(end:-1:31,:); ...   %% Y axis deformation
    avePoint_9(end:-1:31,:); avePoint_12(end:-1:31,:); ...
    avePoint_15(end:-1:31,:)];

B1    =    avePoint_3(31,:);   C1    =    avePoint_6(31,:);
D1    =    avePoint_9(31,:);   E1    =    avePoint_12(31,:);


B1_B2 =    avePoint_6(1:11,:);   C1_C2 =    avePoint_9(1:11,:);
D1_D2 =    avePoint_12(1:11,:);  E1_E2 =    avePoint_15(1:11,:);

boundAttachToA1_F1{1,1} = A1_F1; boundAttachToA1_F1{1,2} = B1_B2;
boundAttachToA1_F1{1,3} = C1_C2; boundAttachToA1_F1{1,4} = D1_D2;
boundAttachToA1_F1{1,5} = E1_E2;
boundAttachToA1_F1{2,1} = 'A1_F1';   %% Ԫ���ڶ��е�һ��λ�ô�������ߵı�ţ��������


A2_F2 = [avePoint_3(11:21,:); avePoint_6(12:21,:); avePoint_9(12:21,:);...    %% Z axis deformation
    avePoint_12(12:21,:); avePoint_15(12:21,:)];

B2    =    avePoint_3(21,:);   C2    =    avePoint_6(21,:);
D2    =    avePoint_9(21,:);   E2    =    avePoint_12(21,:);

B2_B3 =    avePoint_5(1:11,:);   C2_C3 =    avePoint_8(1:11,:);
D2_D3 =    avePoint_11(1:11,:);  E2_E3 =    avePoint_14(1:11,:);

boundAttachToA2_F2{1,1} = A2_F2; boundAttachToA2_F2{1,2} = B1_B2;
boundAttachToA2_F2{1,3} = C1_C2; boundAttachToA2_F2{1,4} = D1_D2;
boundAttachToA2_F2{1,5} = E1_E2;

boundAttachToA2_F2{1,6} = B2_B3; boundAttachToA2_F2{1,7} = C2_C3;
boundAttachToA2_F2{1,8} = D2_D3; boundAttachToA2_F2{1,9} = E2_E3;
boundAttachToA2_F2{2,1} = 'A2_F2';

A3_F3 = [avePoint_1(1:11,:);  avePoint_4(end:-1:31,:);...    %% Z axis deformation
    avePoint_7(end:-1:31,:); avePoint_10(end:-1:31,:);...
    avePoint_13(end:-1:31,:)];

B3    =    avePoint_1(11,:);  C3    =    avePoint_4(31,:);
D3    =    avePoint_7(31,:);  E3    =    avePoint_10(31,:);

B3_B4 =    avePoint_4(1:11,:);   C3_C4 =    avePoint_7(1:11,:);
D3_D4 =    avePoint_10(1:11,:);  E3_E4 =    avePoint_13(1:11,:);

boundAttachToA3_F3{1,1} = A3_F3; boundAttachToA3_F3{1,2} = B2_B3;
boundAttachToA3_F3{1,3} = C2_C3; boundAttachToA3_F3{1,4} = D2_D3;
boundAttachToA3_F3{1,5} = E2_E3;

boundAttachToA3_F3{1,6} = B3_B4; boundAttachToA3_F3{1,7} = C3_C4;
boundAttachToA3_F3{1,8} = D3_D4; boundAttachToA3_F3{1,9} = E3_E4;
boundAttachToA3_F3{2,1} = 'A3_F3';

A4_F4 = [avePoint_1(31:-1:21,:); avePoint_4(12:21,:); avePoint_7(12:21,:); ...   %% X,Z axis deformation
    avePoint_10(12:21,:); avePoint_13(12:21,:)];

B4    =    avePoint_1(21,:);   C4    =    avePoint_4(21,:);
D4    =    avePoint_7(21,:);   E4    =    avePoint_10(21,:);

boundAttachToA4_F4{1,1} = A4_F4; boundAttachToA4_F4{1,2} = B3_B4;
boundAttachToA4_F4{1,3} = C3_C4; boundAttachToA4_F4{1,4} = D3_D4;
boundAttachToA4_F4{1,5} = E3_E4;
boundAttachToA4_F4{2,1} = 'A4_F4';

%% ��ͷ�Ǽ�

A1_O1_A3 = [ avePoint_16(31:end,:); avePoint_16(1,:); avePoint_17(1,:); avePoint_17(end:-1:31,:)];    %% X axis deformation
P1_O1 = avePoint_16(1:11, :);   O1_P2 = avePoint_17(1:11, :);
O1_O2 = avePoint_16(11:21, :);


boundAttachToA1_O1_A3{1, 1} = A1_O1_A3;   boundAttachToA1_O1_A3{1, 2} = P1_O1;
boundAttachToA1_O1_A3{1, 3} = O1_P2;      boundAttachToA1_O1_A3{1, 4} = O1_O2;
boundAttachToA1_O1_A3{2, 1} = 'A1_O1_A3';

% hold on; scatter3(avePoint_16(11,1), avePoint_16(11,2), avePoint_16(11,3), 'filled')
% hold on; scatter3(avePoint_17(:,1), avePoint_17(:,2), avePoint_17(:,3), 'filled')
%
% hold on; plot3(A1_O1_A3(:,1), A1_O1_A3(:,2), A1_O1_A3(:,3), '-')

%% ���ص�
%{
%%% Ϊ�˽�ʡʱ����ǰ���룬����������ļ�
% meshIndex_1          =     xlsread('MeshIndex.xlsx', 1);
% meshIndex_2          =     xlsread('MeshIndex.xlsx', 2);
% 
% meshIndex_3          =     xlsread('MeshIndex.xlsx', 3);
% meshIndex_4          =     xlsread('MeshIndex.xlsx', 4);
% meshIndex_5          =     xlsread('MeshIndex.xlsx', 5);
% meshIndex_6          =     xlsread('MeshIndex.xlsx', 6);
% meshIndex_7          =     xlsread('MeshIndex.xlsx', 7);
% meshIndex_8          =     xlsread('MeshIndex.xlsx', 8);
% meshIndex_9          =     xlsread('MeshIndex.xlsx', 9);
% meshIndex_10         =     xlsread('MeshIndex.xlsx', 10);
% meshIndex_11          =     xlsread('MeshIndex.xlsx', 11);
% meshIndex_12         =     xlsread('MeshIndex.xlsx', 12);
% meshIndex_13         =     xlsread('MeshIndex.xlsx', 13);
% meshIndex_14         =     xlsread('MeshIndex.xlsx', 14);
% meshIndex_15         =     xlsread('MeshIndex.xlsx', 15);
% 
% meshIndex_16         =     xlsread('MeshIndex.xlsx', 16);
% meshIndex_17         =     xlsread('MeshIndex.xlsx', 17);
% 
% MeshIndexSets      =   cell(17,1);
% for indexI = 1:17
%     eval(['MeshIndexSets{indexI, 1} = meshIndex_', num2str(indexI), ';']);
% end
% 
% save MeshIndexSets.mat

%}

load MeshIndexSets.mat   %% �����Ƭ�����������ļ�


for indexI = 1:17
    eval(['meshIndex_', num2str(indexI), ' = ', 'MeshIndexSets{indexI, 1}', ';']); %% ����Ƭ�������ļ��У���ÿ���ֽ��и�ֵ
end


%%% ԭʼ����Ƭ���ص�
originalExtendA1_F1  =    [Mesh_3(meshIndex_3(:,1), :); Mesh_6(meshIndex_6(:,1), :); Mesh_9(meshIndex_9(:,1), :); ...
    Mesh_12(meshIndex_12(:,1), :); Mesh_15(meshIndex_15(:,1), :)];
%%% ԭʼ����Ƭ���ص�
originalExtendA4_F4  =    [Mesh_1(meshIndex_1(1,:), :); Mesh_4(meshIndex_4(:,size(meshIndex_4,2)), :); Mesh_7(meshIndex_7(:,size(meshIndex_7,2)), :); ...
    Mesh_10(meshIndex_10(:,size(meshIndex_10,2)), :); Mesh_13(meshIndex_13(:,size(meshIndex_13,2)), :)];


originalExtendA1_O1_A3  =    [Mesh_16(meshIndex_16(:,1), :); Mesh_17(meshIndex_17(:,1), :)];


%%% ��֮������ص�
extendA1_F1          =    findNearPoint(A1_F1, originalExtendA1_F1, 10000);        %%  �߽�ߵ����ص�
extendA4_F4          =    findNearPoint(A4_F4, originalExtendA4_F4, 10000);        %%  �߽�ߵ����ص�
extendA1_O1_A3       =    findNearPoint(A1_O1_A3, originalExtendA1_O1_A3, 10000);        %%  �߽�ߵ����ص�



boundAttachToA1_F1{2,2} = extendA1_F1; boundAttachToA4_F4{2,2} = extendA4_F4;  %% ֻ��Ԫ���ڶ��е�һ��λ�ô�����ص�
boundAttachToA1_O1_A3{2,2} = extendA1_O1_A3;

% hold on; scatter3(extendA1_F1(:,1), extendA1_F1(:,2), extendA1_F1(:,3), 'filled')
% hold on; scatter3(extendA4_F4(:,1), extendA4_F4(:,2), extendA4_F4(:,3), 'filled')

%% ���������������
%%% ������Ƭ����������·����ʱ������¿��ǣ���Ϊֻ����һ��
B1_B4 = [avePoint_6(1:11,:); avePoint_5(2:11,:); avePoint_4(2:11,:)];   %% Z,Y axis deformation
A2_B2 = avePoint_3(11:21,:);   A3_B3 = avePoint_2(11:21,:);
B2_C2 = avePoint_6(11:21,:);   B3_C3 = avePoint_5(11:21,:);

boundAttachToB1_B4{1,1} = B1_B4;   boundAttachToB1_B4{1,2} = A2_B2;
boundAttachToB1_B4{1,3} = A3_B3;   boundAttachToB1_B4{1,4} = B2_C2;
boundAttachToB1_B4{1,5} = B3_C3;
boundAttachToB1_B4{2,1} = 'B1_B4';

C1_C4 = [avePoint_9(1:11,:); avePoint_8(2:11,:); avePoint_7(2:11,:)];    %% Z,Y axis deformation
C2_D2 = avePoint_9(11:21,:);   C3_D3 = avePoint_8(11:21,:);

boundAttachToC1_C4{1,1} = C1_C4;   boundAttachToC1_C4{1,2} = B2_C2;
boundAttachToC1_C4{1,3} = B3_C3;   boundAttachToC1_C4{1,4} = C2_D2;
boundAttachToC1_C4{1,5} = C3_D3;
boundAttachToC1_C4{2,1} = 'C1_C4';


D1_D4 = [avePoint_12(1:11,:); avePoint_11(2:11,:); avePoint_10(2:11,:)];   %% Z,Y axis deformation
D2_E2 = avePoint_12(11:21,:);   D3_E3 = avePoint_11(11:21,:);

boundAttachToD1_D4{1,1} = D1_D4;   boundAttachToD1_D4{1,2} = C2_D2;
boundAttachToD1_D4{1,3} = C3_D3;   boundAttachToD1_D4{1,4} = D2_E2;
boundAttachToD1_D4{1,5} = D3_E3;
boundAttachToD1_D4{2,1} = 'D1_D4';


E1_E4 = [avePoint_15(1:11,:); avePoint_14(2:11,:); avePoint_13(2:11,:)];   %% Z,Y axis deformation
E2_F2 = avePoint_12(11:21,:);   E3_F3 = avePoint_11(11:21,:);

boundAttachToE1_E4{1,1} = E1_E4;   boundAttachToE1_E4{1,2} = D2_E2;
boundAttachToE1_E4{1,3} = D3_E3;   boundAttachToE1_E4{1,4} = E2_F2;
boundAttachToE1_E4{1,5} = E3_F3;
boundAttachToE1_E4{2,1} = 'E1_E4';


F1_F4 = [avePoint_15(31:-1:21,:); avePoint_14(30:-1:21,:); avePoint_13(30:-1:21,:)];   %% Z,Y axis deformation
E2_F2 = avePoint_12(11:21,:);   E3_F3 = avePoint_11(11:21,:);

boundAttachToF1_F4{1,1} = F1_F4;   boundAttachToF1_F4{1,2} = D2_E2;
boundAttachToF1_F4{1,3} = D3_E3;   boundAttachToF1_F4{1,4} = E2_F2;
boundAttachToF1_F4{1,5} = E3_F3;
boundAttachToF1_F4{2,1} = 'F1_F4';


originalExtendF1_F4  =    [Mesh_15(meshIndex_15(1,:), :); Mesh_14(meshIndex_14(1,:), :); Mesh_13(meshIndex_13(1,:), :)];
extendF1_F4          =    findNearPoint(F1_F4, originalExtendF1_F4, 10000);        %%  �߽�ߵ����ص�
boundAttachToF1_F4{2,2} = extendF1_F4;

A3_A4 = [avePoint_1(1,:); avePoint_1(end:-1:31,:)];

originalExtendA3_A4  =    Mesh_1(meshIndex_1(:,1), :);
extendA3_A4          =    findNearPoint(A3_A4, originalExtendA3_A4, 10000);        %%  �߽�ߵ����ص�


boundAttachToA3_A4{1,1}  =   A3_A4;
boundAttachToA3_A4{2,1}  =  'A3_A4';  boundAttachToA3_A4{2,2}  =  extendA3_A4;

threeExtPt = [Mesh_1(meshIndex_1(1,1), :); Mesh_15(meshIndex_15(1,1), :); Mesh_13(meshIndex_13(1,end), :)];    %% ���ص�Ľ���

% save DATA.mat  %% �����ظ����㣬�����������������Ϣ
%}

%% �����ӿڣ�����
% aixsT               =    'Y';
% deltT               =    0.2;

% load DATA.mat

countLineAttachBd   =    eval(countLineAttachBd);  %% ��Ŵ��α������ߺ��������������ϵ�����߽�

% bdDirDefNum         =    9;   %% ��Ҫ�ı���Ƭ�߽����ߵ���Ƭ��ţ���Ϊ[]�����ʾ�����б߽����߷���ı�
% coff                =    1;    %% ����ϵ��
% deformAngle         =    [0, -(1/2)*pi, 0, 0];   %%  �������Ϊ���ݣ����ڱ���Ϊ͹��Ч���ոպ�

% deformAngle         =    [0, (3/2)*pi, 0, 0];   %%  ����ϵ��Ϊ1ʱ������Ϊ��͹
% deformAngle         =    [0, -(1/3)*pi, 0, 0];   %%  ����ϵ��Ϊ1ʱ������Ϊ��͹��Ч������

% deformAngle         =    [0, -(2/3)*pi, 0, 0];   %%  ����ϵ��Ϊ1ʱ����͹���ⰼ��Ч������


%%% boundAttachToE1_E4            boundAttachToA1_F1
%%% boundAttachToF1_F4            boundAttachToA2_F2
%%% boundAttachToD1_D4            boundAttachToA3_F3
%%% boundAttachToC1_C4            boundAttachToA4_F4
%%% boundAttachToB1_B4
%%% boundAttachToA1_O1_A3

%% ������Ƭ�߽�������ת

if ~isempty(bdDirDefNum)
    
    eval(['avePoint = avePoint_', num2str(bdDirDefNum), ';']);
    eval(['boundTan =', ' aveTanDir_', num2str(bdDirDefNum), ';']);
    
    deformTanDir        =      BoundDirDeformation(boundTan, avePoint, deformAngle, coff);  %% ����ע������ķ��򣬺��ڵü���
    
    eval(['aveTanDir_', num2str(bdDirDefNum), ' = deformTanDir', ';']);
    eval(['save aveTanDir_', num2str(bdDirDefNum), '.mat', ' aveTanDir_', num2str(bdDirDefNum), ';']);
    
    %     MatchBdDirDef(bdDirDefNum, deformTanDir)  %% �߽�������α䵼��������Ƭ�߽�����ͬ�������ı�,�������ɵı߽�����
    
end


%% �α估ƥ��

deformCountLine             =      boundMotivation(countLineAttachBd{1,1}, aixsT, deltT);   %% �α���������

defBdAttachToCountLine      =      countLineAttachBd;    %% ����������Լ������������α�֮�����״
defBdAttachToCountLine{1,1} =      deformCountLine;  %% �α���������ռ�ݵ�һ��λ��

% hold on; scatter3(0.1*deformCountLine(:,1), 0.1*deformCountLine(:,2), 0.1*deformCountLine(:,3), 'filled')
%
% hold on; scatter3(0.1*countLineAttachBd{1,1}(:,1), 0.1*countLineAttachBd{1,1}(:,2), 0.1*countLineAttachBd{1,1}(:,3), 'filled')

%% ����Ǽⲿλ���α�

if strcmp(countLineAttachBd{2,1} ,'A1_O1_A3')
    for indexI = 2:length(countLineAttachBd)
        %%% �˴���������𴦲�ͬ�����Եõ�����ȡ����
        if indexI == length(countLineAttachBd)
            if aixsT == 'X'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    defBdAttachToCountLine{1,indexI}(indexJ,1) = countLineAttachBd{1,indexI}(indexJ,1) + ...
                        localIncrease * cos((pi/(2*10))*(indexJ-1));
                end
            elseif aixsT == 'Y'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    defBdAttachToCountLine{1,indexI}(indexJ,2) = countLineAttachBd{1,indexI}(indexJ,2) + ...
                        localIncrease * cos((pi/(2*10))*(indexJ-1));
                end
            end
            continue
        end
        
        if ~isempty(find(ismember(countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1))
            localIncrease = sign(deltT) * norm(deformCountLine(find(ismember(countLineAttachBd{1,1}, ...
                countLineAttachBd{1,indexI}(1,:)), 1),:) - countLineAttachBd{1,indexI}(1,:));
            if aixsT == 'X'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    if indexJ == 1
                        %%% �����������α��������ϵĵ���˵��ѡ��ֱ�Ӹ�ֵ
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1),:);
                    else
                        %%% �����������α��������ϵı߽���˵��ֱ�ӽ���ƽ�ƣ��涨ֻ��X�᷽���Ͻ����ƶ����ʶ������ٽ����ж�
                        defBdAttachToCountLine{1,indexI}(indexJ,1) = countLineAttachBd{1,indexI}(indexJ,1) + localIncrease;
                    end
                end
            elseif aixsT == 'Y'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    if indexJ == 1
                        %%% �����������α��������ϵĵ���˵��ѡ��ֱ�Ӹ�ֵ
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1),:);
                    else
                        %%% �����������α��������ϵı߽���˵��ֱ�ӽ���ƽ�ƣ��涨ֻ��X�᷽���Ͻ����ƶ����ʶ������ٽ����ж�
                        defBdAttachToCountLine{1,indexI}(indexJ,2) = countLineAttachBd{1,indexI}(indexJ,2) + localIncrease;
                    end
                end
            end
            
            
        elseif ~isempty(find(ismember(countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1))
            localIncrease = sign(deltT)*norm(deformCountLine(find(ismember(countLineAttachBd{1,1}, ...
                countLineAttachBd{1,indexI}(end,:)), 1),:) - countLineAttachBd{1,indexI}(end,:));
            if aixsT == 'X'
                for indexJ = length(countLineAttachBd{1,2}):-1:1
                    if indexJ == length(countLineAttachBd{1,2})
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,1) = countLineAttachBd{1,indexI}(indexJ,1) + localIncrease ;
                    end
                end
                
            elseif aixsT == 'Y'
                for indexJ = length(countLineAttachBd{1,2}):-1:1
                    if indexJ == length(countLineAttachBd{1,2})
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,2) = countLineAttachBd{1,indexI}(indexJ,2) + localIncrease ;
                    end
                end
            end
            
        end
    end
    
elseif strcmp(countLineAttachBd{2,1} ,'A3_A4') ~= 1
    %% �����ȥ�Ǽ�֮��Ĳ���
    for indexI = 2:length(countLineAttachBd)
        if ~isempty(find(ismember(countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1))
            %%% ǰ���ϵ����Ϊ�˱�֤������Ϊ����ʱ������������Ҳ�Ǹ���
            localIncrease = sign(deltT)*norm(deformCountLine(find(ismember(countLineAttachBd{1,1}, ...
                countLineAttachBd{1,indexI}(1,:)), 1),:) - countLineAttachBd{1,indexI}(1,:));
            if aixsT == 'X'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    if indexJ == 1
                        %%% �����������α��������ϵĵ���˵��ѡ��ֱ�Ӹ�ֵ
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1),:);
                    else
                        %%% �����������α��������ϵı߽���˵���������ճ���������������
                        %%% 11���㣬�����ҵ�pi/2���л��֣�Ȼ���յ��˳����Ϊ����ϵ�����������α������ߵ��������Խ��
                        defBdAttachToCountLine{1,indexI}(indexJ,1) = countLineAttachBd{1,indexI}(indexJ,1) + ...
                            localIncrease * cos((pi/(2*10))*(indexJ-1));
                    end
                end
                
                
            elseif aixsT == 'Y'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    if indexJ == 1
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,2) = countLineAttachBd{1,indexI}(indexJ,2) + ...
                            localIncrease * cos((pi/(2*10))*(indexJ-1));
                    end
                end
                
            elseif aixsT == 'Z'
                for indexJ = 1:length(countLineAttachBd{1,2})
                    if indexJ == 1
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(1,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,3) = countLineAttachBd{1,indexI}(indexJ,3) + ...
                            localIncrease * cos((pi/(2*10))*(indexJ-1));
                    end
                end
            end
            
        elseif ~isempty(find(ismember(countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1))
            localIncrease = sign(deltT)*norm(deformCountLine(find(ismember(countLineAttachBd{1,1}, ...
                countLineAttachBd{1,indexI}(end,:)), 1),:) - countLineAttachBd{1,indexI}(end,:));
            if aixsT == 'X'
                for indexJ = length(countLineAttachBd{1,2}):-1:1
                    if indexJ == length(countLineAttachBd{1,2})
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,1) = countLineAttachBd{1,indexI}(indexJ,1) + ...
                            localIncrease * cos((pi/(2*10))*(11-indexJ));
                    end
                end
            elseif aixsT == 'Y'
                for indexJ = length(countLineAttachBd{1,2}):-1:1
                    if indexJ == length(countLineAttachBd{1,2})
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,2) = countLineAttachBd{1,indexI}(indexJ,2) + ...
                            localIncrease * cos((pi/(2*10))*(11-indexJ));
                    end
                end
                
            elseif aixsT == 'Z'
                for indexJ = length(countLineAttachBd{1,2}):-1:1
                    if indexJ == length(countLineAttachBd{1,2})
                        defBdAttachToCountLine{1,indexI}(indexJ,:) = deformCountLine(find(ismember(...
                            countLineAttachBd{1,1}, countLineAttachBd{1,indexI}(end,:)), 1),:);
                    else
                        defBdAttachToCountLine{1,indexI}(indexJ,3) = countLineAttachBd{1,indexI}(indexJ,3) + ...
                            localIncrease * cos((pi/(2*10))*(11-indexJ));
                    end
                end
            end
        end
    end
end


%% �жϱ߽���α������ĸ���Ƭ�������滻��Ӧ��avePoint


tempBoundAttachToCountLine   =   cell(length(countLineAttachBd), 1);
tempAvePointSet              =   cell(length(avePointSet), 1);


for indexI = 1:length(countLineAttachBd)
    tempBoundAttachToCountLine{indexI,1} = round(countLineAttachBd{1,indexI}, 2);  %% �������
end

for indexI = 1:length(avePointSet)
    tempAvePointSet{indexI,1} = round(avePointSet{indexI,2}, 2);
end

relatePatchNum = [];  %% �߶�Ӧ����Ƭ
%%% ��δ�α����������ԭʼ�ľ��ֵ����ƥ�䣬Ȼ������Ӧλ�õ��α��˵������߽����滻���õ��µģ��α�֮�����Ƭ���ֵ�
for indexI = 1:length(countLineAttachBd)
    %     tempBoundAttachToCountLine = eval(vpa(countLineAttachBd{1,indexI}, 4));  %% �������
    for indexJ = 1:length(countLineAttachBd{1,indexI})
        for indexK = 1:length(avePointSet)
            %             tempAvePointSet = eval(vpa(avePointSet{indexK,2}, 4));
            for indexL = 1:length(avePointSet{1,2})
                if tempBoundAttachToCountLine{indexI,1}(indexJ, :) == tempAvePointSet{indexK,1}(indexL,:)
                    avePointSet{indexK,2}(indexL,:) = defBdAttachToCountLine{1,indexI}(indexJ, :);
                    relatePatchNum = [relatePatchNum; indexK];  %% Ϊ�˽�ʡ���������ʱ�䣬ѡ����ı��˱߽���״����Ƭ���
                end
            end
        end
    end
end

% hold on; scatter3(0.1*avePointSet{4,2}(:,1), 0.1*avePointSet{4,2}(:,2), 0.1*avePointSet{4,2}(:,3), 'r*')

relatePatchNum = unique(relatePatchNum);  %% ȥ���α���Ƭ������ظ��ı��

for indexI = 1:length(relatePatchNum)   %% ���潫�α�֮��ı߽�߽��б���
    
    eval(['avePoint_', num2str(relatePatchNum(indexI)), ' = ', 'avePointSet{relatePatchNum(indexI),2}', ';']);
    eval(['save avePoint_', num2str(relatePatchNum(indexI)), '.mat', ' avePoint_', num2str(relatePatchNum(indexI)), ';']);
    
end

%%  Ϊ�˲��м��㣬�ѱ�����ֵժ���������ڲ�������

% newMeshSet          =       cell(17, 1);   %% ���
newAvePointSet      =       cell(17, 1);
newAveTanDir        =       cell(17, 1);

for indexI = 1:17
    
    %     eval(['load ', ' Mesh_', num2str(indexI), '.mat', ';']);   %% ����ԭʼ����
    %     eval(['newMeshSet{indexI} = Mesh_', num2str(indexI), ';']);
    eval(['load', ' avePoint_', num2str(indexI), '.mat', ';']);  %%  ������Ƭ�ľ��ֱ߽�
    eval(['newAvePointSet{indexI} = avePoint_', num2str(indexI), ';']);
    eval(['load', ' aveTanDir_', num2str(indexI), '.mat', ';']);   %% ������ֱ߽��Ӧ������
    eval(['newAveTanDir{indexI} = aveTanDir_', num2str(indexI), ';']);
    
end


save newAvePointSet.mat newAvePointSet
save newAveTanDir.mat newAveTanDir

%% ������ĺ�ľ��ֵ�����
%
% cd '..\StroNewAvePtForAddedCtLine'
% for indexI = 1:17
%
%     eval(['save PtMatrix_', num2str(indexI), '.txt', ' PtMatrix_', num2str(indexI), ' -ascii', ';'])
%     eval(['save avePoint_', num2str(indexI), '.mat', ' avePoint_', num2str(indexI), ';'])
%     %%% �����߽�����
%     eval(['save aveTanDir_', num2str(indexI), '.mat', ' aveTanDir_', num2str(indexI), ';']);
%
% end
%
%
% cd '..\MainFcnFile'  %% ���ص�ǰĿ¼


%% ���ݵ��룬���м��㣬���ұ�����
aveValue = 10;

% meshOrderSet    =      xlsread('meshOrderAndPdePara.xlsx',2);     %% ��Ƭ��ŵļ����������ݰ���������Ƭ��������Ƭ����Ƭ���
paraSet         =      xlsread('meshOrderAndPdePara.xlsx',1);    %% ����ÿ�����������PDE��������Щ����Ϊԭʼ��Ƭ����������

%%% -----------------------------------------------------------------------
%%%  �жϲ���pool�ǲ��ǹر���

global poolStates
try 
    
    isequal(poolStates.Connected, 1);
    
catch
    
    delete(gcp('nocreate'))   %% ��ֹ������ǰ�رղ����д򿪵�worker
    c = parcluster;
    poolStates  =  parpool(c);
    
end
%--------------------------------------------------------------------------


parfor indexI = 1:length(relatePatchNum)
    middleMeshNum          =    relatePatchNum(indexI);
    
    %     meshOrderSet    =      xlsread('meshOrderAndPdePara.xlsx',2);     %% ��Ƭ��ŵļ����������ݰ���������Ƭ��������Ƭ����Ƭ���
    %     meshOrder       =      meshOrderSet(middleMeshNum, :);    %%   ������Ƭ����������Ƭ����
    %     meshOrder(find(isnan(meshOrder))) = [];    %% ����û��������Ƭ�Ĳ����ÿ�
    %     currentSheet    =      meshOrder;
    
    %     paraSet         =      xlsread('meshOrderAndPdePara.xlsx',1);    %% ����ÿ�����������PDE��������Щ����Ϊԭʼ��Ƭ����������
    Para            =      paraSet(middleMeshNum,:);        %% ��ȡ������Ƭ��PDE������Ϊһ��1*3�ľ��󣬺���д���Ż��㷨�еĻ��Ϳ������ó������������Ż�
    
    
    %%%   �˴����벻���У����ײ���λ�õ��α�
    %     if relatePatchNum(indexI) == bdDirDefNum
    %            ParaSet = [ -0.4271   -5.6914    0.0409;    %%  �����бȽϺõļ������
    %                  -0.7971   -5.3416   -0.2802;
    %                  -0.4488   -7.5946   -0.6791;
    %                  -0.7860   -6.3685   -0.1330;
    %                  -0.1562   -7.2740   -0.7545;
    %                  -0.9558   -1.9809   -0.0615;
    %                  -0.0628   -7.8013   -0.0200;
    %                  -0.2461   -5.4255   -0.3331;
    %                  -0.0637   -7.0352   -1.3739;
    %                  -0.2328   -7.7572   -0.2328;
    %                  -0.1305   -5.3329   -0.7499;
    %                  -0.7997   -3.1989   -2.4150;%% ������һ��
    %                  -0.0366   -3.2752   -1.6533];
    %
    %         Para   =  ParaSet(randi(8,1), :)
    %         Para = [-0.0628   -7.8013   -0.0200];
    %     else
    %         Para        =      paraSet(middleMeshNum,:);        %% ��ȡ������Ƭ��PDE������Ϊһ��1*3�ľ��󣬺���д���Ż��㷨�еĻ��Ϳ������ó������������Ż�
    %     end
    
    
    %     middleMesh     =      newMeshSet{middleMeshNum};
    avePoint       =      newAvePointSet{middleMeshNum};
    boundTan       =      newAveTanDir{middleMeshNum};
    
    if middleMeshNum == bdDirDefNum
        
        deformMeshPt = DiffDirMiddleGeneration(Para, avePoint,...
            boundTan, middleMeshNum, aveValue);   %% ���PDEʱ�õ����߲�һ��
        
    else
        defPtMatrix = MiddleGeneration(Para, avePoint,...
            boundTan, middleMeshNum, aveValue);   %% three dimesional Matrix
    end
    
end
%% ���������Ƭ


ptMatrix = [];
for index = 1:17
    
    eval(['load PtMatrix_', num2str(index), '.txt']);   %% ����δ�α����Ƭ��
    eval(['ptMatrix = [ptMatrix; PtMatrix_', num2str(index), '];']);
    
end
%%% �ȶ���Χ�������߽��ж��壬�������εı߽�����ϵ����ֱ���޸�

% deformExtendCountLineSet =    [boundAttachToA1_F1{2,2}; boundAttachToA4_F4{2,2}; boundAttachToA1_O1_A3{2,2}; boundAttachToA3_A4{2,2}];
% load deformExtendCountLineSet.mat

%%% �ж��������Ƿ�������ص�
if strcmp(countLineAttachBd{2,1}, 'A1_F1')
    deformExtendCountLine    =    boundMotivation(countLineAttachBd{2,2}, aixsT, deltT);   %% ֻ��A1_F1��A4_F4��A1_O1_A3���д���
    %     deformExtendCountLineSet =    [deformExtendCountLine; boundAttachToA4_F4{2,2}; boundAttachToA1_O1_A3{2,2}; boundAttachToA3_A4{2,2}];
    deformExtendCountLineSet(1:length(deformExtendCountLine), :) = deformExtendCountLine;
    
elseif strcmp(countLineAttachBd{2,1}, 'A4_F4')
    deformExtendCountLine    =    boundMotivation(countLineAttachBd{2,2}, aixsT, deltT);   %% ֻ��A1_F1��A4_F4��A1_O1_A3���д���
    %     deformExtendCountLineSet =    [boundAttachToA1_F1{2,2}; deformExtendCountLine; boundAttachToA1_O1_A3{2,2}; boundAttachToA3_A4{2,2}];
    deformExtendCountLineSet(length(boundAttachToA1_F1{2,2})+1:length(boundAttachToA1_F1{2,2})+length(deformExtendCountLine), :) = deformExtendCountLine;
elseif strcmp(countLineAttachBd{2,1}, 'A1_O1_A3')
    deformExtendCountLine    =    boundMotivation(countLineAttachBd{2,2}, aixsT, deltT);   %% ֻ��A1_F1��A4_F4��A1_O1_A3���д���
    %     deformExtendCountLineSet =    [boundAttachToA1_F1{2,2}; boundAttachToA4_F4{2,2}; deformExtendCountLine; boundAttachToA3_A4{2,2}];
    deformExtendCountLineSet(length(boundAttachToA1_F1{2,2})+length(boundAttachToA4_F4{2,2})+1:length(boundAttachToA1_F1{2,2})+...
        length(boundAttachToA4_F4{2,2})+length(deformExtendCountLine), :) = deformExtendCountLine;
    
elseif strcmp(countLineAttachBd{2,1}, 'A3_A4')
    deformExtendCountLine    =    boundMotivation(countLineAttachBd{2,2}, aixsT, deltT);   %% ֻ��A1_F1��A4_F4��A1_O1_A3���д���
    %     deformExtendCountLineSet =    [boundAttachToA1_F1{2,2}; boundAttachToA4_F4{2,2}; boundAttachToA1_O1_A3{2,2}; deformExtendCountLine];
    deformExtendCountLineSet(length(boundAttachToA1_F1{2,2})+length(boundAttachToA4_F4{2,2})+length(boundAttachToA1_O1_A3{2,2})+1:length(boundAttachToA1_F1{2,2})+...
        length(boundAttachToA4_F4{2,2})+length(boundAttachToA1_O1_A3{2,2})+length(deformExtendCountLine), :) = deformExtendCountLine;
end


%% ������ĺ�ľ��ֵ�����
cd '..\StroNewAvePtForAddedCtLine'  % ���µ����ݱ�������������Ҫ���õ�
for indexI = 1:17
    
    eval(['save PtMatrix_', num2str(indexI), '.txt', ' PtMatrix_', num2str(indexI), ' -ascii', ';'])
    eval(['save avePoint_', num2str(indexI), '.mat', ' avePoint_', num2str(indexI), ';'])
    %%% �����߽�����
    eval(['save aveTanDir_', num2str(indexI), '.mat', ' aveTanDir_', num2str(indexI), ';']);
    
end


save newAvePointSet.mat newAvePointSet
save newAveTanDir.mat newAveTanDir

save deformExtendCountLineSet.mat deformExtendCountLineSet

cd '..\MainFcnFile'  %% ���ص�ǰĿ¼

%%
ptMatrix = 0.1 * [ptMatrix; boundAttachToF1_F4{2,2}; threeExtPt; deformExtendCountLineSet]; %% Maya����ʱ�����ݱ��Ŵ󣬴˴δ�Ϊ��������С

halfTrainHead = ptMatrix;
save halfTrainHead.txt halfTrainHead  -ascii

%% ����stl��ʽ�ļ�

% load selectPointIndex.mat
% load ObjFacesIndex.mat
% stlSavePath = '..\threeStlParts';    %% �������stl��ʽģ�͵��ļ�����ʱ��ǵø�·��
%
% trainHeadPt = ptMatrix(selectPointIndex, :);
%
% stlwrite('trainHead.stl', FaceIndex, trainHeadPt)  %% ����ͷ��stl�ļ�
% movefile('trainHead.stl',stlSavePath)  %% ��ͷ��stl��ʽ�ļ����浽ָ��λ��



% obj_write('trainHead.obj', trainHeadPt, FaceIndex )
% movefile('trainHead.obj', stlSavePath)  %% ��ͷ��stl��ʽ�ļ����浽ָ��λ��


% save ptMatrix.txt ptMatrix -ascii
% hold on; scatter3(ptMatrix(:,1), ptMatrix(:,2), ptMatrix(:,3), 'filled')
% xlabel('X');ylabel('Y');zlabel('Z')
% axis equal
%}

% figure(2)
% hold on; scatter3(ptMatrix(:,1), ptMatrix(:,2), ptMatrix(:,3), 'filled')
% xlabel('X');ylabel('Y');zlabel('Z')
% axis equal
% %
% figure(2)
% load PatchIndex_9.mat
% load PatchIndex.mat
% load PtMatrix_9.txt
%
% PatchOrder = PtMatrix_9(PatchIndex_9,:);
% hold on; trisurf(PatchIndex, PatchOrder(:,1), PatchOrder(:,2), PatchOrder(:,3)); axis equal




