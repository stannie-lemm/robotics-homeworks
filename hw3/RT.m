%defining rotation and translation matrices
classdef RT
   methods (Static)
      function rx = Rx(q)
rx = [1 0      0       0;
      0 cos(q) -sin(q) 0;
      0 sin(q) cos(q)  0; 
      0 0      0       1];
end

function rxd = Rxd(q)
rxd = [0 0         0         0;      
       0 -1*sin(q) -1*cos(q) 0;
       0 cos(q)    -1*sin(q) 0;      
       0 0         0         0];
end

function ry = Ry(q)
ry = [cos(q)    0 sin(q) 0; 
      0         1 0      0;
      -1*sin(q) 0 cos(q) 0;
      0         0 0      1];
end

function ryd = Ryd(q)
ryd = [-1*sin(q) 0 cos(q)    0;
       0         0 0         0; 
       -1*cos(q) 0 -1*sin(q) 0;
       0         0 0         0];
end

function rz = Rz(q)
rz = [cos(q) -1*sin(q) 0 0;
      sin(q) cos(q)    0 0;
      0      0         1 0;
      0      0         0 1];
end

function rzd = Rzd(q)
rzd = [-1*sin(q) -1*cos(q) 0 0;
       cos(q)    -1*sin(q) 0 0;
       0         0         0 0;
       0         0         0 0];
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

function [J] = Jcol(T)

J = [T(1:3,4);
      T(3,2);
      T(1,3);
      T(2,1)];

end
   end
end