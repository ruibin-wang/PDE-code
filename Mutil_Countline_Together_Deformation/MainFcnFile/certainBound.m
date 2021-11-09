function  [downBd,rightBd,upBd,leftBd] = certainBound(transData,varMesh)
downBd  = varMesh(transData(end,:),:);
leftBd  = varMesh(transData(:,1),:);
upBd    = varMesh(transData(1,:),:);
rightBd = varMesh(transData(:,end),:);
