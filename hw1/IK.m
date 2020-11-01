%%IK - returns 2 possible combinations of joints positions
function ik = IK(T0)
l0 = 670
l1 = 312
l2 = 1075
l3 = 225
l4 = 1280
l5 = 215
dl = sqrt(l3^2 + l4^2)
dq = atan2(l4, l3)

%% T123
T_base = RTmatrices.Tz(l0); T_tool = RTmatrices.Tx(l5)
T0_free = inv(T_base)*T0*inv(T_tool)
x = T0_free(1, 4); y = T0_free(2, 4); z = T0_free(3, 4)

% q1
q1 = atan2(y, x)

% q3 
Y = y/sin(q1) - l1
q3 = acos((Y^2 + z^2 - dl^2 - l2^2)/(2*l2*dl)) - dq

% q2
a = -dl*sin(q3+dq); b = -dl*cos(q3+dq) - l2
len = sqrt(a^2 + b^2)
phi = atan2(a/len, b/len)
q2 = asin(z/len) - phi

% resulting T123
T123 = RTmatrices.Rz(q1)*RTmatrices.Tx(l1)*RTmatrices.Ry(q2)*RTmatrices.Tx(l2)*RTmatrices.Ry(q3 + dq)*RTmatrices.Tx(dl)*RTmatrices.Ry(-dq)

%% T456

T456 = inv(T123)*T0_free
q456 =  E2A(T456)


ik = [q1, q2, q3, q456(1, 1), q456(1, 2), q456(1, 3);
      q1, q2, q3, q456(2, 1), q456(2, 2), q456(2, 3)]
end