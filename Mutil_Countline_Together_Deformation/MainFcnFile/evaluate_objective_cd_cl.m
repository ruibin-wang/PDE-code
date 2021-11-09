% function f = evaluate_objective(x, M, V)
function  [totalTrCoffCd, trTailCoffCl] = evaluate_objective_cd_cl(x)


%% ����ICEM�ű���fluent�ű�
% scriptPath = '../../../../Script';
% 
% movefile('fluentopt.bat',scriptPath)   %% 
% movefile('fluentScript',scriptPath)   %% 
% movefile('wholeTrain.stl',scriptPath)   %% 

cd '../../Script'
% delete cd-1-history cl-1-history   %% �ڽű���û�������������ļ���������ɵĻ�������Ҫɾ��

%% ���ݱ���
% ----------------------------------------------------------------------------------
cd '../IcemGenerateMesh'   %% fluent�����icem�������ͬһ���ļ����£��ڴ˶�ȡ����
DragSavePath    = '../Mutil_Countline_Together_Deformation/MainFcnFile';  %% �л�������Ŀ¼

movefile('Drag', DragSavePath)  %% ��fluent����õ�Drag����������Ŀ¼��

cd '../Mutil_Countline_Together_Deformation/MainFcnFile';

[totalTrCoffCd, trTailCoffCl] = ReadFluentFiles;
