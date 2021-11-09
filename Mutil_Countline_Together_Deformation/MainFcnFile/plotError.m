function plotError(Para)
a1 = Para(1);
a2 = Para(2);
a3 = Para(3);

%%  从base内存中导入共用变量
origVertAvePt     = evalin('base','origVertAvePt');
aveValue          = evalin('base','aveValue');
avePoint          = evalin('base','avePoint');
aveTanDir         = evalin('base','aveTanDir');
A                 = evalin('base','A');
boundIndex        = evalin('base','boundIndex');
innerAvePt        = evalin('base','innerAvePt');
alpha             = evalin('base','alpha');
noExPtMatrix      = evalin('base','noExPtMatrix');
extractB          = evalin('base','extractB');
X                 = evalin('base','X');
Y                 = evalin('base','Y');
Z                 = evalin('base','Z');
minBondLength     = evalin('base','minBondLength');

finitAvePt = zeros(aveValue+1,aveValue+1,3);     %% 三维坐标系保存PDE解的三个维度值以及面片索引
err = zeros(aveValue+1,aveValue+1);

transMatrix = solvePDE(avePoint,aveTanDir,A, boundIndex, innerAvePt, alpha,noExPtMatrix,extractB,aveValue,a1, a2, a3);


transMatrixX    =    transMatrix{1};
transMatrixY    =    transMatrix{2};
transMatrixZ    =    transMatrix{3};
PtMatrix = zeros(size(transMatrixX,1)*size(transMatrixX,2),3);
for i = 1:size(transMatrixX,1)
    for j = 1:size(transMatrixX,2)
        finitAvePt(i,j,1) = transMatrixX(i,j);
        finitAvePt(i,j,2) = transMatrixY(i,j);
        finitAvePt(i,j,3) = transMatrixZ(i,j);
        PtMatrix((i-1)*size(transMatrixX,2)+ j,1) = transMatrixX(i,j);
        PtMatrix((i-1)*size(transMatrixX,2)+ j,2) = transMatrixY(i,j);
        PtMatrix((i-1)*size(transMatrixX,2)+ j,3) = transMatrixZ(i,j);
        err(i,j) = sqrt((finitAvePt(i,j,1)-origVertAvePt(i,j,1))^2 +...
            + (finitAvePt(i,j,2)-origVertAvePt(i,j,2))^2 +...
            + (finitAvePt(i,j,3)-origVertAvePt(i,j,3))^2);
    end
end
save finitAvePt.mat finitAvePt
save('PtMatrix.txt','PtMatrix','-ascii')
figure(2)
hold on;scatter3(X,Y,Z,'.r')
hold on;scatter3(reshape(finitAvePt(:,:,1),size(finitAvePt,1)*size(finitAvePt,2),1),...
    reshape(finitAvePt(:,:,2),size(finitAvePt,1)*size(finitAvePt,2),1), ...
     reshape(finitAvePt(:,:,3),size(finitAvePt,1)*size(finitAvePt,2),1),'b*')
hold on;plot3(avePoint(:,1),avePoint(:,2),avePoint(:,3),'-b')
 figure(3)
hold on; plot(err)

maxErr = max(max(err));
percentMaxErr = max(max(err))/minBondLength;
meanErr = sum(sum(err))/(size(err,1)*size(err,2));
str1 = ['当  a1 = ', num2str(a1),', a2 = ', num2str(a2), ', a3 = ',num2str(a3),' 时','  maxErr = ',num2str(maxErr),'  meanErr = ',num2str(meanErr)];
str2 = ['最大误差和最小边长的比值为： ',num2str(percentMaxErr*100),'%'];
disp(str1)
disp(str2)