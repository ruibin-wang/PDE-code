%%%--------------The function to solve PDE question----------%%%
%%%--------------Robin----------------%%%
%%%------------ 20160306 -------------%%%
%%% aveValue = 10 �������ڱ߽���11����
%%% ���ǰ�ÿ���ߵı߽���������֮��ֱ�õ�13����,���� N=13������N*N������Ȼ��
%%% ȥ������ַ��̣����������ַ��̵Ľ�
function transMatrix = solvePDE(avePoint,aveTanDir,AMatrix, boundIndex, innerAvePt, alphaInput,noExPtMatrix,extractB,aveValue,aa1, aa2, aa3)
% % % aa1 = 0.1;aa2 = 1.6;aa3 = 1.6;
% % % AMatrix = A;
alpha = alphaInput ;
delta = 1/aveValue;
syms a1 a2 a3;
N = aveValue+1+2;
b = zeros(N*N-4,1); %% �洢���߷���ͷ����еĳ������������Ҫ�ӵķ��̵���ʽΪ Ax = b

eval([char(a1),'=',num2str(aa1),';']);
eval([char(a2),'=',num2str(aa2),';']);
eval([char(a3),'=',num2str(aa3),';']);
AMatrix = eval(AMatrix);
transMatrix = cell(3,1);
for i = 1:3
    
    transAvePoint = avePoint(:,i);
    b(1:length(aveTanDir(:,i)),1) =  aveTanDir(:,i) *(2*delta);
%     b(1:length(aveTanDir(:,i)),1) =  aveTanDir(:,i) * 2;
    
    for j = 1:length(boundIndex)
        eval([char(boundIndex(j)),'=',num2str(transAvePoint(j)),';']);   %% Assign the boundary value to it's variable quantity
    end
    
    B = b - eval(extractB);    %% ��ΪextractB����ȡ������ϵ��������Ӧ�����������൱�����������
    B((length(alpha)+1):end) = [];   %% ȥ��������������

    coefficient = AMatrix\B;
    
    for k = 1:length(innerAvePt)
        eval([char(innerAvePt(k)),'=',num2str(coefficient(k)),';']);   %% Assign the boundary value to it's variable quantity
    end
   
    transMatrix{i} = eval(noExPtMatrix);
end