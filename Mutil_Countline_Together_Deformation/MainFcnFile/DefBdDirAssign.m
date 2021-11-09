%%% 该函数用来匹配形变边界，和边界切线，目的是为了使相邻面片切线能同步发生改变
%%% 该函数源自getDeformMeshPt（）

function  DefBdDirAssign(bdDirDefNum, boundPt, boundTanDir)

paraSet         =      xlsread('meshOrderAndPdePara.xlsx',1);    %% The three parameters of PDE
meshOrderSet    =      xlsread('meshOrderAndPdePara.xlsx',2);    %% the order index of the Mesh
meshOrder       =      meshOrderSet(bdDirDefNum, :);
meshOrder(find(isnan(meshOrder))) = [];    %% put the NaN element of the matrix into null
currentSheet    =      meshOrder;

%% 因为相邻面片在处理时有误差，故而用不同的精确度来进行边的匹配
switch bdDirDefNum
    %     case
    case {1,2,3,4,5,6,7,8,9,10,11,13,14,16,17}
        precision = 6;
    case {12,15}
        precision = 7;
end

%%  判断边界边在相邻面片中的方向

for indexI = 1:length(meshOrder)
    
    eval(['load', ' Mesh_', num2str(meshOrder(indexI)), '.mat', ';']);
    
    eval(['Mesh', num2str(indexI), ' = Mesh_', num2str(meshOrder(1)), ';']);
    
    eval(['load', ' avePoint_', num2str(currentSheet(indexI)), ';']);
    
    eval(['load', ' aveTanDir_', num2str(currentSheet(indexI)), ';']);
    
    eval(['avePoint', num2str(indexI), ' = ', 'avePoint_', num2str(currentSheet(indexI)), ';']);
    
    if eval(['ismember(', 'eval(vpa(boundPt, ', num2str(precision),'))', ', eval(vpa(avePoint', num2str(indexI), ', ', num2str(precision), ')))'])    % to comfirm the neighbour deforming mesh
        
        neighbNum = meshOrder(indexI);
        eval(['comparaMatrix = ', 'ismember(', 'eval(vpa(avePoint_', num2str(neighbNum), ', ', num2str(precision),'))' ,', eval(vpa(boundPt, ', num2str(precision),'))', ')', ';']);   %%  find the index postion
        positionIndex =  find(comparaMatrix(:,1) == 1);     %% get the position index number of the bound in its neighbour mesh
        eval(['neighbAveBdPt = ', 'avePoint_', num2str(neighbNum), ';']);
        eval(['neighbBoundTanDir   =  ', ' aveTanDir_', num2str(neighbNum), ';']);    %%  put the value
        %         deformNeighbAvePoint  =  neighbAveBdPt;
        judgeMatrixFirstColum =  ismember(neighbAveBdPt, boundPt(1,:)); %% to find the position of the fist colum of boundPt
        judgeMatrixLastColum  =  ismember(neighbAveBdPt, boundPt(end,:));
        
        if find(judgeMatrixFirstColum(:,1) == 1) == 1 && find(judgeMatrixLastColum(:,1) == 1) == 11
            
            %             deformNeighbAvePoint(positionIndex,:) = deformBound;   %%  the average boundary points of the neighbour mesh
            neighbBoundTanDir(1:11, :)  =   -boundTanDir;   %%  the boundary tangents of the neighbour mesh is opposite to the current one
            %%% 切线方向与相邻面片切线方向相反
        elseif find(judgeMatrixFirstColum(:,1) == 1) == 11 && find(judgeMatrixLastColum(:,1) == 1) == 1
            % flipud
            
            %             deformNeighbAvePoint(positionIndex,:) = flipud(deformBound);
            neighbBoundTanDir(1:11, :)  =   - flipud(boundTanDir);
            
        elseif find(judgeMatrixFirstColum(:,1) == 1) == 11 && find(judgeMatrixLastColum(:,1) == 1) == 21
            
            %             deformNeighbAvePoint(positionIndex,:) = deformBound;
            neighbBoundTanDir(12:22, :)  =   - boundTanDir;
            
        elseif find(judgeMatrixFirstColum(:,1) == 1) == 21 && find(judgeMatrixLastColum(:,1) == 1) == 11
            
            %             deformNeighbAvePoint(positionIndex,:) = flipud(deformBound);
            neighbBoundTanDir(12:22, :)  =   - flipud(boundTanDir);
            
        elseif find(judgeMatrixFirstColum(:,1) == 1) == 21 && find(judgeMatrixLastColum(:,1) == 1) == 31
            
            %             deformNeighbAvePoint(positionIndex,:) = deformBound;
            neighbBoundTanDir(23:33, :)  =   - boundTanDir;
            
        elseif find(judgeMatrixFirstColum(:,1) == 1) == 31 && find(judgeMatrixLastColum(:,1) == 1) == 21
            
            %             deformNeighbAvePoint(positionIndex,:) = flipud(deformBound);
            neighbBoundTanDir(23:33, :)  =   - flipud(boundTanDir);
            
        elseif find(judgeMatrixFirstColum(:,1) == 1) == 31 && find(judgeMatrixLastColum(:,1) == 1) == 1
            
            %             deformNeighbAvePoint(positionIndex,:) = deformBound;
            neighbBoundTanDir(34:44, :)  =   - boundTanDir;  
            
        elseif find(judgeMatrixFirstColum(:,1) == 1) == 1 && find(judgeMatrixLastColum(:,1) == 1) == 31
            
            %             deformNeighbAvePoint(positionIndex(2:end,:),:) = flipud(deformBound(2:end,:));
            neighbBoundTanDir(34:44, :)  =   - flipud(boundTanDir);
            
        end
        %% 保存旋转之后的边界切线
        
        eval(['aveTanDir_', num2str(meshOrder(indexI)), ' = ', 'neighbBoundTanDir;']);
        eval(['save aveTanDir_', num2str(meshOrder(indexI)), '.mat', ' aveTanDir_', num2str(meshOrder(indexI)), ';']);
        
    end
end


