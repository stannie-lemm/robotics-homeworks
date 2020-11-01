%defining rotation and translation matrices
classdef RTmatrices
   methods (Static)
      function rx = Rx(q)
        rx = [1 0      0       0;
              0 cos(q) -sin(q) 0;
              0 sin(q) cos(q)  0; 
              0 0      0       1];
      end

       function ry = Ry(q)
        ry = [cos(q)    0 sin(q) 0; 
              0         1 0      0;
              -1*sin(q) 0 cos(q) 0;
              0         0 0      1];
       end

        function rz = Rz(q)
        rz = [cos(q) -1*sin(q) 0 0;
              sin(q) cos(q)    0 0;
              0      0         1 0;
              0      0         0 1];
        end

        function tx = Tx(l)
        tx = [1 0 0 l; 
              0 1 0 0; 
              0 0 1 0; 
              0 0 0 1];
        end

        function ty = Ty(l)
        ty = [1 0 0 0;
              0 1 0 l;
              0 0 1 0;
              0 0 0 1];
        end

        function tz = Tz(l)
        tz = [1 0 0 0;
              0 1 0 0;
              0 0 1 l;
              0 0 0 1];
        end
   end
end