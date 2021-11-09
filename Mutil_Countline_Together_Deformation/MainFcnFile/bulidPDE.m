%%%--------------The function to solve PDE question----------%%%
%%%--------------Robin----------------%%%
%%%------------ 20160306 -------------%%%
%%% aveValue = 10 �������ڱ߽���11����
%%% ���ǰ�ÿ���ߵı߽���������֮��ֱ�õ�13����,���� N=13������N*N������Ȼ��
%%% ȥ������ַ��̣����������ַ��̵Ľ�
function [A, boundIndex, innerAvePt, alpha, extPoint,noExPtMatrix,extractB] = bulidPDE(aveValue)
% % %     aveValue = 10;
% % %     a1 = 1; a2 = 1; a3 = 1;
syms a1 a2 a3;
char axisString;     %% ����Ҫ��x��y��z�᷽������ֳ̣�axisString��ʾ���Ǿ���ķ�����
axisString = 'x';
N = aveValue+1+2;       %% ���ֵ�ĸ���ΪaveValue+1���������һ�����ص㣬���Թ��� aveValue+1+2�����ܲ���N*N������
alpha = sym(zeros(N*N-4,1));    %% �洢���ǲ����ı���������Ҫȥ���ĸ����㣬��Ϊ���ǽ�����ַ��̵�ʱ������û���õ������˵��ĸ����񶥵�
axisIndex = zeros(N,N);         %%  N*N����������,��0��N*N-1
axisMatrix = sym(zeros(N,N));   %%  �洢���񶥵��Ӧ�ı������
equExpression = sym(zeros(N*N-4,1));   %%  �洢���ǽ����ķ���
% % %         aveTanDirU = rand(40,1);
% % %         aveTanDirV = rand(40,1);
% % %         aveBoundaryMatrix = rand(40,1);
%% �������񶥵��Ӧ����ź����񶥵��Ӧ�ı���
for i = (N-1):-1:0
    for j = 0:(N-1)
        axisIndex(N-i,j+1) = i*N + j;
        eval([ 'syms ', axisString, num2str(i*N + j)]);      %% ��������
        axisMatrix(N-i,j+1) = strcat(axisString,num2str(i*N + j));   %% �Ѳ����ı����Ž�����axisMatrix��ȥ
    end
end
noExPtMatrix = axisMatrix;
noExPtMatrix(1,:) = []; noExPtMatrix(end,:) = []; noExPtMatrix(:,1) = []; noExPtMatrix(:,end) = [];

%% �����еı����洢��һ���о���alpha��ȥ
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


%%% ���е����ص�ŵ�һ�����һ������
extPoint = [conj(axisMatrix(size(axisMatrix,1),:)');axisMatrix(2:size(axisMatrix,1)-1,size(axisMatrix,2));conj(axisMatrix(1,:)');axisMatrix(2:size(axisMatrix,1)-1,1)];


% for i = 1:length(innerAvePt)
%     if ~isempty(find(extPoint == innerAvePt(i), 1 ))   %% ����innerAvePt���޳��������ص��Ӧ�ı������������Ǻ�����ʾ���ʱ��ֱ����ʾ
%         innerAvePt(i) = pi;
%     end
% end
% innerAvePt(innerAvePt == pi) = [];


%% �������ص�ķ���
%%% Warning��������ĸ�������û���õģ������ڽ������̵�ʱ��Ҫ���ĸ�����ı�������ֵ

%%% �±߽����ص㷽�̵Ľ���
for j = 2:(N-1)
    equExpression(j-1,1) = axisMatrix(N-2,j) - axisMatrix(N,j);
    %     b(j-1,1) = aveTanDirV(j-1,1)*(2*deltaV);
end
%%% �ұ߽����ص㷽�̵Ľ���
t = 0;
for i = (N-1):-1:2
    equExpression((N-2)+1+t,1) = axisMatrix(i,N) - axisMatrix(i,N-2);
    %     b((N-2)+1+t,1) = aveTanDirU((N-2)+t,1)*(2*deltaU);
    t = t + 1;
end
%%% �ϱ߽����ص㷽�̵Ľ���
t = 0;
for j = (N-1):-1:2
    equExpression(2*(N-2)+(t+1),1) = axisMatrix(1,j) - axisMatrix(3,j);
    %     b(2*(N-2)+(t+1),1) = aveTanDirV(2*(N-2)-1+t,1)*(2*deltaV);
    t = t + 1;
end
%%% ��߽����ص㷽�̵Ľ���
t = 0;
for  i = 2:(N-2)
    equExpression(3*(N-2)+1+t,1) = axisMatrix(i,3) - axisMatrix(i,1);
    %     b(3*(N-2)+1+t,1) = aveTanDirU(3*(N-2)-2+t,1)*(2*deltaU);
    t = t + 1;
end
% % % aveTanDir = zeros(44,1);
equExpression(3*(N-2)+1+aveValue,1) = axisMatrix(N-1,3) - axisMatrix(N-1,1);
% b(3*(N-2)+aveValue+1,1) = aveTanDirU(1,1)*(2*deltaU);

%%  �߽��ڲ����ַ��̵Ľ���
%%% �������Ľ׵Ĳ�ֹ�ʽչ���Ľ�ƫ΢�ַ��̣�Ȼ��Ա߽��ڲ��㽨������
t = 1;
for i = (N-2):-1:3
    for j = 3:(N-2)
        %%% ���Ľײ�ַ��̸��߽��ڲ��ĵ㽨������
        equExpression(3*N+5+t,1)= (6*a1+4*a2+6*a3)*axisMatrix(i,j)+(-4*a1-2*a2)*axisMatrix(i,j+1)+(-2*a2-4*a3)*axisMatrix(i-1,j)+ ...
            +(-4*a1-2*a2)*axisMatrix(i,j-1)+(-2*a2-4*a3)*axisMatrix(i+1,j)+a2*axisMatrix(i+1,j+1)+a2*axisMatrix(i-1,j+1)+ ...
            + a2*axisMatrix(i-1,j-1)+a2*axisMatrix(i+1,j-1)+a1*axisMatrix(i,j+2)+a3*axisMatrix(i-2,j)+ ...
            +a1*axisMatrix(i,j-2)+a3*axisMatrix(i+2,j);
        t = t + 1;
    end
end
equExpression(equExpression(:, 1)==0, :) = [];   %% �Ѷ��������ȥ��

%% ��ȡδ֪����ϵ�����ҷŵ���Ӧ�ľ�����ȥ���������ֿ��߽��������Ϊ�߽��ֵ��������֪��

boundIndex = [conj(axisMatrix(N-1,2:(N-1))'); axisMatrix((N-2):-1:2,N-1); conj(axisMatrix(2,(N-2):-1:2)'); axisMatrix((3:N-2),2)];
Atemp = cell(length(equExpression),length(alpha));   %% �洢�Ǳ߽������ϵ��
extractB = sym(zeros(N*N-4,1));  %% �洢���ʽ�б߽��Ӧ����
XXX = zeros(length(equExpression),length(alpha));

for j = 1:length(alpha)
    Xtemp = ~isempty(find(boundIndex == alpha(j,1), 1)) ;
    for i = 1:length(equExpression)
        XXX(i,j) = Xtemp &&  diff(equExpression(i,1),alpha(j,1)) ~= 0;
    end
end

parfor i = 1:length(equExpression)
    for j = 1:length(alpha)
        %%% ����ڷ��̱��ʽ�к��б߽��������ô�Ͱѱ߽�ı����ӵ�extractB��ȥ�������δ֪����ϵ����ֵ��Atemp��Ӧ��λ����ȥ
        %%% ��Ϊ���ǵı�������һ�׵ģ���������һ��ƫ��������ȡϵ��
        if   XXX(i,j)
            extractB(i,1) = extractB(i,1) + diff(equExpression(i,1),alpha(j,1))* alpha(j,1);
        else
            Atemp{i}(j) = diff(equExpression(i,1),alpha(j,1));
        end
    end
end

%%% ǰ���Atemp��һ���ṹ�壬���ǰ�����ֵ��double���͵�A��ȥ
A = sym(zeros(length(equExpression),length(alpha)));
for i = 1:length(equExpression)
    for j = 1:length(alpha)
        A(i,j) = Atemp{i}(j);
    end
end
%%% �����߽������ȥ��alpha�еı߽�������Լ�A�еı߽������Ӧ����һ�У�
%%% ��Ϊ���ǵ�A����������ʱ���ǰ������Ա����Ķ�����������
for i = 1:length(alpha)
    if ~isempty(find(boundIndex == alpha(i), 1))
        alpha(i,1) = pi;     %% �ȸ����������ֵ��Ȼ�����ں�߽����ÿմ���
        A(:,i) = pi;
    end
end
A(:,A(1,:)==pi) = [];
alpha(alpha == pi) = [];
innerAvePt = alpha;    %%   ��Ϊ�ں���ļ�����alpha��ά���ͱ�����λ�ûᷢ���䶯��������innerAvePt��¼ԭʼ��alpha