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
% In H. P. Schwefel and R. M鋘ner, editors, Parallel Problem Solving from
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

% controlPara = x(1:V);   %%  生成控制参数

controlPara = x(1:10);   %%  生成控制参数
% controlPara = zeros(1, 10);

% load solution.txt
% controlPara = solution(8, 1:10);

% -----------------------------------------
% 存放参数值
load generationParaSets.mat
generationParaSets = [generationParaSets; controlPara];
save generationParaSets.mat generationParaSets
% -----------------------------------------

countLineAttachBdSet(controlPara);  %% 生成轮廓线数据集
load selectPointIndex.mat
load FaceIndex.mat
load countLineAttachBdSets.mat  %% 存放形变轮廓线的字符,1-4列为横向轮廓线，5-9列为纵向轮廓线，10为鼻尖轮廓线，第二列为说明 

stlSavePath     = '..\threeStlParts';

%% 
load countLineAttachBdSets.mat
defCountLineSets    =    1:1:10;


for indexI = 1:length(defCountLineSets)
    
    %% 参数设定
    defCountLine        =     countLineAttachBdSets(defCountLineSets(indexI), :);
    countLineAttachBd   =     defCountLine{1,1};
    aixsT               =     defCountLine{1,2};
    deltT               =     defCountLine{1,3};
    bdDirDefNum         =     defCountLine{1,4};   %%  需要改变面片边界切线的面片编号，若为[]，则表示不进行边界切线方向改变
    deformAngle         =     defCountLine{1,5};   %%  参数系数为1时，表现为外凸，效果不错
    coff                =     defCountLine{1,6};   %%  参数系数，控制边界切线形变

    %% 求解生成一半的车头数据
    if indexI == 1
        halfTrainHead       =     CounterLineDeformation(countLineAttachBd, aixsT, deltT, bdDirDefNum, deformAngle, coff);  
    else
        halfTrainHead       =     CounterLineDeformationForAddedCountLine(countLineAttachBd, aixsT, deltT, bdDirDefNum, deformAngle, coff);  
    end
    
end

% delete(gcp('nocreate'))   %% 关闭并行中打开的worker

% hold on; scatter3(halfTrainHead(:,1), halfTrainHead(:,2), halfTrainHead(:,3), 'filled'); axis equal

%% 生成整车数据

wholeTrain         =    GeneratWholeTrainData(halfTrainHead);
save wholeTrain.txt wholeTrain -ascii

%% 绘图

load wholeTrainIndex.mat 

%% 存储成obj格式，生成整车模型

obj_write('wholeTrain.obj', wholeTrain, wholeTrainIndex)   %%  将数据点存储成obj格式

%% 生成头车  中间车  尾车stl模型
% cell{1,1} points index of the train head
% cell{1,2} faces index of these points
% cell{1,3} the value cell{1,2} would minus  

addedTriPatch = [wholeTrainIndex(3331,:); wholeTrainIndex(11579,:)];
wholeTrainIndex(3331,:)  =  [];  %% 生成网格面之后手动加上去的点面，在Geomagic中手动填充洞
wholeTrainIndex(11579,:) =  [];

   
load indexStroMatrix 
trainHeadPt         =        wholeTrain(indexStroMatrix{1,1}(1):indexStroMatrix{1,1}(2), :);  %% 按照索引得到头部点模型
trainHeadIndex      =        wholeTrainIndex(indexStroMatrix{1,2}(1):indexStroMatrix{1,2}(2)-1, :) - indexStroMatrix{1,3};  %%  头部点之间的网格信息

trainMiddlePt       =        wholeTrain(indexStroMatrix{2,1}(1):indexStroMatrix{2,1}(2), :);  %% 中间头型点
trainMiddleIndex    =        wholeTrainIndex(indexStroMatrix{2,2}(1)-1:indexStroMatrix{2,2}(2)-1, :) - indexStroMatrix{2,3};  %% 中间点之间的网格信息       

trainTailPt         =        wholeTrain(indexStroMatrix{3,1}(1):indexStroMatrix{3,1}(2), :);  %% 车尾点
trainTailIndex      =        wholeTrainIndex(indexStroMatrix{3,2}(1)-1:indexStroMatrix{3,2}(2)-2, :) - indexStroMatrix{3,3};  %% 车尾点之间的网格信息


stlwrite('trainTail.stl', trainHeadIndex, trainHeadPt)  %% 生成头型stl文件


stlwrite('trainMiddle.stl', trainMiddleIndex, trainMiddlePt)  %% 生成中间车stl文件
stlwrite('trainHead.stl', trainTailIndex, trainTailPt)    %% 生成尾车stl文件
stlwrite('wholeTrain.stl', wholeTrainIndex, wholeTrain)

movefile('trainHead.stl',stlSavePath)  %% 将头型stl格式文件保存到指定位置
movefile('trainMiddle.stl',stlSavePath)  %% 将中间车stl格式文件保存到指定位置
movefile('trainTail.stl',stlSavePath)   %% 将尾车stl格式文件保存到指定位置
movefile('wholeTrain.stl',stlSavePath)   %% 将尾车stl格式文件保存到指定位置


%% 运行ICEM脚本和fluent脚本
% scriptPath = '../../../../Script';
% 
% movefile('fluentopt.bat',scriptPath)   %% 
% movefile('fluentScript',scriptPath)   %% 
% movefile('wholeTrain.stl',scriptPath)   %% 

cd '../../Script'
% delete cd-1-history cl-1-history   %% 在脚本中没有生成这两个文件，如果生成的话，就需要删除
system('icemopt.bat')  %%  matlab调用icem脚本
system('fluentopt.bat') %%  matlab调用fluent脚本

%% 数据保存
% ----------------------------------------------------------------------------------
cd '../IcemGenerateMesh'   %% fluent计算和icem网格放在同一个文件夹下，在此读取数据

D=exist('Drag','file');
while D~=2
    D=exist('Drag','file');
end

pause(10)   %% 设置暂停，使得fluent完全关闭之后再进行复制文件的操作
DragSavePath    = '../Mutil_Countline_Together_Deformation/MainFcnFile';  %% 切换至工作目录

movefile('Drag', DragSavePath)  %% 将fluent计算得的Drag拷贝到工作目录下

cd '../Mutil_Countline_Together_Deformation/MainFcnFile';

[totalTrCoffCd, trTailCoffCl] = ReadFluentFiles;
delete Drag

% f(1)    =    totalTrCoffCd;    %% 目标函数值压力系数
% f(2)    =    abs(trTailCoffCl);     %% 目标函数值升力系数,通常情况下该值为负数，优化目标应为尾车升力值最小

% -------------------------------------------------------------------------------

%{

%% 删除文件，并且创建文件
cd '../Mutil_Countline_Together_Deformation/MainFcnFile'
% 
cd '../../'
% rmdir IcemGenerateMesh s   %% 删除文件夹
% mkdir IcemGenerateMesh     %% 创建文件夹 

delete('*.fbc', '*.fbc_old', '*.msh', '*.prj', '*.tin', '*.uns', '*.log')
% delete('Lift')

%}

cd '../../IcemGenerateMesh'
% rmdir IcemGenerateMesh s   %% 删除文件夹
% mkdir IcemGenerateMesh     %% 创建文件夹 

delete('*.fbc', '*.fbc_old', '*.msh', '*.prj', '*.tin', '*.uns', '*.log')
% delete('Lift')


cd '../Mutil_Countline_Together_Deformation/MainFcnFile'


% -----------------------------------------------------------------------------
toc





% %% Check for error
% if length(f) ~= M
%     error('The number of decision variables does not match you previous input. Kindly check your objective function');
% end


