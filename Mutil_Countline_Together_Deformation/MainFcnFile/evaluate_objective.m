% function f = evaluate_objective(x, M, V)
function  [totalTrCoffCd, trTailCoffCl] = evaluate_objective(x)
%% function f = evaluate_objective(x, M, V)
% Function to evaluate the objective functions for the given input vector
% x. x is an array of decision variables and f(1), f(2), etc are the
% objective functions. The algorithm always minimizes the objective
% function hence if you would like to maximize the function then multiply
% the function by negative one. M is the numebr of objective functions and
% V is the number of decision variables. 
%
% This functions is basically written by the user who defines his/her own
% objective function. Make sure that the M and V matches your initial user
% input. Make sure that the 
%
% An example objective function is given below. It has two six decision
% variables are two objective functions.

% f = [];
% %% Objective function one
% % Decision variables are used to form the objective function.
% f(1) = 1 - exp(-4*x(1))*(sin(6*pi*x(1)))^6;
% sum = 0;
% for i = 2 : 6
%     sum = sum + x(i)/4;
% end
% %% Intermediate function
% g_x = 1 + 9*(sum)^(0.25);
% 
% %% Objective function two
% f(2) = g_x*(1 - ((f(1))/(g_x))^2);

%% Kursawe proposed by Frank Kursawe.
% Take a look at the following reference
% A variant of evolution strategies for vector optimization.
% In H. P. Schwefel and R. M�nner, editors, Parallel Problem Solving from
% Nature. 1st Workshop, PPSN I, volume 496 of Lecture Notes in Computer 
% Science, pages 193-197, Berlin, Germany, oct 1991. Springer-Verlag. 
%
% Number of objective is two, while it can have arbirtarly many decision
% variables within the range -5 and 5. Common number of variables is 3.
% ----------------------------------------------------------------------------

% % % f = [];
% % % % Objective function one
% % % sum = 0;
% % % for i = 1 : V - 1
% % %     sum = sum - 10*exp(-0.2*sqrt((x(i))^2 + (x(i + 1))^2));
% % % end
% % % % Decision variables are used to form the objective function.
% % % f(1) = sum;
% % % 
% % % % Objective function two
% % % sum = 0;
% % % for i = 1 : V
% % %     sum = sum + (abs(x(i))^0.8 + 5*(sin(x(i)))^3);
% % % end
% % % % Decision variables are used to form the objective function.
% % % f(2) = sum;

% -------------------------------------------------------------------------------


%% My objective functions
tic
% -------------------------------------------------------------------------------

% controlPara = x(1:V);   %%  ���ɿ��Ʋ���

controlPara = x(1:10);   %%  ���ɿ��Ʋ���
% controlPara = zeros(1, 10);

% load solution.txt
% controlPara = solution(8, 1:10);

% -----------------------------------------
% ��Ų���ֵ
load generationParaSets.mat
generationParaSets = [generationParaSets; controlPara];
save generationParaSets.mat generationParaSets
% -----------------------------------------

countLineAttachBdSet(controlPara);  %% �������������ݼ�
load selectPointIndex.mat
load FaceIndex.mat
load countLineAttachBdSets.mat  %% ����α������ߵ��ַ�,1-4��Ϊ���������ߣ�5-9��Ϊ���������ߣ�10Ϊ�Ǽ������ߣ��ڶ���Ϊ˵�� 

stlSavePath     = '..\threeStlParts';

%% 
load countLineAttachBdSets.mat
defCountLineSets    =    1:1:10;


for indexI = 1:length(defCountLineSets)
    
    %% �����趨
    defCountLine        =     countLineAttachBdSets(defCountLineSets(indexI), :);
    countLineAttachBd   =     defCountLine{1,1};
    aixsT               =     defCountLine{1,2};
    deltT               =     defCountLine{1,3};
    bdDirDefNum         =     defCountLine{1,4};   %%  ��Ҫ�ı���Ƭ�߽����ߵ���Ƭ��ţ���Ϊ[]�����ʾ�����б߽����߷���ı�
    deformAngle         =     defCountLine{1,5};   %%  ����ϵ��Ϊ1ʱ������Ϊ��͹��Ч������
    coff                =     defCountLine{1,6};   %%  ����ϵ�������Ʊ߽������α�

    %% �������һ��ĳ�ͷ����
    if indexI == 1
        halfTrainHead       =     CounterLineDeformation(countLineAttachBd, aixsT, deltT, bdDirDefNum, deformAngle, coff);  
    else
        halfTrainHead       =     CounterLineDeformationForAddedCountLine(countLineAttachBd, aixsT, deltT, bdDirDefNum, deformAngle, coff);  
    end
    
end

% delete(gcp('nocreate'))   %% �رղ����д򿪵�worker

% hold on; scatter3(halfTrainHead(:,1), halfTrainHead(:,2), halfTrainHead(:,3), 'filled'); axis equal

%% ������������

wholeTrain         =    GeneratWholeTrainData(halfTrainHead);
save wholeTrain.txt wholeTrain -ascii

%% ��ͼ

load wholeTrainIndex.mat 

%% �洢��obj��ʽ����������ģ��

obj_write('wholeTrain.obj', wholeTrain, wholeTrainIndex)   %%  �����ݵ�洢��obj��ʽ

%% ����ͷ��  �м䳵  β��stlģ��
% cell{1,1} points index of the train head
% cell{1,2} faces index of these points
% cell{1,3} the value cell{1,2} would minus  

addedTriPatch = [wholeTrainIndex(3331,:); wholeTrainIndex(11579,:)];
wholeTrainIndex(3331,:)  =  [];  %% ����������֮���ֶ�����ȥ�ĵ��棬��Geomagic���ֶ���䶴
wholeTrainIndex(11579,:) =  [];

   
load indexStroMatrix 
trainHeadPt         =        wholeTrain(indexStroMatrix{1,1}(1):indexStroMatrix{1,1}(2), :);  %% ���������õ�ͷ����ģ��
trainHeadIndex      =        wholeTrainIndex(indexStroMatrix{1,2}(1):indexStroMatrix{1,2}(2)-1, :) - indexStroMatrix{1,3};  %%  ͷ����֮���������Ϣ

trainMiddlePt       =        wholeTrain(indexStroMatrix{2,1}(1):indexStroMatrix{2,1}(2), :);  %% �м�ͷ�͵�
trainMiddleIndex    =        wholeTrainIndex(indexStroMatrix{2,2}(1)-1:indexStroMatrix{2,2}(2)-1, :) - indexStroMatrix{2,3};  %% �м��֮���������Ϣ       

trainTailPt         =        wholeTrain(indexStroMatrix{3,1}(1):indexStroMatrix{3,1}(2), :);  %% ��β��
trainTailIndex      =        wholeTrainIndex(indexStroMatrix{3,2}(1)-1:indexStroMatrix{3,2}(2)-2, :) - indexStroMatrix{3,3};  %% ��β��֮���������Ϣ


stlwrite('trainTail.stl', trainHeadIndex, trainHeadPt)  %% ����ͷ��stl�ļ�


stlwrite('trainMiddle.stl', trainMiddleIndex, trainMiddlePt)  %% �����м䳵stl�ļ�
stlwrite('trainHead.stl', trainTailIndex, trainTailPt)    %% ����β��stl�ļ�
stlwrite('wholeTrain.stl', wholeTrainIndex, wholeTrain)

movefile('trainHead.stl',stlSavePath)  %% ��ͷ��stl��ʽ�ļ����浽ָ��λ��
movefile('trainMiddle.stl',stlSavePath)  %% ���м䳵stl��ʽ�ļ����浽ָ��λ��
movefile('trainTail.stl',stlSavePath)   %% ��β��stl��ʽ�ļ����浽ָ��λ��
movefile('wholeTrain.stl',stlSavePath)   %% ��β��stl��ʽ�ļ����浽ָ��λ��


%% ����ICEM�ű���fluent�ű�
% scriptPath = '../../../../Script';
% 
% movefile('fluentopt.bat',scriptPath)   %% 
% movefile('fluentScript',scriptPath)   %% 
% movefile('wholeTrain.stl',scriptPath)   %% 

cd '../../Script'
% delete cd-1-history cl-1-history   %% �ڽű���û�������������ļ���������ɵĻ�������Ҫɾ��
system('icemopt.bat')  %%  matlab����icem�ű�
system('fluentopt.bat') %%  matlab����fluent�ű�

%% ���ݱ���
% ----------------------------------------------------------------------------------
cd '../IcemGenerateMesh'   %% fluent�����icem�������ͬһ���ļ����£��ڴ˶�ȡ����

D=exist('Drag','file');
while D~=2
    D=exist('Drag','file');
end

pause(10)   %% ������ͣ��ʹ��fluent��ȫ�ر�֮���ٽ��и����ļ��Ĳ���
DragSavePath    = '../Mutil_Countline_Together_Deformation/MainFcnFile';  %% �л�������Ŀ¼

movefile('Drag', DragSavePath)  %% ��fluent����õ�Drag����������Ŀ¼��

cd '../Mutil_Countline_Together_Deformation/MainFcnFile';

[totalTrCoffCd, trTailCoffCl] = ReadFluentFiles;
delete Drag

% f(1)    =    totalTrCoffCd;    %% Ŀ�꺯��ֵѹ��ϵ��
% f(2)    =    abs(trTailCoffCl);     %% Ŀ�꺯��ֵ����ϵ��,ͨ������¸�ֵΪ�������Ż�Ŀ��ӦΪβ������ֵ��С

% -------------------------------------------------------------------------------

%{

%% ɾ���ļ������Ҵ����ļ�
cd '../Mutil_Countline_Together_Deformation/MainFcnFile'
% 
cd '../../'
% rmdir IcemGenerateMesh s   %% ɾ���ļ���
% mkdir IcemGenerateMesh     %% �����ļ��� 

delete('*.fbc', '*.fbc_old', '*.msh', '*.prj', '*.tin', '*.uns', '*.log')
% delete('Lift')

%}

cd '../../IcemGenerateMesh'
% rmdir IcemGenerateMesh s   %% ɾ���ļ���
% mkdir IcemGenerateMesh     %% �����ļ��� 

delete('*.fbc', '*.fbc_old', '*.msh', '*.prj', '*.tin', '*.uns', '*.log')
% delete('Lift')


cd '../Mutil_Countline_Together_Deformation/MainFcnFile'


% -----------------------------------------------------------------------------
toc





% %% Check for error
% if length(f) ~= M
%     error('The number of decision variables does not match you previous input. Kindly check your objective function');
% end


