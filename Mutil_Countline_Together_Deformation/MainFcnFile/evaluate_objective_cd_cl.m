% function f = evaluate_objective(x, M, V)
function  [totalTrCoffCd, trTailCoffCl] = evaluate_objective_cd_cl(x)


%% 运行ICEM脚本和fluent脚本
% scriptPath = '../../../../Script';
% 
% movefile('fluentopt.bat',scriptPath)   %% 
% movefile('fluentScript',scriptPath)   %% 
% movefile('wholeTrain.stl',scriptPath)   %% 

cd '../../Script'
% delete cd-1-history cl-1-history   %% 在脚本中没有生成这两个文件，如果生成的话，就需要删除

%% 数据保存
% ----------------------------------------------------------------------------------
cd '../IcemGenerateMesh'   %% fluent计算和icem网格放在同一个文件夹下，在此读取数据
DragSavePath    = '../Mutil_Countline_Together_Deformation/MainFcnFile';  %% 切换至工作目录

movefile('Drag', DragSavePath)  %% 将fluent计算得的Drag拷贝到工作目录下

cd '../Mutil_Countline_Together_Deformation/MainFcnFile';

[totalTrCoffCd, trTailCoffCl] = ReadFluentFiles;
