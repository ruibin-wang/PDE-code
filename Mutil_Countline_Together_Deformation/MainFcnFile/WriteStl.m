 function WriteStl(filename, verts, faces, isAscii)
            
            %--------------------------------------------------------------
            %clear; clc; close all;
            
            %[filename, filepath] = uigetfile('*.obj', 'Select an obj');
            
            %[verts, faces] = PolygonMesh.ReadObjMesh(fullfile(filepath, filename));
            
            %PolygonMesh.WriteStl('D:/a.stl', verts, faces, true); % Ascii format.
            %PolygonMesh.WriteStl('D:/b.stl', verts, faces, false); % Binary format
            %--------------------------------------------------------------
            
            % facet normal ni nj nk
            %    outer loop
            %        vertex v1x v1y v1z
            %        vertex v2x v2y v2z
            %        vertex v3x v3y v3z
            %    endloop
            % endfacet
            
            assert(size(faces,2) == 3);
            
            fid = fopen(filename, 'w');
            
            if isAscii
                fprintf(fid, 'solid nuomizong\n');
                
                for i=1:size(faces,1)
                    n1 = faces(i,1);
                    n2 = faces(i,2);
                    n3 = faces(i,3);
                    
                    faceNorm = Triangle.ComputeFaceNorm( ...
                        verts( n1, :), verts( n2, :), verts( n3, :) ) ;
                    
                    fprintf(fid, 'facet normal %g %g %g\n', faceNorm(1), faceNorm(2), faceNorm(3));
                    fprintf(fid, '\touter loop\n');
                    fprintf(fid, '\t\tvertex %g %g %g\n', verts(n1,1), verts(n1,2), verts(n1,3));
                    fprintf(fid, '\t\tvertex %g %g %g\n', verts(n2,1), verts(n2,2), verts(n2,3));
                    fprintf(fid, '\t\tvertex %g %g %g\n', verts(n3,1), verts(n3,2), verts(n3,3));
                    fprintf(fid, '\tendloop\n');
                    fprintf(fid,'endfacet\n');
                end
                
                fprintf(fid, 'endsolid nuomizong\n');
            else
                fwrite(fid, zeros(80,1), 'uint8');
                fwrite(fid, size(faces,1), 'uint32');
                
                for i=1:size(faces,1)
                    n1 = faces(i,1);
                    n2 = faces(i,2);
                    n3 = faces(i,3);
                    
                    faceNorm = Triangle.ComputeFaceNorm( ...
                        verts( n1, :), verts( n2, :), verts( n3, :) ) ;
                    
                    fwrite(fid, faceNorm, 'float32');
                    fwrite(fid, verts(n1,:), 'float32');
                    fwrite(fid, verts(n2,:), 'float32');
                    fwrite(fid, verts(n3,:), 'float32');
                    fwrite(fid, 0, 'uint16');
                end
                
            end % isAscii
            
            fclose(fid);
        end % end of WriteStl().