%%%--------------The function to solve PDE question----------%%%
%%%--------------Robin----------------%%%
%%%------------ 20160306 -------------%%%
%%% aveValue = 10 ，所以在边界有11个点
%%% 我们把每个边的边界点进行延拓之后分别得到13个点,所以 N=13，产生N*N的网格，然后
%%% 去建立差分方程，并且求出差分方程的解
function transMatrix = DiffDirSolvePDE(avePoint,aveTanDir,AMatrix, boundIndex, innerAvePt, alphaInput,noExPtMatrix,extractB,aveValue,aa1, aa2, aa3)
% % % aa1 = 0.1;aa2 = 1.6;aa3 = 1.6;
% % % AMatrix = A;
alpha = alphaInput ;
delta = 1/aveValue;
syms a1 a2 a3;
N = aveValue+1+2;
b = zeros(N*N-4,1); %% 存储切线方向和方程中的常量，我们最后要接的方程的形式为 Ax = b

eval([char(a1),'=',num2str(aa1),';']);
eval([char(a2),'=',num2str(aa2),';']);
eval([char(a3),'=',num2str(aa3),';']);
AMatrix = eval(AMatrix);
transMatrix = cell(3,1);
for i = 1:3
    
    transAvePoint = avePoint(:,i);
%     b(1:length(aveTanDir(:,i)),1) =  aveTanDir(:,i) *(2*delta);
    b(1:length(aveTanDir(:,i)),1) =  aveTanDir(:,i) * 2;
    
    for j = 1:length(boundIndex)
        eval([char(boundIndex(j)),'=',num2str(transAvePoint(j)),';']);   %% Assign the boundary value to it's variable quantity
    end
    
    B = b - eval(extractB);    %% 因为extractB是提取出来的系数，所以应该做减法，相当于移项的作用
    B((length(alpha)+1):end) = [];   %% 去掉多声明的零行

    coefficient = AMatrix\B;
    
    for k = 1:length(innerAvePt)
        eval([char(innerAvePt(k)),'=',num2str(coefficient(k)),';']);   %% Assign the boundary value to it's variable quantity
    end
   
    transMatrix{i} = eval(noExPtMatrix);
end