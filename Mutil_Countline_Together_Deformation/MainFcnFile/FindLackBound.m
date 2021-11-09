%%  To find the lacked boundary of the patch
function [lackBound_1, lackBound_2, lackBound_3] = FindLackBound(initAveMeshBound, currentDeformAvePoint)

lackBound_1  =  [];
lackBound_2  =  [];
lackBound_3  =  [];


if length(find(ismember(initAveMeshBound, currentDeformAvePoint(1, :))))~=3 && length(find(ismember(initAveMeshBound, currentDeformAvePoint(11, :))))~=3
    
    lackBound_1  =  'Down';

end

if length(find(ismember(initAveMeshBound, currentDeformAvePoint(11, :))))~=3 && length(find(ismember(initAveMeshBound, currentDeformAvePoint(21, :))))~=3
    if isempty(lackBound_1) == 1
        
        lackBound_1  =  'Right';
        
    elseif isempty(lackBound_1) == 0
        
        lackBound_2 = 'Right';

    end
end


if length(find(ismember(initAveMeshBound, currentDeformAvePoint(21, :))))~=3 && length(find(ismember(initAveMeshBound, currentDeformAvePoint(31, :))))~=3
   
    if isempty(lackBound_1) == 1 
      
        lackBound_1  =  'Up';

    elseif isempty(lackBound_1) == 0 && isempty(lackBound_2) == 1
       lackBound_2  =  'Up';

    elseif  isempty(lackBound_1) == 0 && isempty(lackBound_2) == 0
        lackBound_3 =  'Up';
    end
   
end

if length(find(ismember(initAveMeshBound, currentDeformAvePoint(31, :))))~=3 && length(find(ismember(initAveMeshBound, currentDeformAvePoint(1, :))))~=3
    
    if isempty(lackBound_1) == 1 
       lackBound_1  =  'Left';

    elseif isempty(lackBound_1) == 0 && isempty(lackBound_2) == 1
       lackBound_2  =  'Left';

    elseif  isempty(lackBound_1) == 0 && isempty(lackBound_2) == 0
        lackBound_3 =  'Left';
    end
   
end