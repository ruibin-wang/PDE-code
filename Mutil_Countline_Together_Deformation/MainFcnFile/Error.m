% function err = Error(origVertAvePt, aveValue , avePoint , aveTanDir)
function maxErr = Error(Para)
a1 = Para(1);
a2 = Para(2);
a3 = Para(3);

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
minBondLength     = evalin('base','minBondLength');


finitAvePt = zeros(aveValue+1,aveValue+1,3);
err = zeros(aveValue+1,aveValue+1);


transMatrix = solvePDE(avePoint,aveTanDir,A, boundIndex, innerAvePt, alpha,noExPtMatrix,extractB,aveValue,a1, a2, a3);

transMatrixX    =    transMatrix{1};
transMatrixY    =    transMatrix{2};
transMatrixZ    =    transMatrix{3};

for i = 1:size(transMatrixX,1)
    for j = 1:size(transMatrixX,2)
        finitAvePt(i,j,1) = transMatrixX(i,j);
        finitAvePt(i,j,2) = transMatrixY(i,j);
        finitAvePt(i,j,3) = transMatrixZ(i,j);
        err(i,j) = sqrt((finitAvePt(i,j,1)-origVertAvePt(i,j,1))^2 +...
            + (finitAvePt(i,j,2)-origVertAvePt(i,j,2))^2 +...
            + (finitAvePt(i,j,3)-origVertAvePt(i,j,3))^2);
    end
end
maxErr = max(max(err))/minBondLength;


