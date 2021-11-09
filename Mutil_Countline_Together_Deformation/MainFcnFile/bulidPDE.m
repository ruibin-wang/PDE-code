%%%--------------The function to solve PDE question----------%%%
%%%--------------Robin----------------%%%
%%%------------ 20160306 -------------%%%
%%% aveValue = 10 ，所以在边界有11个点
%%% 我们把每个边的边界点进行延拓之后分别得到13个点,所以 N=13，产生N*N的网格，然后
%%% 去建立差分方程，并且求出差分方程的解
function [A, boundIndex, innerAvePt, alpha, extPoint,noExPtMatrix,extractB] = bulidPDE(aveValue)
% % %     aveValue = 10;
% % %     a1 = 1; a2 = 1; a3 = 1;
syms a1 a2 a3;
char axisString;     %% 我们要在x，y，z轴方向建立差分程，axisString表示的是具体的方向轴
axisString = 'x';
N = aveValue+1+2;       %% 均分点的个数为aveValue+1，两侧各有一个延拓点，所以共有 aveValue+1+2个，能产生N*N的网格
alpha = sym(zeros(N*N-4,1));    %% 存储我们产生的变量，不过要去掉四个顶点，因为我们建立差分方程的时候我们没有用到延拓了的四个网格顶点
axisIndex = zeros(N,N);         %%  N*N网格点的索引,从0到N*N-1
axisMatrix = sym(zeros(N,N));   %%  存储网格顶点对应的变量序号
equExpression = sym(zeros(N*N-4,1));   %%  存储我们建立的方程
% % %         aveTanDirU = rand(40,1);
% % %         aveTanDirV = rand(40,1);
% % %         aveBoundaryMatrix = rand(40,1);
%% 产生网格顶点对应的序号和网格顶点对应的变量
for i = (N-1):-1:0
    for j = 0:(N-1)
        axisIndex(N-i,j+1) = i*N + j;
        eval([ 'syms ', axisString, num2str(i*N + j)]);      %% 产生变量
        axisMatrix(N-i,j+1) = strcat(axisString,num2str(i*N + j));   %% 把产生的变量放进矩阵axisMatrix中去
    end
end
noExPtMatrix = axisMatrix;
noExPtMatrix(1,:) = []; noExPtMatrix(end,:) = []; noExPtMatrix(:,1) = []; noExPtMatrix(:,end) = [];

%% 把所有的变量存储在一个列矩阵alpha中去
for i = 0:(N-1)
    if i == 0
        for   j = 1:(N-2)
            alpha(i*N + j,1) = strcat(axisString,num2str(i*N + j));
        end
    elseif i == N-1
        for j = 1:(N-2)
            alpha(i*N + j-2,1) = strcat(axisString,num2str(i*N + j));
        end
    else
        for j =0:(N-1)
            alpha(i*N + j-1,1) = strcat(axisString,num2str(i*N + j));
        end
    end
end


%%% 所有的延拓点放到一起组成一个矩阵
extPoint = [conj(axisMatrix(size(axisMatrix,1),:)');axisMatrix(2:size(axisMatrix,1)-1,size(axisMatrix,2));conj(axisMatrix(1,:)');axisMatrix(2:size(axisMatrix,1)-1,1)];


% for i = 1:length(innerAvePt)
%     if ~isempty(find(extPoint == innerAvePt(i), 1 ))   %% 遍历innerAvePt，剔除其中延拓点对应的变量，这样我们后面显示点的时候直接显示
%         innerAvePt(i) = pi;
%     end
% end
% innerAvePt(innerAvePt == pi) = [];


%% 建立延拓点的方程
%%% Warning：网格的四个顶点是没有用的，所以在建立方程的时候要给四个顶点的变量赋空值

%%% 下边界延拓点方程的建立
for j = 2:(N-1)
    equExpression(j-1,1) = axisMatrix(N-2,j) - axisMatrix(N,j);
    %     b(j-1,1) = aveTanDirV(j-1,1)*(2*deltaV);
end
%%% 右边界延拓点方程的建立
t = 0;
for i = (N-1):-1:2
    equExpression((N-2)+1+t,1) = axisMatrix(i,N) - axisMatrix(i,N-2);
    %     b((N-2)+1+t,1) = aveTanDirU((N-2)+t,1)*(2*deltaU);
    t = t + 1;
end
%%% 上边界延拓点方程的建立
t = 0;
for j = (N-1):-1:2
    equExpression(2*(N-2)+(t+1),1) = axisMatrix(1,j) - axisMatrix(3,j);
    %     b(2*(N-2)+(t+1),1) = aveTanDirV(2*(N-2)-1+t,1)*(2*deltaV);
    t = t + 1;
end
%%% 左边界延拓点方程的建立
t = 0;
for  i = 2:(N-2)
    equExpression(3*(N-2)+1+t,1) = axisMatrix(i,3) - axisMatrix(i,1);
    %     b(3*(N-2)+1+t,1) = aveTanDirU(3*(N-2)-2+t,1)*(2*deltaU);
    t = t + 1;
end
% % % aveTanDir = zeros(44,1);
equExpression(3*(N-2)+1+aveValue,1) = axisMatrix(N-1,3) - axisMatrix(N-1,1);
% b(3*(N-2)+aveValue+1,1) = aveTanDirU(1,1)*(2*deltaU);

%%  边界内部点差分方程的建立
%%% 我们用四阶的差分公式展开四阶偏微分方程，然后对边界内部点建立方程
t = 1;
for i = (N-2):-1:3
    for j = 3:(N-2)
        %%% 把四阶差分方程给边界内部的点建立方程
        equExpression(3*N+5+t,1)= (6*a1+4*a2+6*a3)*axisMatrix(i,j)+(-4*a1-2*a2)*axisMatrix(i,j+1)+(-2*a2-4*a3)*axisMatrix(i-1,j)+ ...
            +(-4*a1-2*a2)*axisMatrix(i,j-1)+(-2*a2-4*a3)*axisMatrix(i+1,j)+a2*axisMatrix(i+1,j+1)+a2*axisMatrix(i-1,j+1)+ ...
            + a2*axisMatrix(i-1,j-1)+a2*axisMatrix(i+1,j-1)+a1*axisMatrix(i,j+2)+a3*axisMatrix(i-2,j)+ ...
            +a1*axisMatrix(i,j-2)+a3*axisMatrix(i+2,j);
        t = t + 1;
    end
end
equExpression(equExpression(:, 1)==0, :) = [];   %% 把多余的零行去掉

%% 提取未知数的系数并且放到相应的矩阵中去，并且区分开边界变量，因为边界的值我们是已知的

boundIndex = [conj(axisMatrix(N-1,2:(N-1))'); axisMatrix((N-2):-1:2,N-1); conj(axisMatrix(2,(N-2):-1:2)'); axisMatrix((3:N-2),2)];
Atemp = cell(length(equExpression),length(alpha));   %% 存储非边界变量的系数
extractB = sym(zeros(N*N-4,1));  %% 存储表达式中边界对应变量
XXX = zeros(length(equExpression),length(alpha));

for j = 1:length(alpha)
    Xtemp = ~isempty(find(boundIndex == alpha(j,1), 1)) ;
    for i = 1:length(equExpression)
        XXX(i,j) = Xtemp &&  diff(equExpression(i,1),alpha(j,1)) ~= 0;
    end
end

parfor i = 1:length(equExpression)
    for j = 1:length(alpha)
        %%% 如果在方程表达式中含有边界变量，那么就把边界的变量加到extractB中去，否则把未知数的系数赋值到Atemp对应的位置中去
        %%% 因为我们的变量都是一阶的，所以用求一阶偏导代替提取系数
        if   XXX(i,j)
            extractB(i,1) = extractB(i,1) + diff(equExpression(i,1),alpha(j,1))* alpha(j,1);
        else
            Atemp{i}(j) = diff(equExpression(i,1),alpha(j,1));
        end
    end
end

%%% 前面的Atemp是一个结构体，我们把它赋值到double类型的A中去
A = sym(zeros(length(equExpression),length(alpha)));
for i = 1:length(equExpression)
    for j = 1:length(alpha)
        A(i,j) = Atemp{i}(j);
    end
end
%%% 遍历边界变量，去掉alpha中的边界变量，以及A中的边界变量对应的那一列，
%%% 因为我们的A矩阵声明的时候是按照所以变量的多少来声明的
for i = 1:length(alpha)
    if ~isempty(find(boundIndex == alpha(i), 1))
        alpha(i,1) = pi;     %% 先赋几个特殊的值，然后再在后边进行置空处理
        A(:,i) = pi;
    end
end
A(:,A(1,:)==pi) = [];
alpha(alpha == pi) = [];
innerAvePt = alpha;    %%   因为在后面的计算中alpha的维数和变量的位置会发生变动，所以用innerAvePt记录原始的alpha