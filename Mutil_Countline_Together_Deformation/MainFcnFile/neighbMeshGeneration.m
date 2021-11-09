function deformMeshPt = neighbMeshGeneration(neighbSheet, neighbMeshOrder, neighbPara, deformNeighbAvePoint, neighbBoundTanDir, aveValue)

for index = 1:length(neighbMeshOrder)
    % input some necessary variables
    eval(['load', ' Mesh_', num2str(neighbMeshOrder(index)), '.mat']);
    eval(['Mesh', num2str(index), ' = Mesh_', num2str(neighbMeshOrder(1)), ';']);
    if index == 1
        eval(['load', ' avePoint_', num2str(neighbSheet(1)), '.mat', ';']);
        eval(['load', ' aveTanDir_', num2str(neighbSheet(1)), '.mat', ';']);
        
        eval(['avePoint  = ', ' avePoint_', num2str(neighbSheet(1)), ';']);
        eval(['aveTanDir = ', ' aveTanDir_', num2str(neighbSheet(1)), ';']);
    end
end

% [A, boundIndex, innerAvePt, alpha1, ~, noExPtMatrix, extractB] = bulidPDE(aveValue);

load bulidPdeNetWork.mat   %% this is the global variables, so we have run 
                            % its function then save those useful variables,
                            % and this save a lot of time while the
                            % hardware is not very good

%%

a1 = neighbPara(1); a2 = neighbPara(2);  a3 = neighbPara(3);
transMatrix     =    solvePDE(deformNeighbAvePoint, neighbBoundTanDir, A, boundIndex, ...
                                  innerAvePt, alpha1, noExPtMatrix, extractB, aveValue, a1, a2, a3);   %% solve the PDE function
                                      % the output value of this function
                                      % is a cell, each row of this
                                      % variable present three axis
                                      % directions of those PDE points
                               
transMatrixX    =    transMatrix{1};
transMatrixY    =    transMatrix{2};
transMatrixZ    =    transMatrix{3};
deformMeshPt    =    zeros(aveValue+1,aveValue+1,3);     %%  three dimensional matrix to store the value of avePoint in differnt directions


for i = 1:size(transMatrixX,1)
    for j = 1:size(transMatrixX,2)
        deformMeshPt(i,j,1) = transMatrixX(i,j);
        deformMeshPt(i,j,2) = transMatrixY(i,j);
        deformMeshPt(i,j,3) = transMatrixZ(i,j);
    end
end


hold on;scatter3(reshape(deformMeshPt(:,:,1),size(deformMeshPt,1)*size(deformMeshPt,2),1),...
    reshape(deformMeshPt(:,:,2),size(deformMeshPt,1)*size(deformMeshPt,2),1), ...
    reshape(deformMeshPt(:,:,3),size(deformMeshPt,1)*size(deformMeshPt,2),1),'filled')

% xlabel('X axis')
% ylabel('Y axis')
% zlabel('Z axis')
