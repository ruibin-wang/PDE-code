function extPoint = extBound(middleMeshBd,MeshPt)
Mesh_2        =      evalin('caller','Mesh_2');
Mesh_3        =      evalin('caller','Mesh_3');
Mesh_4        =      evalin('caller','Mesh_4');
Mesh_5        =      evalin('caller','Mesh_5');
for i = 2:5
    if size(middleMeshBd,1) == size(MeshPt(i).DownBd,1) && isequal(floor(middleMeshBd) , floor(MeshPt(i).DownBd))
        varMesh = eval(['Mesh','_',num2str(i),';']);
        extPoint = varMesh(MeshPt(i).TransData(end-1,:),:);
        break
    elseif size(middleMeshBd,1) == size(MeshPt(i).DownBd,1) &&  isequal(floor(middleMeshBd) , floor(flipud(MeshPt(i).DownBd)))
        varMesh = eval(['Mesh','_',num2str(i),';']);
        extPoint = varMesh(MeshPt(i).TransData(end-1,:),:);
        break
    elseif size(middleMeshBd,1) == size(MeshPt(i).RightBd,1) && isequal( floor(middleMeshBd) , floor(MeshPt(i).RightBd))
        varMesh = eval(['Mesh','_',num2str(i),';']);
        extPoint = varMesh(MeshPt(i).TransData(:,end-1),:);
        break
    elseif size(middleMeshBd,1) == size(MeshPt(i).RightBd,1) && isequal( floor(middleMeshBd) , floor(flipud(MeshPt(i).RightBd)))
        varMesh = eval(['Mesh','_',num2str(i),';']);
        extPoint = varMesh(MeshPt(i).TransData(:,end-1),:);
        break
    elseif size(middleMeshBd,1) == size(MeshPt(i).UpBd,1) && isequal( floor(middleMeshBd) , floor(MeshPt(i).UpBd))
        varMesh = eval(['Mesh','_',num2str(i),';']);
        extPoint = varMesh(MeshPt(i).TransData(2,:),:);
        break
    elseif size(middleMeshBd,1) == size(MeshPt(i).UpBd,1) && isequal( floor(middleMeshBd) , floor(flipud(MeshPt(i).UpBd)))
        varMesh = eval(['Mesh','_',num2str(i),';']);
        extPoint = varMesh(MeshPt(i).TransData(2,:),:);
        break
    elseif size(middleMeshBd,1) == size(MeshPt(i).LeftBd,1) && isequal( floor(middleMeshBd) , floor(MeshPt(i).LeftBd))
        varMesh = eval(['Mesh','_',num2str(i),';']);
        extPoint = varMesh(MeshPt(i).TransData(:,2),:);
        break
    elseif size(middleMeshBd,1) == size(MeshPt(i).LeftBd,1) && isequal( floor(middleMeshBd) , floor(flipud(MeshPt(i).LeftBd)))
        varMesh = eval(['Mesh','_',num2str(i),';']);
        extPoint = varMesh(MeshPt(i).TransData(:,2),:);
        break
    else 
        continue
    end
end