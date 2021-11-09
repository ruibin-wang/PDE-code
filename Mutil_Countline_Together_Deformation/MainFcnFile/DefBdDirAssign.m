%%% �ú�������ƥ���α�߽磬�ͱ߽����ߣ�Ŀ����Ϊ��ʹ������Ƭ������ͬ�������ı�
%%% �ú���Դ��getDeformMeshPt����

function  DefBdDirAssign(bdDirDefNum, boundPt, boundTanDir)

paraSet         =      xlsread('meshOrderAndPdePara.xlsx',1);    %% The three parameters of PDE
meshOrderSet    =      xlsread('meshOrderAndPdePara.xlsx',2);    %% the order index of the Mesh
meshOrder       =      meshOrderSet(bdDirDefNum, :);
meshOrder(find(isnan(meshOrder))) = [];    %% put the NaN element of the matrix into null
currentSheet    =      meshOrder;

%% ��Ϊ������Ƭ�ڴ���ʱ�����ʶ��ò�ͬ�ľ�ȷ�������бߵ�ƥ��
switch bdDirDefNum
    %     case
    case {1,2,3,4,5,6,7,8,9,10,11,13,14,16,17}
        precision = 6;
    case {12,15}
        precision = 7;
end

%%  �жϱ߽����������Ƭ�еķ���

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
            %%% ���߷�����������Ƭ���߷����෴
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
        %% ������ת֮��ı߽�����
        
        eval(['aveTanDir_', num2str(meshOrder(indexI)), ' = ', 'neighbBoundTanDir;']);
        eval(['save aveTanDir_', num2str(meshOrder(indexI)), '.mat', ' aveTanDir_', num2str(meshOrder(indexI)), ';']);
        
    end
end


